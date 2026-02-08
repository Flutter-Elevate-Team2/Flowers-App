import 'package:flowers_app/Features/auth/domain/use_cases/valid_token_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart';

import 'valid_token_usecase_test.mocks.dart';

@GenerateMocks([AuthLocalDataSourceContract])
void main() {
  late HasValidTokenUseCase useCase;
  late MockAuthLocalDataSourceContract mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockAuthLocalDataSourceContract();
    useCase = HasValidTokenUseCase(mockLocalDataSource);
  });

  test('should return true when token is not null and not empty', () async {
    // arrange
    when(mockLocalDataSource.getToken())
        .thenAnswer((_) async => 'valid_token');

    // act
    final result = await useCase();

    // assert
    expect(result, true);
    verify(mockLocalDataSource.getToken()).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
  });

  test('should return false when token is null', () async {
    // arrange
    when(mockLocalDataSource.getToken())
        .thenAnswer((_) async => null);

    // act
    final result = await useCase();

    // assert
    expect(result, false);
    verify(mockLocalDataSource.getToken()).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
  });

  test('should return false when token is empty', () async {
    // arrange
    when(mockLocalDataSource.getToken())
        .thenAnswer((_) async => '');

    // act
    final result = await useCase();

    // assert
    expect(result, false);
    verify(mockLocalDataSource.getToken()).called(1);
    verifyNoMoreInteractions(mockLocalDataSource);
  });
}
