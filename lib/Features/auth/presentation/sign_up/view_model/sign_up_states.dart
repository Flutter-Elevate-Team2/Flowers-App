import 'package:flowers_app/Features/auth/domain/entities/signup_entity.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

class SignUpStates {
  final BaseState<SignupEntity>? signUpState;

  SignUpStates({this.signUpState});
  SignUpStates copyWith({BaseState<SignupEntity>? signUpState}) {
    return SignUpStates(signUpState: signUpState ?? this.signUpState);
  }
}
