import 'package:flowers_app/Features/auth/domain/use_cases/get_user_id_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';

import 'get_user_id_usecase_test.mocks.dart';

@GenerateMocks([AuthRepoContract])
void main() {
  late GetUserIdUseCase getUserIdUseCase;
  late MockAuthRepoContract mockAuthRepoContract;

  setUp(() {
    mockAuthRepoContract = MockAuthRepoContract();
    getUserIdUseCase = GetUserIdUseCase(mockAuthRepoContract);
  });

  group('GetUserIdUseCase Unit Tests', () {
    const String tUserId = "user_123";

    test(
      'should return UserId from the repository when it exists',
          () async {
        // Arrange
        when(mockAuthRepoContract.getUserId())
            .thenAnswer((_) async => tUserId);

        // Act
        final result = await getUserIdUseCase.call();

        // Assert
        expect(result, tUserId);
        verify(mockAuthRepoContract.getUserId()).called(1);
        verifyNoMoreInteractions(mockAuthRepoContract);
      },
    );

    test(
      'should return null when the repository returns null',
          () async {
        // Arrange
        when(mockAuthRepoContract.getUserId())
            .thenAnswer((_) async => null);

        // Act
        final result = await getUserIdUseCase.call();

        // Assert
        expect(result, null);
        verify(mockAuthRepoContract.getUserId()).called(1);
        verifyNoMoreInteractions(mockAuthRepoContract);
      },
    );
  });
}