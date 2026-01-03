import 'package:flowers_app/Features/auth/domain/entities/forget_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/reset_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/entities/verify_password_entity.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/verify_password_usecase.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_states.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([
  ForgetPasswordUsecase,
  VerifyPasswordUsecase,
  ResetPasswordUsecase,
])
void main() {
  late ForgetPasswordCubit cubit;
  late MockForgetPasswordUsecase mockForgetPasswordUsecase;
  late MockVerifyPasswordUsecase mockVerifyPasswordUsecase;
  late MockResetPasswordUsecase mockResetPasswordUsecase;

  setUp(() {
    provideDummy<BaseResponse<ForgetPasswordEntity>>(
      SuccessResponse(
        data: ForgetPasswordEntity(message: "dummy", info: "dummy"),
      ),
    );

    provideDummy<BaseResponse<VerifyPasswordEntity>>(
      SuccessResponse(
        data: VerifyPasswordEntity(status: "dummy"),
      ),
    );

    provideDummy<BaseResponse<ResetPasswordEntity>>(
      SuccessResponse(
        data: ResetPasswordEntity(message: "dummy", token: "dummy"),
      ),
    );

    mockForgetPasswordUsecase = MockForgetPasswordUsecase();
    mockVerifyPasswordUsecase = MockVerifyPasswordUsecase();
    mockResetPasswordUsecase = MockResetPasswordUsecase();

    cubit = ForgetPasswordCubit(
      mockForgetPasswordUsecase,
      mockVerifyPasswordUsecase,
      mockResetPasswordUsecase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('ForgetPasswordCubit (Standard Tests)', () {
    test('SendOtp emits [Loading, Success] when successful', () async {
      // ARRANGE
      final tEntity = ForgetPasswordEntity(message: "Success", info: "info");
      when(
        mockForgetPasswordUsecase.forgetPassword(any),
      ).thenAnswer((_) async => SuccessResponse(data: tEntity));

      // ASSERT (Using expectLater for Streams)
      final expectedStates = [
        // State 1: Loading
        predicate<ForgetPasswordState>(
          (s) => s.sendOtpState?.isLoading == true,
        ),
        // State 2: Success
        predicate<ForgetPasswordState>(
          (s) =>
              s.sendOtpState?.isLoading == false &&
              s.sendOtpState?.data == tEntity,
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      // ACT
      await cubit.doIntent(SendOtp(email: 'test@test.com'));
    });

    test('VerifyOtp emits [Loading, Error] when fails', () async {
      // ARRANGE
      when(
        mockVerifyPasswordUsecase.verifyPassword(any),
      ).thenAnswer((_) async => ErrorResponse(errorMessage: "Invalid Code"));

      // ASSERT
      final expectedStates = [
        predicate<ForgetPasswordState>(
          (s) => s.verifyOtpState?.isLoading == true,
        ),
        predicate<ForgetPasswordState>(
          (s) =>
              s.verifyOtpState?.isLoading == false &&
              s.verifyOtpState?.errorMessage == "Invalid Code",
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      // ACT
      await cubit.doIntent(VerifyOtp(otp: '123456'));
    });

    test('ResetPassword emits [Loading, Success] when successful', () async {
      // ARRANGE
      final tEntity = ResetPasswordEntity(message: "Done", token: "token");
      when(
        mockResetPasswordUsecase.resetPassword(any),
      ).thenAnswer((_) async => SuccessResponse(data: tEntity));

      // ASSERT
      final expectedStates = [
        predicate<ForgetPasswordState>(
          (s) => s.resetPasswordState?.isLoading == true,
        ),
        predicate<ForgetPasswordState>(
          (s) =>
              s.resetPasswordState?.isLoading == false &&
              s.resetPasswordState?.data == tEntity,
        ),
      ];

      expectLater(cubit.stream, emitsInOrder(expectedStates));

      // ACT
      await cubit.doIntent(ResetPassword(email: 'a', newPassword: 'p'));
    });
  });
}
