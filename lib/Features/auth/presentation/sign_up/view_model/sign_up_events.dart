sealed class SignUpEvent {}
class OnSignUpClickEvent  extends SignUpEvent {
   final String gender;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;

  OnSignUpClickEvent({
    
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password, required this.gender, required this.confirmPassword,
  });
}