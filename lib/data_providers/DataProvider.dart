import 'CNEDataProvider.dart';
import 'DataProviderInterface.dart';
import 'MockDataProvider.dart';

class DataProvider {
  static String environment = "dit";

  static final DataProvider _singleton = DataProvider._internal();
  factory DataProvider() {
    return _singleton;
  }
  DataProvider._internal() {
//    ... // initialization logic here
    initState();

  }
//  ... // rest of the class

  Future<void> initState() async {

  }

  DataProviderInterface getDataProvider() {
    return MockDataProvider();
//   return CNEDataProvider();
  }
}