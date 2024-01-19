class ChargingStation {
  final String id;
  final String title;
  String img;
  String address;
  String coordinates;
  String number;
  String type;
  final List<String> features;
  bool liked;

  ChargingStation({
    required this.id,
    required this.title,
    this.img = "",
    this.address = "",
    this.coordinates = "",
    this.number = "",
    required this.type,
    required this.features,
    this.liked = false,
  });

  factory ChargingStation.fromJson(Map<String, dynamic> json) {
    return ChargingStation(
      id: json['_id'] ?? "",
      title: json['title'] ?? "",
      img: json['img'] ?? "",
      address: json['address'] ?? "",
      coordinates: json['coordinates'] ?? "",
      number: json['number'] ?? "",
      type: json['type'] ?? "",
      features: List<String>.from(json['features'] ?? ""),
    );
  }
}
