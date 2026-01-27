class AddressEntity {
  final String id;
  final String title;
  final String street;
  final String city;
  final String phone;
  final double lat;
  final double long;

  const AddressEntity({
    required this.id,
    required this.title,
    required this.street,
    required this.city,
    required this.phone,
    required this.lat,
    required this.long,
  });
}
