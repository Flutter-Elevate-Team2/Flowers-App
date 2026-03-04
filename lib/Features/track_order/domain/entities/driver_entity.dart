class DriverEntity {
  final String id;
  final String name;
  final String phone;
  final String token;
  final String vehicleNumber;

  DriverEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.token,
    required this.vehicleNumber,
  });

  factory DriverEntity.fromMap(Map<String, dynamic> map) {
    return DriverEntity(
      id: map['driverId'] ?? '',
      name: map['driverName'] ?? '',
      phone: map['driverPhone'] ?? '',
      token: map['driverToken'] ?? '',
      vehicleNumber: map['vehicleNumber'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'driverId': id,
      'driverName': name,
      'driverPhone': phone,
      'driverToken': token,
      'vehicleNumber': vehicleNumber,
    };
  }
}