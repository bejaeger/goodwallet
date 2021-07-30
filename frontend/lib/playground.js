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
  
  console.log("Reading summary statistics document");
  const doc = await firestore.doc('users/ptWSWNPX4xRyVsb6jwjPfff5C2B3/statistics/summaryStats').get();
  if (!doc.exists) {
    console.log('No such document!');
  } else {
    console.log('Fetched document data:');
  }


  docData = doc.data();
  monthlyDonations = doc.data()["donationStatistics"]["monthlyDonations"];
  supportedProjects = doc.data()["donationStatistics"]["supportedProjects"];
  console.log("Loop over monthly donations");

  var d = new Date();
  var donation = 7;

  //////////// ===============>
  // Version that works for monthly donations
  // Version that works! Could/should be unit tested!

  var foundMonth = false;
  monthlyDonations.forEach(function(item) {
    var firestoreDate = new Date(parseInt(item.month));
    if (firestoreDate.getFullYear() == d.getFullYear() && firestoreDate.getMonth() == d.getMonth()) {
      console.log("summing donation to month: ", d.getMonth());
      foundMonth = true;
      item["totalDonations"] = item["totalDonations"] + donation;
    } else {
      console.log("Add new entry to monty donations for monty: ", d.getMonth());
    }
  })
  if (!foundMonth) {
    monthlyDonations.push(
      {
        month: Date.now(), // (parsing the number of seconds that have elapsed since midnight on January 1, 1970, UTC)
        totalDonations: 7
      }
    )
  }


  //await firestore.doc('users/ptWSWNPX4xRyVsb6jwjPfff5C2B3/statistics/summaryStats').update(docData);
  
  ///////////////////////////////////////////////////////////////

  // ===> Now looking at supported projects list
  // Works as well!
  projectId = "OmxLhfT5QmKYDfquS6Vd";
  console.log("==> Supported Projects:");
  console.log(supportedProjects);
  foundProject = false;
  supportedProjects.forEach(function(item) {
    if (item["projectInfo"]["id"] == projectId) {
      console.log("summing donation to this project");
      foundProject = true;
      item["totalDonations"] = item["totalDonations"] + donation;
    } else {
      console.log("Add new entry to supported projects for project: ", d.getMonth());
    }
  })
  if (!foundProject) {
    supportedProjects.push(
      {
        projectInfo: {
          area: 'Super AREA',
          id: 'New Project ID',
          name: 'NAME'
        },
        totalDonations: 105
      }
    );
  }

  // update local doc data and push to firestore!
  console.log("==> New monty donations");
  console.log(monthlyDonations);
  docData["donationStatistics"]["monthlyDonations"] = monthlyDonations;

  console.log("==> New supported projects");
  console.log(supportedProjects);
  docData["donationStatistics"]["supportedProjects"] = supportedProjects;

  await firestore.doc('users/ptWSWNPX4xRyVsb6jwjPfff5C2B3/statistics/summaryStats').update(docData);
  
  // PROJECT INFO -----------------------------------------------

  console.log(projectInfo);
  console.log()


/*   const query =
    await firestore.collectionGroup("moneyPoolContributions").where("transferDetails.senderId", "==", "3QrVvwOmrraFMl3EaSzn6byLpFu2").orderBy("createdAt", 'desc').get();
  console.log("Read money pool contributions collection group");
  console.log(query.docs.length);
 */
  // Delete the document.
  // await document.delete();
  // console.log('Deleted the document');

}
quickstart();
