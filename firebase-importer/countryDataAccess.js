class CountryDataAccess {
    constructor(db) {
      this.db = db;
      this.countriesRef = this.db.collection("countries");
    }
  
    async addCountryIfNotExists(countryName) {
      const countryDocRef = this.countriesRef.doc(countryName);
      const doc = await countryDocRef.get();
      if (!doc.exists) {
        await countryDocRef.set({ name: countryName });
        return countryDocRef;
      }
      return doc.ref;
    }
  
    async addCity(countryDocRef, city) {
      const cityRef = countryDocRef.collection("cities").doc();
      return cityRef.set(city);
    }
  
    createBatch() {
      return this.db.batch();
    }
  
    commitBatch(batch) {
      return batch.commit();
    }
  }
  
  module.exports = CountryDataAccess;
  