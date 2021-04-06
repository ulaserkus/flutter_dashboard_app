class LineModel {
  List<String> totalDeathsByDate;
  List<String> totalCuresByDate;
  List<String> totalPatientsByDate;
  List<String> dates;

  LineModel(
      {this.totalDeathsByDate,
      this.totalCuresByDate,
      this.totalPatientsByDate,
      this.dates});

  factory LineModel.fromJson(json) {
    var restDeath = json['totalDeathsByDate'] as List;
    var restCure = json['totalCuresByDate'] as List;
    var restPatient = json['totalPatientsByDate'] as List;
    var restDates = json['dates'] as List;

    Iterable list = restDeath.map((json) => json.toString()).toList();
    Iterable list2 = restCure.map((json) => json.toString()).toList();
    Iterable list3 = restPatient.map((json) => json.toString()).toList();
    Iterable list4 = restDates.map((json) => json.toString()).toList();

    return LineModel(
        totalDeathsByDate: list,
        totalCuresByDate: list2,
        totalPatientsByDate: list3,
        dates: list4);
  }
}
