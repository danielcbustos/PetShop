import 'package:frontend/models/product_model.dart';

class Category {
  String id;
  String name;
  List<Product> products;
  Category(this.id, this.name, this.products);

  // factory Category.fromJson(Map<String, dynamic> json) {
  //   return Category(
  //     id: json['id'],
  //     name: json['name'],
  //     products: json['products'] != null
  //         ? List<Product>.from(
  //             json['products'].map((product) => Product.fromJson(product)))
  //         : null,
  //   );
  // }
}
