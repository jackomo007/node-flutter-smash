const admin = require("firebase-admin");
const csv = require("csv-parser");
const fs = require("fs");

const serviceAccount = require("./smash.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const db = admin.firestore();

async function importData() {
  const countriesRef = db.collection("countries");
  let batch = db.batch();
  const countryMap = new Map();
  let batchCounter = 0;

  fs.createReadStream("./data/world-cities.csv")
    .pipe(csv())
    .on("data", (row) => {
      if (!countryMap.has(row.country)) {
        const countryDocRef = countriesRef.doc(row.country);
        batch.set(countryDocRef, { name: row.country });
        countryMap.set(row.country, countryDocRef);
        batchCounter++;
      }

      const cityRef = countryMap.get(row.country).collection("cities").doc();
      batch.set(cityRef, {
        name: row.name,
        subcountry: row.subcountry,
        geonameid: row.geonameid,
      });
      batchCounter++;

      if (batchCounter >= 495) {
        // Keeping it below 500 to avoid limit issues
        // Commit the batch and start a new one
        batch
          .commit()
          .then(() => {
            console.log("Batch committed.");
          })
          .catch((error) => {
            console.error("Error writing batch: ", error);
          });
        batch = db.batch();
        batchCounter = 0;
      }
    })
    .on("end", () => {
      if (batchCounter > 0) {
        batch
          .commit()
          .then(() => {
            console.log("Final batch committed. Import finished.");
          })
          .catch((error) => {
            console.error("Error writing final batch: ", error);
          });
      } else {
        console.log("Import finished with no remaining batch to commit.");
      }
    });
}

importData();
