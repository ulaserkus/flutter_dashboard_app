class TableModel {
  String countryName;
  double patient;
  double death;
  double cure;

  TableModel({this.countryName, this.patient, this.death, this.cure});

  factory TableModel.fromJson(Map<String,dynamic>json) {
    return TableModel(
        countryName: json["countryName"],
        patient: json["patient"],
        death: json["death"],
        cure: json["cure"]
       );

  }
}
