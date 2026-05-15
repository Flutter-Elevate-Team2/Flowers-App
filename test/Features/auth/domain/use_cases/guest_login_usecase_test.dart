import 'package:flowers_app/Features/auth/domain/use_cases/guest_login_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flowers_app/Features/auth/data/auth_data_source_contract/auth_local_data_source_contract.dart';
import 'package:flowers_app/Features/auth/domain/entities/login_entity.dart';

import 'guest_login_usecase_test.mocks.dart';


@GenerateMocks([AuthLocalDataSourceContract])
void main() {
  late GuestLoginUseCase useCase;
  late MockAuthLocalDataSourceContract mockLocalDataSource;

  setUp(() {
    mockLocalDataSource = MockAuthLocalDataSourceContract();
    useCase = GuestLoginUseCase(mockLocalDataSource);
  });

  test(
      'should clear user data and return Guest LoginEntity when called',
          () async {
        // arrange
        when(mockLocalDataSource.clearUserData())
            .thenAnswer((_) async {});

        // act
        final result = await useCase();

        // assert
        verify(mockLocalDataSource.clearUserData()).called(1);
        verifyNoMoreInteractions(mockLocalDataSource);

        expect(
          result,
          isA<LoginEntity>()
              .having((e) => e.token, 'token', null)
              .having((e) => e.message, 'message', 'Guest')
              .having((e) => e.user, 'user', null),
        );
      });
}
