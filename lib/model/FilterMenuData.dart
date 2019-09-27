class FilterMenuData{

  String menuName;

  List<MenuItem> subMenuItems;
  FilterMenuData(this.menuName, this.subMenuItems);

}

class MenuItem{
  String itemTitle;
  List<String> selectedValues;
  String id;
  String key;
  MenuItem(this.id,this.key,this.itemTitle);
}