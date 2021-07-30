import { firestore } from 'firebase-admin';
import { FirestoreManager } from './firestoreManager';

const admin = require("firebase-admin");

// enable short hand for console.log()
function log(message: string) { console.log(`GoodWalletBookkeeper | ${message}`); }

/**
 * A class that takes care of updating firestore documents
 *  regarding good wallet statistics
 */
export class GoodWalletBookkeeper {

    db: firestore.Firestore;
    dbManager: FirestoreManager;

    constructor(
        db: firestore.Firestore,
    ) {
        this.db = db;
        this.dbManager = new FirestoreManager(db);
    }

    async updateStatsOnUser2UserTransfer(batch: any, recipientId: string, senderId: string, amount: string) {
        log("Entering bookkeepOnUser2UserTransfer()");

        const increment = admin.firestore.FieldValue.increment(amount);
        const docRefRecipient = this.dbManager.getUserSummaryStatisticsDocument(recipientId);
        const docRefSender = this.dbManager.getUserSummaryStatisticsDocument(senderId);

        batch.update(docRefSender, {
            "moneyTransferStatistics.totalSentToPeers": increment // 1. increment totalSentToPeers
        });
        batch.update(docRefRecipient, {
            currentBalance: increment,
            "moneyTransferStatistics.totalRaised": increment, // 2. Increment totalRaised
            "moneyTransferStatistics.totalRaisedViaPeer2Peer": increment // 3. Increment totalRaisedViaPeer2Peer
        });

    }

    // update summary statistics in model DonationStatistics
    async updateStatsOnDonation(transaction: any, uid: string, amountToAdd: number, sourceType: string, projectInfo: any) {
        log("Entering updateStatsOnDonation()");

        // fetch documents
        const userDocRef = this.dbManager.getUserSummaryStatisticsDocument(uid);
        const userDoc = await transaction.get(userDocRef);

        const globalStatsDocRef = this.dbManager.getGlobalStatsDocument();
        const globalStatsDoc = await transaction.get(globalStatsDocRef);

        // validate documents
        if (!userDoc.exists || !globalStatsDoc) {
            throw Error('Summary statistics document or global stats document does not exist');
        }
        const userStats = userDoc.data();
        const globalStats = globalStatsDoc.data();

        let amountToDeduct: number = 0;
        if (userStats != null) {
            log('Fetched user statistics document');

            // IMPORTANT! This if clause is crucial!
            if (sourceType === "GoodWallet") {
                // Validate request (validate whether current amount of GW is enough)
                if (!this.hasEnoughBalance(userStats["currentBalance"], amountToAdd)) {
                    throw Error("Current Good Wallet Balance is not enough to make donation");
                }
                amountToDeduct = -amountToAdd;
            }
        } else {
            throw Error("No data in summary statistics document!");
        }

        // update statistics
        this.updateUserStatsOnDonation(transaction, userDocRef, userStats, amountToAdd, amountToDeduct, projectInfo);
        this.updateGlobalStatsOnDonation(transaction, globalStatsDocRef, globalStats, amountToAdd, projectInfo);

        // return some data
        let totalDonationsBefore: number = userStats["donationStatistics"]["totalDonations"];
        let globalDonationsBefore: number = globalStats["totalDonations"]
        return {
            totalDonationsBefore: totalDonationsBefore,
            totalDonationsAfter: totalDonationsBefore + amountToAdd,
            globalDonationsBefore: globalDonationsBefore,
            globalDonationsAfter: globalDonationsBefore + amountToAdd
        };
    }

