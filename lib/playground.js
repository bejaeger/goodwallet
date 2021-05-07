const { Firestore } = require('@google-cloud/firestore');

// Note, before running this file you need to export this env var
// IMPORTANT! Never share the json credentials file with anybody!
// export GOOGLE_APPLICATION_CREDENTIALS="/Users/bj/Apps/GoodWallet/good_wallet/FirestoreTests/gooddollarsmarketplace-35688a071a44.json"

//
// This is a file to test Firestore collections and behavior!
// Technically this could also be used for unit testing!...well not sure since
// this is javascript and not dart!
//

// Create a new client
const firestore = new Firestore();

async function quickstart() {
  // Obtain a document reference.
  const document = firestore.doc('posts/intro-to-firestore');

  const query =
    await firestore.collectionGroup("moneyPoolContributions").where("transferDetails.senderId", "==", "3QrVvwOmrraFMl3EaSzn6byLpFu2").orderBy("createdAt", 'desc').get();
  console.log("Read money pool contributions collection group");
  console.log(query.docs.length);

  // Delete the document.
  // await document.delete();
  // console.log('Deleted the document');

}
quickstart();
