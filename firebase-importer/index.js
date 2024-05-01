const db = require("./firebaseconfig");
const CountryDataAccess = require("./countryDataAccess");
const CSVImportService = require("./csvImportService");

const countryDataAccess = new CountryDataAccess(db);
const csvImportService = new CSVImportService(countryDataAccess);

csvImportService.importData("./data/world-cities.csv")
  .then(() => console.log("Data import completed successfully."))
  .catch((error) => console.error("Data import failed:", error));
