sealed class LoginEvent {}


class LoginInitial extends LoginEvent {}


class RememberMeEvent extends LoginEvent {
  final bool value;
  RememberMeEvent({required this.value});
}

class LoginButtonEvent extends LoginEvent {
  final String email;
  final String password;

  LoginButtonEvent({required this.email, required this.password});
}

class GuestLoginEvent extends LoginEvent {}

class SignUpEvent extends LoginEvent {}
