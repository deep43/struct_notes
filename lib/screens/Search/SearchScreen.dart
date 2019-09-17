import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:structured_notes/data_providers/DataProvider.dart';
import 'package:structured_notes/data_providers/DataProviderInterface.dart';
import 'package:structured_notes/model/OfferingsData.dart';
import 'package:structured_notes/model/issues_notes_data.dart';
import 'package:structured_notes/model/isuued_note_item.dart';
import 'package:structured_notes/util/SNListWidget.dart';
import 'package:structured_notes/util/Theme.dart';

final DataProviderInterface _dataProvider = DataProvider().getDataProvider();
String mWords;
bool isSearchComplete=false;


class SearchScreen extends StatefulWidget {
  String searchKeywords;
  bool isSearchComplete=false;

  SearchScreen({Key key, this.searchKeywords, this.isSearchComplete}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<SNData> searchDataList = new List();
  NotesData notesData;
  List<IssuedNote> searchNoteList;

  @override
  void initState() {
    super.initState();

    getSearchResult(widget.searchKeywords);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Search Results",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              fontFamily: 'assets/fonts/Whitney-Medium-Pro.ttf'),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: accentColor),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
                child: MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: SNListWidget(
                  isItemSelectable: false, listData: searchDataList),
            ))
          ],
        ),
      ),
    );
  }

  Future getSearchResult(String searchKeywords) async {
    mWords = searchKeywords;
    try {
      await _dataProvider.getSearchResultJson().then(processData);
    } catch (e) {
      print('debuggg111111333333 calling getSearchResult() - error: ' +
          e.toString());
    }
  }

  Future processData(String value) {
    var results = json.decode(value.toString());
    notesData = new NotesData.fromJson(results);

    searchNoteList = notesData.data.noteColumns;

    setState(() {
      // searchDataList = getSearchItems(populateListData(searchNoteList), mWords);

      searchDataList = populateListData(searchNoteList, mWords);
      widget.isSearchComplete=true;
    });
  }

  List<SNData> populateListData(
      List<IssuedNote> issuedNoteList, String mWords) {
    List<SNData> _snDataList = new List();
    for (var i = 0; i < issuedNoteList.length; i++) {
      IssuedNote note = issuedNoteList[i];
//      print("getIssuedNotes Item debug: " + i.toString() + note.noteName.toString());

      if (note.noteName.contains(mWords) ||
          note.issueDate.contains(mWords) ||
          note.fundServ.contains(mWords) ||
          note.availableUntil.contains(mWords) ||
          note.term.contains(mWords) ||
          note.issueDate.contains(mWords) ||
          note.maturityDate.contains(mWords) ||
          note.minInvest.contains(mWords) ||
          note.howToBuy.contains(mWords)) {
        _snDataList.add(
          SNData(
            note.noteName,
            note.issueDate,
            new List.of(
              [
                SNItem("FundSERV", note.fundServ),
                SNItem("Avail Until", note.availableUntil),
                SNItem("Term", note.term),
                SNItem("Issue Date", note.issueDate),
                SNItem("Maturity Date", note.maturityDate),
                SNItem("Min Investment", note.minInvest),
                SNItem("How to Buy", note.howToBuy),
              ],
            ),
          ),
        );
      }
    }

    return _snDataList;
  }

}
