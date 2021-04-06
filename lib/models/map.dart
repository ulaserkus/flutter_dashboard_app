class MapModel {
  double latitude;
  double longitude;
  String color;
  double patient;

  MapModel({this.latitude, this.longitude, this.color, this.patient});

  factory MapModel.fromJson(Map<String, dynamic> json) {
    return MapModel(
        latitude: json["latitude"],
        longitude: json["longitude"],
        color: json["color"],
        patient: json["patient"]);
  }
}