    private updateUserStatsOnDonation(transaction: any, docRef: any, docData: any,
        amountToAdd: number, amountToDeduct: number, projectInfo: any) {
        let monthlyDonations: any;
        let supportedProjects: any;

        // can't use FieldValue increment here because we want to manipulate data in an array
        // 3. increment totalDonations per project
        monthlyDonations = this.updateMonthlyDonations(docData["donationStatistics"]["monthlyDonations"], amountToAdd);
        // 4. increment totalDonations per month
        supportedProjects = this.updateSupportedProjects(docData["donationStatistics"]["supportedProjects"], amountToAdd, projectInfo);

        // Atomic updates with increment 
        const increment = admin.firestore.FieldValue.increment(amountToAdd);
        const decrement = admin.firestore.FieldValue.increment(amountToDeduct);
        transaction.update(docRef,
            {
                "currentBalance": decrement, // 1. decrement currentBalance
                "donationStatistics.totalDonations": increment, // 2. increment total donations
                "donationStatistics.monthlyDonations": monthlyDonations, // 3. update monthlyDonations array
                "donationStatistics.supportedProjects": supportedProjects // 4. update supportedProjects arraay
            })
    }

    private updateGlobalStatsOnDonation(transaction: any, docRef: any, globalStats: any, amountToAdd: number, projectInfo: any) {
        const supportedProjects = this.updateSupportedProjects(globalStats["supportedProjects"], amountToAdd, projectInfo);
        const increment = admin.firestore.FieldValue.increment(amountToAdd);
        transaction.update(docRef, {
            "supportedProjects": supportedProjects, // 5. updated global supportedProjects
            "totalDonations": increment, // 6. increment global totalDonations
        });
    }


    async updateStatsOnMoneyPoolContribution(transaction: any, moneyPoolId: string, moneyPoolInfo: any, amount: number, senderId: string) {
        log("Entering updateStatsOnMoneyPoolContribution()");

        // update contributingUsers array
        const docRef = this.dbManager.getMoneyPoolDocument(moneyPoolId);
        const doc = await transaction.get(docRef);
        if (!doc.exists) {
            throw Error('Money Pool document does not exist.');
        }

        const data = doc.data();
        if (data == null) {
            throw Error("No data in Money Pool document!");
        }

        this.updateMoneyPoolStatsOnContribution(transaction, docRef, data, amount, senderId);
        this.updateUserStatsOnContribution(transaction, amount, senderId);

    }

    private updateMoneyPoolStatsOnContribution(transaction: any, docRef: any, 
        data: any, amount: number, senderId: string) {
            const userList = data['contributingUsers'];
            const newContributingUsers = userList.map((element: any) => {
                if (element["uid"] === senderId) 
                {
                    element["contribution"] = element["contribution"] + amount;
                }
                return element;
            });
            const increment = admin.firestore.FieldValue.increment(amount);
            transaction.update(docRef,
                {
                    total: increment, // 2. increment total
                    contributingUsers: newContributingUsers, // 3. update contributing users array
                }
            );
    }

    private updateUserStatsOnContribution(transaction: any, amount: any, senderId: string) {
        const docRef = this.dbManager.getUserSummaryStatisticsDocument(senderId);
        const increment = admin.firestore.FieldValue.increment(amount);
        transaction.update(docRef, {
            "moneyTransferStatistics.totalSentToMoneyPools": increment, // 1. increment totalSentToMoneyPools of user
        });

    }

    async updateStatsOnMoneyPoolPayout(transaction: any, transfersDetails: any, moneyPool: any, deleteMoneyPool: boolean) {
        log("Entering updateStatsOnMoneyPoolPayout()");

        // update contributingUsers array
        const docRef = this.dbManager.getMoneyPoolDocument(moneyPool["moneyPoolId"]);
        const doc = await transaction.get(docRef);
        if (!doc.exists) {
            throw Error('Money Pool document does not exist.');
        }
        const data = doc.data();
        if (data == null) {
            throw Error("No data in Money Pool document!");
        }

        let totalAmount = 0;
        transfersDetails.forEach((details: any) => {
            totalAmount = totalAmount + details.amount;
            const increment = admin.firestore.FieldValue.increment(details.amount);
            const userDocRef = this.dbManager.getUserSummaryStatisticsDocument(details.recipientId);
            // update users good wallets
            transaction.update(userDocRef, {
                currentBalance: increment, // 1. increment currentBalance
                "moneyTransferStatistics.totalRaised": increment, // 2. increment totalRaised
                "moneyTransferStatistics.totalRaisedViaMoneyPool": increment // 3. increment totalRaisedViaMoneyPools
            });
        });

        if (!this.hasEnoughBalance(data["total"], totalAmount)) {
            throw Error("Total amount to be disbursed is higher than the total in the Money Pool!");
        }

        if (deleteMoneyPool === false) {
            const decrement = admin.firestore.FieldValue.increment(-totalAmount);
            transaction.update(docRef, {
                total: decrement, // 4. decrement total when money pool will be used further
            });
        }

        
    }


