class Inserts {
  double totalPatient;
  double totalDeaths;
  double totalCure;
  double total;

  Inserts({this.totalPatient, this.totalDeaths, this.totalCure, this.total});

  factory Inserts.fromJson(Map<String, dynamic> json) {
    return Inserts(
        totalPatient: json['totalPatient'],
        totalDeaths: json['totalDeaths'],
        totalCure: json['totalCure'],
        total: json['total']);
  }
}
