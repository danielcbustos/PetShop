class Reservation {
  final int id;
  final String description;
  final DateTime reservationDate;
  final bool available;

  Reservation({
    required this.id,
    required this.description,
    required this.reservationDate,
    required this.available,
  });

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
        id: json['id'],
        reservationDate: DateTime.parse(json['reservationDate']),
        available: json['available'],
        description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'reservationDate': reservationDate.toIso8601String(),
      'available': available
    };
  }
}
