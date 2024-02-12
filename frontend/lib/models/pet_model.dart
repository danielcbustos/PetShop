import 'package:frontend/models/user_model.dart';

class Pet {
  final int id;
  final String name;
  final String race;
  final int age;
  final User user;

  Pet({
    required this.id,
    required this.name,
    required this.race,
    required this.age,
    required this.user,
  });
}
