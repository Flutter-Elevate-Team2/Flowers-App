import 'package:flowers_app/Features/auth/domain/use_cases/check_auth_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowers_app/Features/auth/domain/auth_repo_contract/auth_repo_contract.dart';

import 'check_auth_usecase_test.mocks.dart';


@GenerateMocks([AuthRepoContract])
void main() {
  late CheckAuthUseCase useCase;
  late MockAuthRepoContract mockAuthRepo;

  setUp(() {
    mockAuthRepo = MockAuthRepoContract();
    useCase = CheckAuthUseCase(mockAuthRepo);
  });

  test('should return true when user is logged in', () async {
    // arrange
    when(mockAuthRepo.isLoggedIn()).thenAnswer((_) async => true);

    // act
    final result = await useCase();

    // assert
    expect(result, true);
    verify(mockAuthRepo.isLoggedIn()).called(1);
    verifyNoMoreInteractions(mockAuthRepo);
  });

  test('should return false when user is not logged in', () async {
    // arrange
    when(mockAuthRepo.isLoggedIn()).thenAnswer((_) async => false);

    // act
    final result = await useCase();

    // assert
    expect(result, false);
    verify(mockAuthRepo.isLoggedIn()).called(1);
    verifyNoMoreInteractions(mockAuthRepo);
  });
}
