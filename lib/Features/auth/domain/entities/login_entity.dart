class LoginEntity {
  final String? message;
  final String? token;
  final LoginUserEntity? user;

  LoginEntity({required this.token, required this.message, required this.user});
}

class LoginUserEntity {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? gender;
  final String? phone;
  final String? photo;
  final String? role;
  final String? createdAt;
  // "wishlist": [],
  // "addresses": [],

  LoginUserEntity({required this.id, required this.firstName, required this.lastName, required this.email, required this.gender, required this.phone, required this.photo, required this.role, required this.createdAt});
}
