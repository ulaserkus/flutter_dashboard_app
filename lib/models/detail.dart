class DetailModel {
  double patient;
  double death;
  double cure;
  String addedTime;
  int countryId;

  DetailModel(
      {this.patient, this.death, this.cure, this.addedTime, this.countryId});

  factory DetailModel.fromJson(Map<String, dynamic> json) {
    return DetailModel(
        patient: json["patient"],
        death: json["death"],
        cure: json["cure"],
        addedTime: json["addedTime"],
        countryId: json["countryId"]);
  }
}
