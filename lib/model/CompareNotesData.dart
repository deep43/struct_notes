
//=============================== Response model data class ====================================//

class CompareNotesData {
  String compareCount;
  Results results;

  CompareNotesData({
    this.compareCount,
    this.results,
  });

  factory CompareNotesData.fromJson(Map<String, dynamic> json) => CompareNotesData(
    compareCount: json["compareCount"],
    results: Results.fromJson(json["results"]),
  );

  /*Map<String, dynamic> toJson() => {
    "compareCount": compareCount,
    "results": results.toJson(),
  };*/
}

class Results {
  Header header;
  List<CompareRow> row;

  Results({
    this.header,
    this.row,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    header: Header.fromJson(json["header"]),
    row: List<CompareRow>.from(json["row"].map((x) => CompareRow.fromJson(x))),
  );

  /*Map<String, dynamic> toJson() => {
    "header": header.toJson(),
    "row": List<dynamic>.from(row.map((x) => x.toJson())),
  };*/
}

class Header {
  List<String> heading;

  Header({
    this.heading,
  });

  factory Header.fromJson(Map<String, dynamic> json) => Header(
    heading: List<String>.from(json["heading"].map((x) => x)),
  );

 /* Map<String, dynamic> toJson() => {
    "heading": List<dynamic>.from(heading.map((x) => x)),
  };*/
}

class CompareRow {
  List<String> col;

  CompareRow({
    this.col,
  });

  factory CompareRow.fromJson(Map<String, dynamic> json) => CompareRow(
    col: List<String>.from(json["col"].map((x) => x)),
  );

  /*Map<String, dynamic> toJson() => {
    "col": List<dynamic>.from(col.map((x) => x)),
  };*/
}
