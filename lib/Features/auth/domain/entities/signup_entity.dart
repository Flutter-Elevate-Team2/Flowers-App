class SignupEntity {
  final SignupUserEntity? user;
  final String? token;

  SignupEntity({required this.user, required this.token});
}

class SignupUserEntity {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;

  SignupUserEntity({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
  });
}
