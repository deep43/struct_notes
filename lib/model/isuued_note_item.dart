class IssuedNote {
  final String dealId;
  final String noteCategory;
  final String noteName;
  final String fundServ;
  final String availableUntil;
  final String term;
  final String issueDate;
  final String maturityDate;
  final String minInvest;
  final String howToBuy;
  final String productType;
  final String productSubType;
  final String cusip;
  final String adpCode;
  final String fClass;
  final String currency;
  final String assetClass;
  final String geography;
  final String specialProductType;
  final String structure;

  IssuedNote(
              {
                this.dealId,
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
                this.fClass,
                this.currency,
                this.assetClass,
                this.geography,
                this.specialProductType,
                this.structure
              }
          );


  factory IssuedNote.fromJson(Map<String, dynamic> json) {
       return IssuedNote(
         dealId: json['dealId'],
         noteCategory: json["noteCategory"],
         noteName: json["noteName"],
         fundServ: json["fundServ"],
         availableUntil: json["availableUntil"] as String,
         term: json["term"] as String,
         issueDate: json["issueDate"] as String,
         maturityDate: json["maturityDate"] as String,
         minInvest: json["minInvest"] as String,
         howToBuy: json["howToBuy"] as String,
         productType: json["productType"] as String,
         productSubType: json["productSubType"] as String,
         cusip: json["cusip"] as String,
         adpCode: json["adpCode"] as String,
         fClass: json["fClass"] as String,
         currency: json["currency"] as String,
         assetClass: json["assetClass"] as String,
         geography: json["geography"] as String,
         specialProductType: json["specialProductType"] as String,
         structure: json["structure"] as String,
       );
  }

}