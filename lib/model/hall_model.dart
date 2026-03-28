class HallModel {
  String name;
  String image;
  String location;
  double rating;
  double price;
  bool isBooked;

  HallModel({
    required this.name,
    required this.image,
    required this.location,
    required this.rating,
    required this.price,
    this.isBooked = false, 
  });
}