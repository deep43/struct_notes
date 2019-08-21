//import 'package:sn_flutter_api_package/cne_api.dart';
//
//import 'DataProviderInterface.dart';
//
//class CNEDataProvider implements DataProviderInterface {
//  @override
//  Future<String> getIssuedNotes() async{
//    var returnValue = await FlutterNotesAPI.getIssued();
//    return returnValue;
//  }
//  Future<String> getAllOffers() async{
//    var returnValue = await FlutterNotesAPI.getAllOffers();
//    return returnValue;
//  }
//
//  Future<String> getMLGICOffers() async{
//    await FlutterNotesAPI.getMLGICOffers().then((r) {
//      return r;
//    });
//  }
//
//  Future<String> getPPNOffers() async{
//    var returnValue = await FlutterNotesAPI.getPPNOffers();
//    return returnValue;
//  }
//
//  Future<String> getPAROffers() async{
//    var returnValue = await FlutterNotesAPI.getPAROffers();
//    return returnValue;
//  }
//  Future<String> getNewsletterMetadata() async{
//    var returnValue = await FlutterNotesAPI.getPAROffers();
//    return returnValue;
//  }
//  Future<String> getFaqPDFMetadata() async{
//    var returnValue = await FlutterNotesAPI.getPAROffers();
//    return returnValue;
//  }
//  Future<String> getNoteDetails(int noteId) async{
//    var returnValue = await FlutterNotesAPI.getNoteDetails(noteId);
//    return returnValue;
//  }
//  Future<String> getNoteDetailsTab2(int noteId) async{
//    var returnValue = await FlutterNotesAPI.getNoteDetailsTab2(noteId);
//    return returnValue;
//  }
//  Future<String> compareNotes(int noteId1, int noteId2, int noteId3) async{
//    var returnValue = await FlutterNotesAPI.compareNotes(noteId1, noteId2, noteId3);
//    return returnValue;
//  }
//}