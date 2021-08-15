
import { Request, Response } from 'express';
import { Post } from 'firebase-backend';
import { GoodWalletBookkeeper } from '../../system/goodWalletBookkeeper';
import { getPayload } from '../../system/helperFunctions';
import { StatusCodes } from 'http-status-codes';
import { ResponseHandler } from '../../system/responseHandler';
import { FirestoreManager } from '../../system/firestoreManager';

const admin = require("firebase-admin");
const db = admin.firestore();
const cors = require('cors');

// enable short hand for console.log()
function log(message: string) { console.log(`bookkeepMoneyTransfer | ${message}`); }

export default new Post((request: Request, response: Response) => {
    cors()(request, response, async () => {


        try {
            log("Calling function with request body:");
            let data: any = getPayload(request.body);
            console.log(data);

            // TODO: Check whether input request is valid!

            const gwBookkeeper = new GoodWalletBookkeeper(db);
            const dbHandler = new FirestoreManager(db);

            const transferDetails = data["transferDetails"];
            const type = data["type"];

            let docRef = dbHandler.createMoneyTransferDocument();
            data["createdAt"] = admin.firestore.FieldValue.serverTimestamp();
            data["transferId"] = docRef.id;

            // prepare return Data
            let returnData: any = { transferId: docRef.id };

            ///////////////////////////////////////////////////////////////
            // Donation
            if (type === "User2Project") {
                // need to run a transaction here because we need to 
                // fetch a file before writing back to the db
                const senderId = transferDetails["senderId"];
                const amount = transferDetails["amount"];
                const sourceType = transferDetails["sourceType"];
                const projectInfo = data["projectInfo"];

                try {
                    await db.runTransaction(async (t: any) => {
                        const totalDonationChange = await gwBookkeeper.updateStatsOnDonation(t, senderId, amount, sourceType, projectInfo);
                        returnData = { ...returnData, ...totalDonationChange };
                        t.set(docRef, data);
                    });
                } catch (e) {
                    log(`Transaction failure: ${e}`); // log error
                    throw e; // and rethrow
                }
            }

            ////////////////////////////////////////////////////////////
            // Money Pool Contribution
            if (type === "User2MoneyPool") {
                const senderId = transferDetails["senderId"];
                const amount = transferDetails["amount"];
                const moneyPoolInfo = data["moneyPoolInfo"];
                const moneyPoolId = moneyPoolInfo["moneyPoolId"];

                try {
                    await db.runTransaction(async (t: any) => {
                        await gwBookkeeper.updateStatsOnMoneyPoolContribution(t, moneyPoolId, moneyPoolInfo, amount, senderId);
                        t.set(docRef, data);
                    });
                } catch (e) {
                    log(`Transaction failure: ${e}`); // log error
                    throw e;
                }
            }

            /////////////////////////////////////////////////////////////////
            // Peer 2 Peer Transfer
            if (type === "User2User") {
                // can run batch here (cause we only need write operations) 
                // batch hasa the advantage that it works offline
                const batch = db.batch();
                const recipientId = transferDetails["recipientId"];
                const senderId = transferDetails["senderId"];
                const amount = transferDetails["amount"];

                // Need to distinguish one more case here, that is
                // commitment transfers, where the user pledges
                // money to his own Good Wallet, from money 
                // sent from user A to user B 
                if (senderId == recipientId) {
                    gwBookkeeper.updateStatsOnUser2OwnGoodWalletTransfer(batch, senderId, amount).catch(() => log("Error: Could not add updates of user to own good wallet transfer documents to batch commit)"));
                    // Add field to money transfer document to easily identify that this was a pledge
                    data["pledge"] = true;
                } else {
                    gwBookkeeper.updateStatsOnUser2UserSentTransfer(batch, recipientId, senderId, amount)
                        .catch(() => log("Error: Could not add updates of user to user transfer documents to batch commit)"));
                }
                batch.set(docRef, data);

                // await all async calls
                await batch.commit();
            }


            response.status(StatusCodes.OK).send(
                ResponseHandler.returnData(returnData)
            );

        } catch (error) {
            log(error);
            response.status(StatusCodes.INTERNAL_SERVER_ERROR).send(ResponseHandler.returnError(error.message));
        }

    });


}
);



