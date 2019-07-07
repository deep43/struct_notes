class OfferingsData{

  String title,time;

  List<OfferingItem> offeringItems;
  OfferingsData(this.title,this.time, this.offeringItems);

}

class OfferingItem{
  String title,value;
  OfferingItem(this.title, this.value);
}