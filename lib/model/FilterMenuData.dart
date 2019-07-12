class FilterMenuData{

  String menuName;

  List<MenuItem> subMenuItems;
  FilterMenuData(this.menuName, this.subMenuItems);

}

class MenuItem{
  String itemTitle;
  int id;
  MenuItem(this.id,this.itemTitle);
}