class SNFilterData {
  String listType;
  List<NoteColumn> mNotesColumn;

  SNFilterData({
    this.listType,
    this.mNotesColumn,
  });

  factory SNFilterData.fromJson(Map<String, dynamic> json) => SNFilterData(
        listType: json["listType"],
        mNotesColumn: List<NoteColumn>.from(
            json["noteColumns"].map((x) => NoteColumn.fromJson(x))),
      );
}

class NoteColumn {
  String noteCategory;
  String noteName;
  String fundServ;
  String availableUntil;
  String term;
  String issueDate;
  String maturityDate;
  String minInvest;
  String howToBuy;
  String productType;
  String productSubType;
  String cusip;
  String adpCode;
  String warningTip;
  String dealId;
  String fClass;
  String currency;
  String assetClass;
  String geography;
  String specialProductType;
  String structure;
  String status;

  NoteColumn({
    this.noteCategory,
    this.noteName,
    this.fundServ,
    this.availableUntil,
    this.term,
    this.issueDate,
    this.maturityDate,
    this.minInvest,
    this.howToBuy,
    this.productType,
    this.productSubType,
    this.cusip,
    this.adpCode,
    this.warningTip,
    this.dealId,
    this.fClass,
    this.currency,
    this.assetClass,
    this.geography,
    this.specialProductType,
    this.structure,
    this.status,
  });

  factory NoteColumn.fromJson(Map<String, dynamic> json) => NoteColumn(
        noteCategory: json["noteCategory"],
        noteName: json["noteName"],
        fundServ: json["fundServ"],
        availableUntil: json["availableUntil"],
        term: json["term"],
        issueDate: json["issueDate"],
        maturityDate: json["maturityDate"],
        minInvest: json["minInvest"],
        howToBuy: json["howToBuy"],
        productType: json["productType"],
        productSubType: json["productSubType"],
        cusip: json["cusip"],
        adpCode: json["adpCode"],
        warningTip: json["warningTip"],
        dealId: json["dealId"],
        fClass: json["fClass"],
        currency: json["currency"],
        assetClass: json["assetClass"],
        geography: json["geography"],
        specialProductType: json["specialProductType"],
        structure: json["structure"],
        status: json["status"],
      );
}
