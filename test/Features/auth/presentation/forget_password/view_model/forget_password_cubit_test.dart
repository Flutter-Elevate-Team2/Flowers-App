import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/forget_password_usecase.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/verify_password_usecase.dart';
import 'package:flowers_app/Features/auth/domain/use_cases/reset_password_usecase.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_cubit.dart';
import 'package:flowers_app/Features/auth/presentation/forget_password/view_model/forget_password_intent.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Forget_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Verify_password_responce.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/responce/Reset_password_responce.dart';
import 'package:flowers_app/core/base_response/base_response.dart';

import 'forget_password_cubit_test.mocks.dart';

@GenerateMocks([
  ForgetPasswordUsecase,
  VerifyPasswordUsecase,
  ResetPasswordUsecase,
])
void main() {
  late MockForgetPasswordUsecase mockForgetPasswordUsecase;
  late MockVerifyPasswordUsecase mockVerifyPasswordUsecase;
  late MockResetPasswordUsecase mockResetPasswordUsecase;
  late ForgetPasswordCubit cubit;

  setUp(() {
    // Provide dummy responses for mockito
    provideDummy<BaseResponse<ForgetPasswordResponce>>(
      ErrorResponse(errorMessage: ''),
    );
    provideDummy<BaseResponse<VerifyPasswordResponce>>(
      ErrorResponse(errorMessage: ''),
    );
    provideDummy<BaseResponse<ResetPasswordResponce>>(
      ErrorResponse(errorMessage: ''),
    );

    mockForgetPasswordUsecase = MockForgetPasswordUsecase();
    mockVerifyPasswordUsecase = MockVerifyPasswordUsecase();
    mockResetPasswordUsecase = MockResetPasswordUsecase();

    // Fixed: Remove ForgetPasswordState.initial() parameter
    cubit = ForgetPasswordCubit(
      mockForgetPasswordUsecase,
      mockVerifyPasswordUsecase,
      mockResetPasswordUsecase,
    );
  });

  group('SendOtp Intent Tests', () {
    test('SendOtp success updates state correctly', () async {
      final otpResponse = ForgetPasswordResponce();
      when(
        mockForgetPasswordUsecase.forgetPassword(any),
      ).thenAnswer((_) async => SuccessResponse(data: otpResponse));

      final future = cubit.doIntent(SendOtp(email: 'test@example.com'));

      // Check loading state
      expect(cubit.state.sendOtpState?.isLoading, true);

      await future;

      // Check success state
      expect(cubit.state.sendOtpState?.isLoading, false);
      expect(cubit.state.sendOtpState?.data, otpResponse);
      expect(cubit.state.sendOtpState?.errorMessage, null);
    });

    test('SendOtp failure updates state correctly', () async {
      const errorMessage = 'There is no account with this email address';
      when(
        mockForgetPasswordUsecase.forgetPassword(any),
      ).thenAnswer((_) async => ErrorResponse(errorMessage: errorMessage));

      final future = cubit.doIntent(SendOtp(email: 'test@example.com'));

      // Check loading state
      expect(cubit.state.sendOtpState?.isLoading, true);

      await future;

      // Check error state
      expect(cubit.state.sendOtpState?.isLoading, false);
      expect(cubit.state.sendOtpState?.data, null);
      expect(cubit.state.sendOtpState?.errorMessage, errorMessage);
    });
  });

  group('VerifyOtp Intent Tests', () {
    test('VerifyOtp success updates state correctly', () async {
      final verifyResponse = VerifyPasswordResponce();
      when(
        mockVerifyPasswordUsecase.verifyPassword(any),
      ).thenAnswer((_) async => SuccessResponse(data: verifyResponse));

      final future = cubit.doIntent(VerifyOtp(otp: '123456'));

      // Check loading state
      expect(cubit.state.verifyOtpState?.isLoading, true);

      await future;

      // Check success state
      expect(cubit.state.verifyOtpState?.isLoading, false);
      expect(cubit.state.verifyOtpState?.data, verifyResponse);
      expect(cubit.state.verifyOtpState?.errorMessage, null);
    });

    test('VerifyOtp failure updates state correctly', () async {
      const errorMessage = 'Reset code is invalid or has expired';
      when(
        mockVerifyPasswordUsecase.verifyPassword(any),
      ).thenAnswer((_) async => ErrorResponse(errorMessage: errorMessage));

      final future = cubit.doIntent(VerifyOtp(otp: '123456'));

      // Check loading state
      expect(cubit.state.verifyOtpState?.isLoading, true);

      await future;

      // Check error state
      expect(cubit.state.verifyOtpState?.isLoading, false);
      expect(cubit.state.verifyOtpState?.data, null);
      expect(cubit.state.verifyOtpState?.errorMessage, errorMessage);
    });
  });

  group('ResetPassword Intent Tests', () {
    test('ResetPassword success updates state correctly', () async {
      final resetResponse = ResetPasswordResponce();
      when(
        mockResetPasswordUsecase.resetPassword(any),
      ).thenAnswer((_) async => SuccessResponse(data: resetResponse));

      final future = cubit.doIntent(
        ResetPassword(email: 'test@example.com', newPassword: 'NewPass@123'),
      );

      // Check loading state
      expect(cubit.state.resetPasswordState?.isLoading, true);

      await future;

      // Check success state
      expect(cubit.state.resetPasswordState?.isLoading, false);
      expect(cubit.state.resetPasswordState?.data, resetResponse);
      expect(cubit.state.resetPasswordState?.errorMessage, null);
    });

    test('ResetPassword failure updates state correctly', () async {
      const errorMessage = 'reset code not verified';
      when(
        mockResetPasswordUsecase.resetPassword(any),
      ).thenAnswer((_) async => ErrorResponse(errorMessage: errorMessage));

      final future = cubit.doIntent(
        ResetPassword(email: 'test@example.com', newPassword: 'NewPass@123'),
      );

      // Check loading state
      expect(cubit.state.resetPasswordState?.isLoading, true);

      await future;

      // Check error state
      expect(cubit.state.resetPasswordState?.isLoading, false);
      expect(cubit.state.resetPasswordState?.data, null);
      expect(cubit.state.resetPasswordState?.errorMessage, errorMessage);
    });
  });

  group('Initial State Tests', () {
    test('Initial state has all states as null', () {
      expect(cubit.state.sendOtpState, null);
      expect(cubit.state.verifyOtpState, null);
      expect(cubit.state.resetPasswordState, null);
    });
  });

  group('Multiple Intent Execution Tests', () {
    test('Can execute multiple SendOtp intents', () async {
      final response1 = ForgetPasswordResponce();
      final response2 = ForgetPasswordResponce();

      when(
        mockForgetPasswordUsecase.forgetPassword(any),
      ).thenAnswer((_) async => SuccessResponse(data: response1));

      await cubit.doIntent(SendOtp(email: 'test1@example.com'));
      expect(cubit.state.sendOtpState?.data, response1);

      when(
        mockForgetPasswordUsecase.forgetPassword(any),
      ).thenAnswer((_) async => SuccessResponse(data: response2));

      await cubit.doIntent(SendOtp(email: 'test2@example.com'));
      expect(cubit.state.sendOtpState?.data, response2);
    });

    test(
      'States are independent - SendOtp does not affect VerifyOtp state',
      () async {
        final otpResponse = ForgetPasswordResponce();
        when(
          mockForgetPasswordUsecase.forgetPassword(any),
        ).thenAnswer((_) async => SuccessResponse(data: otpResponse));

        await cubit.doIntent(SendOtp(email: 'test@example.com'));

        expect(cubit.state.sendOtpState?.data, otpResponse);
        expect(cubit.state.verifyOtpState, null);
        expect(cubit.state.resetPasswordState, null);
      },
    );
  });
}
