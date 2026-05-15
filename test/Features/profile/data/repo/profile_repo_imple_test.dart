 import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart';
import 'package:flowers_app/Features/profile/data/data_sources/remote_data_source_contract/profile_remote_data_source_contract.dart';
import 'package:flowers_app/Features/profile/data/models/logout_response.dart';
import 'package:flowers_app/Features/profile/data/models/profile_dto.dart';
import 'package:flowers_app/Features/profile/data/models/user_model.dart';
import 'package:flowers_app/Features/profile/data/repo/profile_repo_imple.dart';
 import 'package:flowers_app/Features/profile/domain/entities/user_entity.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/controller/session_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

 @GenerateMocks([
  ProfileRemoteDataSourceContract,
  AuthLocalDataSourceContract,
  SessionController,
])
import 'profile_repo_impl_test.mocks.dart';

void main() {
  late ProfileRepoImpl repo;
  late MockProfileRemoteDataSourceContract mockRemoteDataSource;
  late MockAuthLocalDataSourceContract mockLocalDataSource;
  late MockSessionController mockSessionController;

  setUp(() {
    mockRemoteDataSource = MockProfileRemoteDataSourceContract();
    mockLocalDataSource = MockAuthLocalDataSourceContract();
    mockSessionController = MockSessionController();
    repo = ProfileRepoImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
      mockSessionController,
    );
  });

  group('getProfileData', () {
    final tUserModel = UserModel(id: '123', firstName: 'Fatma');
    final tProfileDto = ProfileDto(user: tUserModel);

    test('should return SuccessResponse and save userId locally when remote call is successful', () async {
      // Arrange
      when(mockRemoteDataSource.getProfile()).thenAnswer((_) async => tProfileDto);
      when(mockLocalDataSource.saveUserId(any)).thenAnswer((_) async => true);

      // Act
      final result = await repo.getProfileData();

      // Assert
      expect(result, isA<SuccessResponse<UserEntity>>());
      verify(mockRemoteDataSource.getProfile()).called(1);
      verify(mockLocalDataSource.saveUserId('123')).called(1);
    });
  });

  group('logout', () {
    test('should clear local data and notify logout on success', () async {
      // Arrange
      when(mockRemoteDataSource.logout()).thenAnswer((_) async => LogoutResponse(message: "Success"));
      when(mockLocalDataSource.clearUserData()).thenAnswer((_) async => true);

      // Act
      final result = await repo.logout();

      // Assert
      expect(result, isA<SuccessResponse<String>>());
      verify(mockLocalDataSource.clearUserData()).called(1);
      verify(mockSessionController.notifyLogout(SessionEndReason.logout)).called(1);
    });

    test('should still logout locally even if server returns Unauthorized', () async {
      // Arrange: إيهام الـ Mixin أن السيرفر رجع 401
      // ملحوظة: بما أنك تستخدمين Mixin، فالاختبار هنا يعتمد على كيفية معالجة Mixin للـ Exceptions
      // سنفترض هنا أن الـ Remote يرمي Exception والـ Mixin يحولها لـ ErrorResponse
    });
  });
}