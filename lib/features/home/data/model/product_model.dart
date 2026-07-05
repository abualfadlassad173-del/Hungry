class ProductModel {
  final int id;
  final String name;
  final String desc;
  final String rating;
  final String image;
  final String price;

  const ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.desc,
    required this.rating,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      desc: json['description'],
      image: json['image'],
      rating: json['rating'],
      price: json['price'],
    );
  }
}
