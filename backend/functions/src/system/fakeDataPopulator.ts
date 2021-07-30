import { firestore } from 'firebase-admin';
import * as faker from 'faker';
import { FirestoreManager } from './firestoreManager';
import admin = require("firebase-admin");
import { Constants } from './constants';

let areas: Array<String> = ["Gender Equality", "Climate Action", "Wildlife Conservation", "Human Rights", "Health and Development", "Physical Health", "Economic Growth", "Ecosystem Restoration"];

// enable short hand for console.log()
function log(message: string) { console.log(`FakeDataPopulator | ${message}`); }

/**
 * A class that helps with populating a local firestore database
 */
export class FakeDataPopulator {
  /**
   * The database to populat
   */
  db: firestore.Firestore;
  dbManager: FirestoreManager;

  constructor(
    db: firestore.Firestore,
  ) {
    faker.seed(123);
    this.db = db;
    this.dbManager = new FirestoreManager(db);
  }

  async generateFakeData() {
    log('generateFakeData');

    const generateDocument = await this.getGenerateDocument().get();

    if (!generateDocument.exists) {
      await this.createGenerateDocument();
      await this.generateGlobalStats();
      await this.generateProjects();
      await this.generateUsers();
      await this.generateMoneyPools();
      // create test user to sign in with it!
      const auth = admin.auth();
      await auth.createUser({
        email: Constants.TEST_USER_EMAIL,
        uid: Constants.TEST_USER_ID,
        password: Constants.TEST_USER_PASSWORD,
      })
        .then((userRecord) => {
          console.log('Successfully created new user:', userRecord.uid);
        })
        .catch((error) => {
          console.log('Error creating new user:', error);
        });

    }
  }

  //////////////////////////////////////////////////////////////////////////////////////
  // Functions to generate data

  private async generateGlobalStats() {
    log('generateGlobalStats');
    let globalStats = {
      'totalDonations': 0,
      'supportedProjects': [],
      'projectTopPicksIds': [],
    }
    await this.dbManager.addGlobalStatsData(globalStats);
  }

  private async generateMoneyPools() {
    log('generateMoneyPools');
    let moneyPool = {
      name: "Money Pool For Testing",
      total: 0,
      adminName: "Test User Name",
      adminUID: Constants.TEST_USER_ID,
      contributingUserIds: [Constants.TEST_USER_ID],
      contributingUsers: [
        {
          name: "Test User Name",
          contribution: 0,
          uid: Constants.TEST_USER_ID
        }
      ],
      createdAt: "",
      currency: "cad",
      description: "Great description here...this is the best money pool ever",
      invitedUserIds: [],
      invitedUsers: [],
      moneyPoolId: Constants.TEST_MONEY_POOL_ID,
      moneyPoolSettings: { showTotal: true }
    }
    await this.dbManager.createMoneyPoolDocument(moneyPool, Constants.TEST_MONEY_POOL_ID);
  }

  private async generateUsers() {
    log('generateUsers');

    for (let index = 0; index < 10; index++) {
      let fullName: string = faker.name.firstName() + ' ' + faker.name.lastName();
      let fullNameList = this.getListOfKeywordsFromString(fullName);
      let user = {
        'email': faker.internet.email(),
        'fullName': fullName,
        'searchKeywords': fullNameList,
        'userSettings': {
          'favoriteProjectIds': null,
          'friendsIds': null,
          'showDetailedStatistics': faker.datatype.boolean(),
          'showEmail': faker.datatype.boolean(),
          'showSummaryStatistics': faker.datatype.boolean(),
        }
      };

      let docId: string;
      let zero: boolean = false; // initialize users with all statistics set to zero
      // Always add these too userIds for testing function with Postman
      if (index == 0) {
        docId = await this.dbManager.createUserDocument(user, "ptWSWNPX4xRyVsb6jwjPfff5C2B3");
        zero = true;
      }
      else if (index == 1) {
        docId = await this.dbManager.createUserDocument(user, "0kQOM6fFHS9UBNFZIVV6");
        zero = true;
      }
      else docId = await this.dbManager.createUserDocument(user);
      await this.generateUserStatistics(docId, zero);
      await this.dbManager.addUid(docId);
    }
  }

