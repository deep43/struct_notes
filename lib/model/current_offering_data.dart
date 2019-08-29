import 'package:structured_notes/model/current_item.dart';

import 'isuued_note_item.dart';

class CurrentOfferingData{
  final CuttentOfferingItemData data;

  CurrentOfferingData({this.data});


  factory CurrentOfferingData.fromJson(Map<String, dynamic> json) {
    return CurrentOfferingData(
        data: CuttentOfferingItemData.fromJson(json["noteColumns"])
    );
  }

}

class CuttentOfferingItemData{
  final String listType;
  final String noteCategory;

  final List<OfferingData> noteColumns;

  CuttentOfferingItemData(
              {
                this.listType,
                this.noteColumns,
                this.noteCategory
              });
  factory CuttentOfferingItemData.fromJson(Map<String, dynamic> json) {
      return CuttentOfferingItemData(
          listType: json["listType"] as String,
          noteColumns: parseIssuedNotes(json)
      );
  }

  static List<OfferingData> parseIssuedNotes(issuedNotesJson) {
    var list = issuedNotesJson['noteColumns'] as List;
    List<OfferingData> issueNoteList = list.map((data) => OfferingData.fromJson(data)).toList();
    return issueNoteList;
  }
}