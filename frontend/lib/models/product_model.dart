class Product {
  int id;
  String name;
  String description;
  double price;
  String image;
  // List<Category> categories;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      image: json['image'],
    );
  }

  // factory Product.fromJson(Map<String, dynamic> json) {
  //   return Product(
  //     id: json['id'],
  //     name: json['name'],
  //     description: json['description'],
  //     price: json['price'],
  //     image: json['image'],
  //     categories: json['categories'] != null
  //         ? List<Category>.from(
  //             json['categories'].map((category) => Category.fromJson(category)))
  //         : null,
  //   );
  // }
}
