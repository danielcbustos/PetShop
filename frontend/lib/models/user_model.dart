class User {
  int id;
  String username;
  String password;
  String firstName;
  String lastName;
  String email;
  // List<Pet> pets;

  User({
    required this.id,
    required this.username,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.email,
    // required this.pets,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['username'],
        username: json['username'],
        password: json['password'],
        firstName: json['firstName'],
        lastName: json['lastname'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
      // 'pets': pets.map((pet) => pet.toJson()).toList(),
    };
  }
}
