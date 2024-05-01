const fs = require("fs");
const csv = require("csv-parser");
const countryDataAccess = require("./countryDataAccess");

class CSVImportService {
  constructor() {
    this.countryDataAccess = countryDataAccess;
  }

  async importData(filePath) {
    const countryMap = new Map();
    let batch = this.countryDataAccess.createBatch();
    let batchCounter = 0;

    return new Promise((resolve, reject) => {
      fs.createReadStream(filePath)
        .pipe(csv())
        .on("data", async (row) => {
          let countryDocRef;
          if (!countryMap.has(row.country)) {
            countryDocRef = await this.countryDataAccess.addCountryIfNotExists(row.country);
            countryMap.set(row.country, countryDocRef);
            batch.set(countryDocRef, { name: row.country });
            batchCounter++;
          } else {
            countryDocRef = countryMap.get(row.country);
          }

          const city = { name: row.name, subcountry: row.subcountry, geonameid: row.geonameid };
          batch.set(countryDocRef.collection("cities").doc(), city);
          batchCounter++;

          if (batchCounter >= 495) {
            await this.countryDataAccess.commitBatch(batch);
            batch = this.countryDataAccess.createBatch();
            batchCounter = 0;
          }
        })
        .on("end", async () => {
          if (batchCounter > 0) {
            await this.countryDataAccess.commitBatch(batch);
            console.log("Final batch committed. Import finished.");
            resolve();
          } else {
            console.log("Import finished with no remaining batch to commit.");
            resolve();
          }
        })
        .on("error", (error) => {
          reject(error);
        });
    });
  }
}

module.exports = CSVImportService;
