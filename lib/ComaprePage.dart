import 'package:flutter/material.dart';
import 'package:structured_notes/model/OfferingsData.dart';
import 'package:structured_notes/util/Theme.dart';

class ComparePage extends StatelessWidget {
  List<SNData> compareItems;

  ComparePage({this.compareItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          iconTheme: IconThemeData(color: accentColor),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              defaultColumnWidth: IntrinsicColumnWidth(),
              children: _getTableRows(compareItems),
            ),
          ),
        ));
  }

  List<TableRow> _getTableRows(List<SNData> compareItems) {
    List<TableRow> rows = List();
    if (compareItems.length > 0) {
      rows.add(
        TableRow(
          children: _getHeaderRow(compareItems),
        ),
      );

      int maxRows = 0;

      compareItems.forEach((item) {
        if (item.snItems.length > maxRows) {
          maxRows = item.snItems.length;
        }
      });

      for (int i = 0; i < maxRows; i++) {
        List<SNItem> _offeringItemList = List();
        compareItems.forEach((compareItems) {
          if (compareItems.snItems.length > i) {
            _offeringItemList.add(compareItems.snItems[i]);
          } else {
            _offeringItemList.add(SNItem("-----", "-----"));
          }
        });
        rows.add(TableRow(children: _getChildrenRow(_offeringItemList)));
      }
    }

    return rows;
  }

  List<TableCell> _getHeaderRow(List<SNData> items) {
    List<TableCell> cells = List();

    items.forEach((item) {
      cells.add(TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.center,
              child: Text(
                item.title,
                style: TextStyle(color: accentColor),
              )),
        ),
      ));
    });
    return cells;
  }

  List<TableCell> _getChildrenRow(List<SNItem> items) {
    List<TableCell> cells = List();

    items.forEach((item) {
      cells.add(TableCell(
        verticalAlignment: TableCellVerticalAlignment.middle,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    item.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    item.value,
                  ),
                ],
              )),
        ),
      ));
    });
    return cells;
  }
}
