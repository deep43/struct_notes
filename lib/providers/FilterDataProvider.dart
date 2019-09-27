import 'package:flutter/cupertino.dart';
import 'package:structured_notes/model/AppliedFilterData.dart';

class FilterDataProvider extends InheritedWidget {
  final AppliedFilterData appliedFilterData;

  FilterDataProvider({
    Key key,
    @required Widget child,
    @required this.appliedFilterData,
  }) : super(key :key,child: child);

  @override
  bool updateShouldNotify(FilterDataProvider oldWidget) =>
      appliedFilterData != oldWidget.appliedFilterData;

  static FilterDataProvider of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(FilterDataProvider);
}
