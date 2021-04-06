
class Values{
  double totalPatient;
  double totalDeaths;
  double totalCure;
  double total;

  Values({this.totalPatient,this.totalDeaths,this.totalCure,this.total});


  factory Values.fromJson(Map<String,dynamic>json){

    return Values(
      totalPatient: json['totalPatient'],
      totalDeaths: json['totalDeaths'],
      totalCure: json['totalCure'],
      total: json['total']
    );
  }

}