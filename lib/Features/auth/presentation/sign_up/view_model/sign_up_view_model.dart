import 'package:flowers_app/Features/auth/data/models/signup_models/signup_request.dart';
import 'package:flowers_app/Features/auth/domain/entities/signup_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/signup_usecase.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/view_model/sign_up_events.dart';
import 'package:flowers_app/Features/auth/presentation/sign_up/view_model/sign_up_states.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpViewModel extends Cubit<SignUpStates> {
  final SignupUseCase _signupUseCase;
  SignUpViewModel(this._signupUseCase) : super(SignUpStates());

  void doIntent(SignUpEvent event) {
    switch (event) {
      case OnSignUpClickEvent():
        _handleSignUp(event);
        break;
    }
  }

  void _handleSignUp(OnSignUpClickEvent event) async {
    emit(state.copyWith(signUpState: BaseState<SignupEntity>(isLoading: true)));
    final response = await _signupUseCase.call(
      SignupRequest(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        phone: event.phone,
        password: event.password,
        gender: event.gender, 
        rePassword: event.confirmPassword,
      ),
    );
    

    switch (response) {
      case SuccessResponse<SignupEntity>():
       
        emit(
          state.copyWith(
            signUpState: BaseState<SignupEntity>(
              isLoading: false,
              data: response.data,
              errorMessage: null, 
            ),
          ),
        );
        break;

      case ErrorResponse<SignupEntity>():
       
        emit(
          state.copyWith(
            signUpState: BaseState<SignupEntity>(
              isLoading: false,
              data: null, 
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }
}
