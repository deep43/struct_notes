import 'isuued_note_item.dart';

class NotesData{
  final IssuedNoteData data;

  NotesData({this.data});


  factory NotesData.fromJson(Map<String, dynamic> json) {
    return NotesData(
        data: IssuedNoteData.fromJson(json["data"])
    );
  }

}

class IssuedNoteData{
  final String listType;
  final List<IssuedNote> noteColumns;

  IssuedNoteData(
              {
                this.listType,
                this.noteColumns
              });
  factory IssuedNoteData.fromJson(Map<String, dynamic> json) {
      return IssuedNoteData(
          listType: json["listType"] as String,
          noteColumns: parseIssuedNotes(json)
      );
  }

  static List<IssuedNote> parseIssuedNotes(issuedNotesJson) {
    var list = issuedNotesJson['noteColumns'] as List;
    List<IssuedNote> issueNoteList = list.map((data) => IssuedNote.fromJson(data)).toList();
    return issueNoteList;
  }
}