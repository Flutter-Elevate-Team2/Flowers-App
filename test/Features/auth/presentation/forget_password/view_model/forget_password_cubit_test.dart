import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/reset_password_request/reset_password_request.dart';
import 'package:flowers_app/Features/auth/data/models/forget_password/request/verify_password_request/verify_password_request.dart';
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
import 'package:flowers_app/core/base_states/base_states.dart';
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
  provideDummy<BaseResponse<ForgetPasswordEntity>>(
    SuccessResponse(
      data: ForgetPasswordEntity(message: 'dummy', info: ''),
    ),
  );
  provideDummy<BaseResponse<VerifyPasswordEntity>>(
    SuccessResponse(data: VerifyPasswordEntity(status: 'dummy')),
  );
  provideDummy<BaseResponse<ResetPasswordEntity>>(
    SuccessResponse(
      data: ResetPasswordEntity(message: 'dummy', token: ''),
    ),
  );

  late ForgetPasswordCubit viewModel;
  late MockForgetPasswordUsecase mockForgetPasswordUseCase;
  late MockVerifyPasswordUsecase mockVerifyPasswordUseCase;
  late MockResetPasswordUsecase mockResetPasswordUseCase;

  setUp(() {
    mockForgetPasswordUseCase = MockForgetPasswordUsecase();
    mockVerifyPasswordUseCase = MockVerifyPasswordUsecase();
    mockResetPasswordUseCase = MockResetPasswordUsecase();

    viewModel = ForgetPasswordCubit(
      mockForgetPasswordUseCase,
      mockVerifyPasswordUseCase,
      mockResetPasswordUseCase,
    );
  });

  group('ForgetPasswordViewModel Tests', () {
    const tEmail = 'test@example.com';
    const tOtp = '123456';
    const tPassword = 'password123';

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'should emit [Loading, Success] when forgetPassword succeeds',
      build: () {
        when(mockForgetPasswordUseCase.forgetPassword(any)).thenAnswer(
              (_) async => SuccessResponse(
            data: ForgetPasswordEntity(message: 'Sent', info: ''),
          ),
        );
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(SendOtp(email: tEmail)),
      expect: () => [
        isA<ForgetPasswordState>().having(
              (s) => s.sendOtpState?.isLoading,
          'isLoading',
          true,
        ),
        isA<ForgetPasswordState>().having(
              (s) => s.sendOtpState?.data,
          'data',
          isNotNull,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'should emit [Loading, Error] when forgetPassword fails',
      build: () {
        when(
          mockForgetPasswordUseCase.forgetPassword(any),
        ).thenAnswer((_) async => ErrorResponse(errorMessage: 'Server Error'));
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(SendOtp(email: tEmail)),
      expect: () => [
        isA<ForgetPasswordState>().having(
              (s) => s.sendOtpState?.isLoading,
          'isLoading',
          true,
        ),
        isA<ForgetPasswordState>().having(
              (s) => s.sendOtpState?.errorMessage,
          'errorMessage',
          'Server Error',
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'should emit [Loading, Success] when verifyPassword succeeds',
      build: () {
        when(mockVerifyPasswordUseCase.verifyPassword(any)).thenAnswer(
              (_) async => SuccessResponse(
            data: VerifyPasswordEntity(status: 'Verified'),
          ),
        );
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(VerifyOtp(otp: tOtp)),
      expect: () => [
        isA<ForgetPasswordState>().having(
              (s) => s.verifyOtpState?.isLoading,
          'isLoading',
          true,
        ),
        isA<ForgetPasswordState>().having(
              (s) => s.verifyOtpState?.data,
          'data',
          isNotNull,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'should emit [Loading, Error] when verifyPassword fails',
      build: () {
        when(
          mockVerifyPasswordUseCase.verifyPassword(any),
        ).thenAnswer((_) async => ErrorResponse(errorMessage: 'Invalid OTP'));
        return viewModel;
      },
      act: (bloc) => bloc.doIntent(VerifyOtp(otp: '000000')),
      expect: () => [
        isA<ForgetPasswordState>().having(
              (s) => s.verifyOtpState?.isLoading,
          'isLoading',
          true,
        ),
        isA<ForgetPasswordState>().having(
              (s) => s.verifyOtpState?.errorMessage,
          'errorMessage',
          'Invalid OTP',
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'should emit [Loading, Success] when resetPassword succeeds',
      build: () {
        when(mockResetPasswordUseCase.resetPassword(any)).thenAnswer(
              (_) async => SuccessResponse(
            data: ResetPasswordEntity(message: 'Changed', token: 'token'),
          ),
        );
        return viewModel;
      },
      act: (bloc) =>
          bloc.doIntent(ResetPassword(newPassword: tPassword, email: tEmail)),
      expect: () => [
        isA<ForgetPasswordState>().having(
              (s) => s.resetPasswordState?.isLoading,
          'isLoading',
          true,
        ),
        isA<ForgetPasswordState>().having(
              (s) => s.resetPasswordState?.data,
          'data',
          isNotNull,
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'should emit [Loading, Error] when resetPassword fails',
      build: () {
        when(
          mockResetPasswordUseCase.resetPassword(any),
        ).thenAnswer((_) async => ErrorResponse(errorMessage: 'Weak Password'));
        return viewModel;
      },
      act: (bloc) =>
          bloc.doIntent(ResetPassword(newPassword: tPassword, email: tEmail)),
      expect: () => [
        isA<ForgetPasswordState>().having(
              (s) => s.resetPasswordState?.isLoading,
          'isLoading',
          true,
        ),
        isA<ForgetPasswordState>().having(
              (s) => s.resetPasswordState?.errorMessage,
          'errorMessage',
          'Weak Password',
        ),
      ],
    );

    blocTest<ForgetPasswordCubit, ForgetPasswordState>(
      'should maintain sendOtpState data when verifyOtpState is updated (State Persistence)',
      build: () {
        final initialState = ForgetPasswordState(
          sendOtpState: BaseState(
            isLoading: false,
            data: ForgetPasswordEntity(message: 'sent', info: ''),
          ),
        );
        when(mockVerifyPasswordUseCase.verifyPassword(any)).thenAnswer(
              (_) async =>
              SuccessResponse(data: VerifyPasswordEntity(status: 'ok')),
        );
        return ForgetPasswordCubit(
          mockForgetPasswordUseCase,
          mockVerifyPasswordUseCase,
          mockResetPasswordUseCase,
        )..emit(initialState);
      },
      act: (bloc) => bloc.doIntent(VerifyOtp(otp: '123456')),
      expect: () => [
        isA<ForgetPasswordState>()
            .having((s) => s.verifyOtpState?.isLoading, 'verify loading', true)
            .having(
              (s) => s.sendOtpState?.data,
          'old data persists',
          isNotNull,
        ),
        isA<ForgetPasswordState>()
            .having(
              (s) => s.verifyOtpState?.isLoading,
          'verify finished',
          false,
        )
            .having(
              (s) => s.sendOtpState?.data,
          'old data still persists',
          isNotNull,
        ),
      ],
    );

    test(
      'should verify that ResetPasswordUseCase is called with correct parameters',
          () async {
        when(mockResetPasswordUseCase.resetPassword(any)).thenAnswer(
              (_) async => SuccessResponse(
            data: ResetPasswordEntity(message: 'done', token: ''),
          ),
        );

        await viewModel.doIntent(
          ResetPassword(newPassword: 'NewPass123', email: 'test@test.com'),
        );

        verify(
          mockResetPasswordUseCase.resetPassword(
            argThat(
              isA<ResetPasswordRequest>()
                  .having((r) => r.email, 'email', 'test@test.com')
                  .having((r) => r.newPassword, 'password', 'NewPass123'),
            ),
          ),
        ).called(1);
      },
    );

    test(
      'should verify that VerifyPasswordUseCase is called with correct resetCode',
          () async {
        when(mockVerifyPasswordUseCase.verifyPassword(any)).thenAnswer(
              (_) async =>
              SuccessResponse(data: VerifyPasswordEntity(status: 'ok')),
        );

        await viewModel.doIntent(VerifyOtp(otp: '123456'));

        verify(
          mockVerifyPasswordUseCase.verifyPassword(
            argThat(
              isA<VerifyPasswordRequest>().having(
                    (r) => r.resetCode,
                'resetCode',
                '123456',
              ),
            ),
          ),
        ).called(1);
      },
    );

  });
}
