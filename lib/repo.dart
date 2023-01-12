// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);


class Product {
  final String title;
  final String description;
  final String imageUrl;
  final double price;

  Product({required this.title, required this.description, required this.imageUrl, required this.price});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      description: json['description'],
      imageUrl: json['image_url'],
      price: json['price'],
    );
  }
}