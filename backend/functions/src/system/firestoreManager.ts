import { firestore } from 'firebase-admin';
import { FakeDataPopulator } from './fakeDataPopulator';

// enable short hand for console.log()
// function log(message: string) { console.log(`FirestoreCollectionHandler | ${message}`); }

/**
 * A class that helps with getting firestore collections
 */
export class FirestoreManager {

    db: firestore.Firestore;

    constructor(
        db: firestore.Firestore,
    ) {
        this.db = db;
    }

    getUserSummaryStatisticsDocument(uid: string) {
        return this.db.collection("users").doc(uid).collection("statistics").doc("summaryStats");
    }

    getMoneyPoolDocument(moneyPoolId: string) {
        return this.db.collection("moneyPools").doc(moneyPoolId);
    }

    async getGlobalStatsDocument() {
        let docRef = this.db.collection("globalStats").doc('summaryStats');
        if (docRef == null) {
            // this seems to be the very first time the database is used. 
            // That's a rare event. Congratulations that you read this.
            // Let's push the summary stat document:
            const populator = new FakeDataPopulator(this.db);
            await populator.addEmptyGlobalStatsDocument();
            docRef = this.db.collection("globalStats").doc('summaryStats');
        }
        return docRef;
    }

    createMoneyPoolPayoutDocument() {
        return this.db.collection("moneyPoolPayouts").doc();
    }

    createMoneyTransferDocument() {
        return this.db.collection("transfers").doc();
    }

    /////////////////////////////////////////////////////////////
    // Functions used in fakeDataPopulator

    async createProjectDocument(data: any): Promise<string> {
        let docRef = await this.db.collection('projects').add(data);
        return docRef.id
    }

    async addProjectId(projectId: string) {
        await this.db.collection('projects').doc(projectId).update({ "id": projectId });
    }

    async createUserDocument(data: any, docId: string = ""): Promise<string> {
        if (docId != "") {
            let docRef = this.db.collection('users').doc(docId);
            await docRef.set(data);
            return docId;
        } else {
            let docRef = await this.db.collection('users').add(data);
            return docRef.id;
        }
    }

    async createUserStatistics(userId: string, stats: any) {
        let docRef = this.db.collection('users').doc(userId).collection('statistics').doc('summaryStats');
        await docRef.set(stats);
    }

    async addUid(userId: string) {
        await this.db.collection('users').doc(userId).update({ "uid": userId });
    }

    async addGlobalStatsData(data: any) {
        await this.db.collection('globalStats').doc("summaryStats").set(data);
    }

    async addProjectTopPicks(data: any) {
        await this.db.collection('globalStats').doc("summaryStats").update(data);
    }

    async createMoneyPoolDocument(data: any, docId: string = "") {
        if (docId != "") {
            let docRef = this.db.collection('moneyPools').doc(docId);
            await docRef.set(data);
            return docId;
        } else {
            let docRef = await this.db.collection('moneyPools').add(data);
            return docRef.id;
        }
    }

}