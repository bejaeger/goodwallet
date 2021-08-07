import { Request, Response } from 'express';
import { Post } from 'firebase-backend';
import { GoodWalletBookkeeper } from '../../system/goodWalletBookkeeper';
import { getPayload } from '../../system/helperFunctions';
import { StatusCodes } from 'http-status-codes';
import { ResponseHandler } from '../../system/responseHandler';
import { FirestoreManager } from '../../system/firestoreManager';
// const functions = require('firebase-functions');

const admin = require("firebase-admin");
const db = admin.firestore();
const cors = require('cors');

// enable short hand for console.log()
function log(message: string) { console.log(`bookkeepMoneyPoolPayout | ${message}`); }


// takes money pool payout data and updates user good wallets.
// This will add the money pool payout document and also
// create single money transfer documents.
export default new Post((request: Request, response: Response) => {
    cors()(request, response, async () => {

        // TODO: Test if requested payout amount is valid!
        const dbManager = new FirestoreManager(db);
        const gwBookkeeper = new GoodWalletBookkeeper(db);

        try {

            let data = getPayload(request.body);
            log("Entering function with payload:")
            console.log(data);

            // add money pool payout to batch
            const docRef = dbManager.createMoneyPoolPayoutDocument();
            data["createdAt"] = admin.firestore.FieldValue.serverTimestamp();
            data["payoutId"] = docRef.id;

            const transfersDetails = data["transfersDetails"];
            const moneyPool = data["moneyPool"];
            const deleteMoneyPool = data["deleteMoneyPool"];

            try {
                await db.runTransaction(async (t: any) => {

                    // A. update stats for each transfersDetails document
                    await gwBookkeeper.updateStatsOnMoneyPoolPayout(t, transfersDetails, moneyPool, deleteMoneyPool);

                    // B. add single money transfer documents
                    gwBookkeeper.addSingleMoneyTransferDocuments(t, data, docRef.id);

                    // C. add full money pool payout document as well
                    t.set(docRef, data);
                });

                log(`Transaction success!`);
            } catch (e) {
                log(`Transaction failure: ${e}`); // log error
                throw e; // and rethrow
            }

            log("Responding with:")
            console.log(ResponseHandler.returnSuccess());
            response.status(StatusCodes.OK).send(
                ResponseHandler.returnSuccess()
            );

        } catch (error) {
            log(error);
            response.status(StatusCodes.INTERNAL_SERVER_ERROR).send(ResponseHandler.returnError(error.message));
        }
    });
}
);


