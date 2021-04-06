class Percantage{
  List<String> percantageValues;
  List<String> countryNames;



 Percantage({this.percantageValues,this.countryNames});


 factory Percantage.fromJson(json){

   var  restPer = json['percantageValues'] as List;
   var restCou = json['countryName'] as List;

   Iterable list = restPer.map((json) =>json.toString()).toList();
   Iterable list2 = restCou.map((json) =>json.toString()).toList();

   return Percantage(
       countryNames:list2,
     percantageValues: list
   );
 }



}