import 'package:flowers_app/Features/commerce/domain/entities/home_entities/home_entity.dart';
import 'package:flowers_app/Features/commerce/domain/use_cases/get_home_sections_use_case.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_events.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_states.dart';
import 'package:flowers_app/Features/commerce/presentation/home/view_model/home_view_model.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_view_model_test.mocks.dart';

@GenerateMocks([GetHomeSectionsUseCase])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  provideDummy<BaseResponse<HomeEntity>>(
    SuccessResponse(
      data: HomeEntity(categories: [], bestSellers: [], occasions: []),
    ),
  );

  late HomeViewModel viewModel;
  late MockGetHomeSectionsUseCase mockUseCase;

  final tHomeEntity = HomeEntity(
    categories: [],
    bestSellers: [],
    occasions: [],
  );

  setUp(() {
    mockUseCase = MockGetHomeSectionsUseCase();
    viewModel = HomeViewModel(mockUseCase);
  });

  tearDown(() {
    viewModel.close();
  });

  group('HomeViewModel Tests', () {
    test(
      'should emit [Loading, Success] when data is fetched successfully',
      () async {
        // Arrange
        when(mockUseCase.call()).thenAnswer(
          (_) async => SuccessResponse<HomeEntity>(data: tHomeEntity),
        );

        // Assert
        final expectedStates = expectLater(
          viewModel.stream,
          emitsInOrder([
            isA<HomeStates>().having(
              (s) => s.homeState?.isLoading,
              'isLoading',
              true,
            ),

            isA<HomeStates>()
                .having((s) => s.homeState?.isLoading, 'isLoading', false)
                .having((s) => s.homeState?.data, 'data', tHomeEntity),
          ]),
        );

        // Act
        viewModel.doIntent(GetHomeDataEvent());

        // Await
        await expectedStates;
      },
    );

    test('should emit [Loading, Error] when fetching fails', () async {
      // Arrange
      when(mockUseCase.call()).thenAnswer(
        (_) async => ErrorResponse<HomeEntity>(errorMessage: 'Error occurred'),
      );

      // Assert
      final expectedStates = expectLater(
        viewModel.stream,
        emitsInOrder([
          isA<HomeStates>().having(
            (s) => s.homeState?.isLoading,
            'isLoading',
            true,
          ),

          isA<HomeStates>()
              .having((s) => s.homeState?.isLoading, 'isLoading', false)
              .having(
                (s) => s.homeState?.errorMessage,
                'error',
                'Error occurred',
              ),
        ]),
      );

      // Act
      viewModel.doIntent(GetHomeDataEvent());

      // Await
      await expectedStates;
    });
  });
}