    addSingleMoneyTransferDocuments(transaction: any, data: any, payoutDocId: string) {
        log("Preparing list of money transfer documents");

        const transfersDetails = data["transfersDetails"];
        // Construct single money transfer documents
        // Push each money pool payout transfer to payments collection
        const moneyTransfers: any = [];
        transfersDetails.forEach((element: any) => {
            moneyTransfers.push(
                {
                    // This corresponds to a MoneyTransfer.moneyPoolPayout document
                    transferDetails: element,
                    moneyPoolInfo: {
                        moneyPoolId: data["moneyPool"]["moneyPoolId"],
                        name: data["moneyPool"]["name"],
                        total: data["moneyPool"]["total"]
                    },
                    payoutId: payoutDocId,
                    runtimeType: "moneyPoolPayoutTransfer",
                    createdAt: admin.firestore.FieldValue.serverTimestamp()
                }
            );
        });

        // add each single money transfer to batch
        moneyTransfers.forEach((element: any) => {
            const newDocRef = this.dbManager.createMoneyTransferDocument();
            element["transferId"] = newDocRef.id;
            transaction.set(newDocRef, element);
        });
    }

    //////////////////////////////////////////////////////////
    // Functions to update monthly donations and supported projects arrays!

    // update monthly donations array
    // Add monthly donation if in same month, otherwise add new element 
    // to array
    private updateMonthlyDonations(monthlyDonations: any, donation: any) {
        var foundMonth = false;
        var d = new Date();
        monthlyDonations.forEach((item: any) => {
            var firestoreDate = new Date(parseInt(item.month));
            if (firestoreDate.getFullYear() === d.getFullYear() && firestoreDate.getMonth() === d.getMonth()) {
                console.log("Adding donation to month: ", d.getMonth());
                foundMonth = true;
                item["totalDonations"] = item["totalDonations"] + donation;
            } else {
                console.log("Add new entry to monty donations for monty: ", d.getMonth());
            }
        });
        if (!foundMonth) {
            monthlyDonations.push(
                {
                    month: Date.now(), // (parsing the number of seconds that have elapsed since midnight on January 1, 1970, UTC)
                    totalDonations: donation
                }
            )
        }
        return monthlyDonations;
    }

    // update supported projects array
    // Add to total donation of supported project if project found 
    // (has already been donated to), otherwise add new element 
    // to array with donation information
    private updateSupportedProjects(supportedProjects: any, donation: number, projectInfo: any) {
        let foundProject: boolean = false;
        supportedProjects.forEach((item: any) => {
            if (item["projectInfo"]["id"] === projectInfo["id"]) {
                console.log("Adding donation to this project");
                foundProject = true;
                item["totalDonations"] = item["totalDonations"] + donation;
            } else {
                console.log("Add new entry to supported projects for project: ");
            }
        });
        if (!foundProject) {
            supportedProjects.push(
                {
                    projectInfo: projectInfo,
                    totalDonations: donation
                }
            );
        }
        return supportedProjects;
    }

    ///////////////////////////////////////////////////////////////
    // Helper and validating functions

    private hasEnoughBalance(currentBalance: number, amountToDeduct: number) {
        return currentBalance > amountToDeduct;
    }
}