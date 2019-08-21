
import 'DataProviderInterface.dart';
import 'package:flutter/services.dart' show rootBundle;

class MockDataProvider implements DataProviderInterface {


  @override
  Future<String> getIssuedNotes() async {
    var returnValue = await rootBundle.loadString('assets/mockdata/issuednotes.json');

    return returnValue;
  }
  Future<String> getAllOffers() async {
    var returnValue = await rootBundle.loadString('assets/mockdata/alloffers.json');

    return returnValue;
  }
  Future<String> getMLGICOffers() async {
    var returnValue = await rootBundle.loadString('assets/mockdata/mlgicoffers.json');

    return returnValue;
  }
  Future<String> getPPNOffers() async {
    var returnValue = await rootBundle.loadString('assets/mockdata/ppnoffers.json');

    return returnValue;
  }
  Future<String> getPAROffers() async {
    var returnValue = await rootBundle.loadString('assets/mockdata/paroffers.json');

    return returnValue;
  }
  Future<String> getNewsletterMetadata() async {
    var returnValue = await rootBundle.loadString('assets/mockdata/newslettermetadata.json');

    return returnValue;
  }
  Future<String> getFaqPDFMetadata() async {
    var returnValue = await rootBundle.loadString('assets/mockdata/faqmetadata.json');

    return returnValue;
  }
  Future<String> getNoteDetails(int noteId) async {
    var returnValue = await rootBundle.loadString('assets/mockdata/notedetails.json');

    return returnValue;
  }
  Future<String> getNoteDetailsTab2(int noteId) async {
    var returnValue = await rootBundle.loadString('assets/mockdata/notedetailstab2.json');

    return returnValue;
  }
  Future<String> compareNotes(int noteId1, int noteId2, int noteId3) async {
    var returnValue = await rootBundle.loadString('assets/mockdata/comparenotes.json');

    return returnValue;
  }
}
