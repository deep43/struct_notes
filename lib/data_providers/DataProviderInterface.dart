class DataProviderInterface {
  Future<String> getIssuedNotes() {
    throw new Exception("Should use concrete actual class");
  }
  Future<String> getAllOffers() {
    throw new Exception("Should use concrete actual class");
  }
  Future<String> getMLGICOffers() {
    throw new Exception("Should use concrete actual class");
  }
  Future<String> getPPNOffers() {
    throw new Exception("Should use concrete actual class");
  }
  Future<String> getPAROffers() {
    throw new Exception("Should use concrete actual class");
  }
  Future<String> getNewsletterMetadata() {
    throw new Exception("Should use concrete actual class");
  }
  Future<String> getFaqPDFMetadata() {
    throw new Exception("Should use concrete actual class");
  }
  Future<String> getNoteDetails(int noteId) {
    throw new Exception("Should use concrete actual class");
  }
  Future<String> getNoteDetailsTab2(int noteId) {
    throw new Exception("Should use concrete actual class");
  }
  Future<String> compareNotes(int noteId1, int noteId2, int noteId3) {
    throw new Exception("Should use concrete actual class");
  }
}