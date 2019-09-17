

import 'dart:convert';

class SNPublicationData {

  int contentId;
  String title;
  String thumbnailImg;
  String effectiveDate;
  bool showFlag;

  SNPublicationData(
      {this.contentId,
      this.title,
      this.thumbnailImg,
      this.effectiveDate,
      this.showFlag});

  factory SNPublicationData.fromJson(Map<String, dynamic> json) =>
      SNPublicationData(
        contentId: json["contentId"],
        title: json["title"],
        thumbnailImg: json["thumbnailImg"],
        effectiveDate: json["effectiveDate"],
        showFlag: json["showFlag"],
      );

  List<SNPublicationData> SNPublicationDataFromJson(String str) => List<SNPublicationData>.from(json.decode(str).map((x) => SNPublicationData.fromJson(x)));
}

