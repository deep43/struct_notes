

class Contact {
  String firstName;
  String lastName;
  String role;
  String phoneNumber;
  String email;
  DateEffective dateEffective;
  bool showFlag;

  Contact({
    this.firstName,
    this.lastName,
    this.role,
    this.phoneNumber,
    this.email,
    this.dateEffective,
    this.showFlag,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        firstName: json["firstName"],
        lastName: json["lastName"],
        role: json["role"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        dateEffective: dateEffectiveValues.map[json["dateEffective"]],
        showFlag: json["showFlag"],
      );

  /*Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
        "role": role,
        "phoneNumber": phoneNumber,
        "email": email,
        "dateEffective": dateEffectiveValues.reverse[dateEffective],
        "showFlag": showFlag,
      };*/
}

enum DateEffective { MAR_212019 }

final dateEffectiveValues =
    EnumValues({"Mar 21, 2019": DateEffective.MAR_212019});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
