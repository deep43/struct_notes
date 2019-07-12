import 'FilterMenuData.dart';

//class AppliedFilterData{
//
//  static final AppliedFilterData _AppliedFilterData = new AppliedFilterData._private();
//
//  factory AppliedFilterData() {
//    return _AppliedFilterData;
//  }
//
//  AppliedFilterData._private();
//  static AppliedFilterData get instance => _AppliedFilterData;
//
//
//  List<MenuItem> appliedSubMenu = new List();
//  IssueDateData issueDateData = IssueDateData();
//  MaturityDate maturityDate = MaturityDate();
//
//}

class AppliedFilterData{

  List<MenuItem> appliedSubMenu = new List();
  IssueDateData issueDateData = IssueDateData();
  MaturityDate maturityDate = MaturityDate();

}
class FilterKeyword{
  String keyword = "";
}
class IssueDateData{
  String issuedFrom ="";
  String issuedTo = "";
}

class MaturityDate{
  String maturityFrom = "";
  String maturityTo = "";
}