  private async generateUserStatistics(userId: string, zero: boolean = false) {
    //log(`generateUserStatistics userId:${userId}`);
    let totalRaised = faker.datatype.number(1000);
    let totalRaisedViaMoneyPool = faker.datatype.number(totalRaised);
    let totalRaisedViaPeer2Peer = faker.datatype.number(totalRaised - totalRaisedViaMoneyPool);
    let totalRaisedViaSubsidiaryApp = totalRaised - totalRaisedViaMoneyPool - totalRaisedViaPeer2Peer;
    let stats = {
      'currentBalance': zero ? 0 : faker.datatype.number(100000),
      'prepaidFundBalance': zero ? 0 : faker.datatype.number(100000),
      'donationStatistics': {
        'runtimeType': 'default',
        'monthlyDonations': [],
        'supportedProjects': [],
        'totalDonations': zero ? 0 : faker.datatype.number(100000),
      },
      'moneyTransferStatistics': {
        'runtimeType': 'default',
        'totalRaised': zero ? 0 : totalRaised,
        'totalSentToPeers': zero ? 0 : faker.datatype.number(100000),
        'totalSentToMoneyPools': zero ? 0 : faker.datatype.number(100000),
        'totalRaisedViaMoneyPool': zero ? 0 : totalRaisedViaMoneyPool,
        'totalRaisedViaPeer2Peer': zero ? 0 : totalRaisedViaPeer2Peer,
        'totalRaisedViaSubsidiaryApp': zero ? 0 : totalRaisedViaSubsidiaryApp,
      }
    };
    await this.dbManager.createUserStatistics(userId, stats);
  }

  private async generateProjects() {
    log('generateProjects');
    let projectTopPicksIds: string[] = [];
    for (let index = 0; index < 30; index++) {
      let fundingGoal: number = faker.datatype.number(100000000);
      let project = {
        'area': areas[Math.floor(Math.random() * areas.length)],
        'causeType': "GlobalGivingProject",
        'contactUrl': faker.internet.domainName(),
        'fundingCurrent': fundingGoal,
        'fundingGoal': faker.datatype.number(fundingGoal),
        'globalGivingProjectId': faker.datatype.number(100000),
        'imageUrl': index % 2 == 0 ? faker.image.imageUrl(640, 640, 'people', true) : faker.image.imageUrl(640, 640, 'nature', true),
        'name': faker.name.jobDescriptor(),
        'organization': {
          'name': faker.company.companyName(),
          'url': faker.internet.url(),
        },
        'summary': faker.random.words(60),
        'totalDonations': faker.datatype.number(1000000),
      };

      let docId = await this.dbManager.createProjectDocument(project);
      await this.dbManager.addProjectId(docId);

      // user top picks feature...add to global statistics database
      if (index < 3) {
        projectTopPicksIds.push(docId);
      }

    }
    let projectTopPicks = {
      'projectTopPicksIds': projectTopPicksIds
    }
    await this.dbManager.addProjectTopPicks(projectTopPicks);
  }


  ///////////////////////////////////////////////////////////////////
  // Helper functions for creating dummy document to know whether
  // data has already been generated or not

  private async createGenerateDocument(): Promise<void> {
    log('createGenerateDocument');
    await this.getGenerateDocument().set({});
  }

  private getGenerateDocument(): firestore.DocumentReference {
    return this.db.collection('data').doc('generate');
  }

  //////////////////////////////////////////////////
  // Other helper functions
  private getListOfKeywordsFromString(str: string): Array<string> {
    if (str == null) return [];
    let splitList: Array<string> = str.split(' ');
    let searchKeywords: Array<string> = [];
    for (let i = 0; i < splitList.length; i++) {
      for (let j = 1; j <= splitList[i].length; j++) {
        searchKeywords.push(splitList[i].substring(0, j).toLowerCase());
      }
    }
    return searchKeywords;
  }

}