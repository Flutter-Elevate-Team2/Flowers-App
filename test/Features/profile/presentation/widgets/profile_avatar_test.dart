import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_event.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_state.dart';
import 'package:flowers_app/Features/profile/presentation/view_model/profile_view_model.dart';
import 'package:flowers_app/Features/profile/presentation/widgets/profile_avatar.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

class MockProfileViewModel extends MockBloc<ProfileEvent, ProfileState> implements ProfileViewModel {}
class MockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (cert, host, port) => true;
  }
}
void main() {
  late MockProfileViewModel mockProfileVM;

  setUpAll(() {
    registerFallbackValue(SelectProfileImageEvent(File('')));
    registerFallbackValue(UploadPhotoEvent(File('')));
  });

  setUp(() {
    mockProfileVM = MockProfileViewModel();
  });

  Widget createWidgetUnderTest({String? photoUrl}) {
    return BlocProvider<ProfileViewModel>.value(
      value: mockProfileVM,
      child: MaterialApp(
        home: Scaffold(
          body: ProfileAvatarSection(photoUrl: photoUrl),
        ),
      ),
    );
  }

  group('ProfileAvatarSection Widget Tests', () {
    testWidgets('should show NetworkImage when photoUrl is provided', (tester) async {
      await mockNetworkImages(() async { // لفي التيست هنا
        when(() => mockProfileVM.state).thenReturn(ProfileState());

        await tester.pumpWidget(createWidgetUnderTest(photoUrl: 'https://test.com/p.jpg'));

        final circleAvatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
        expect(circleAvatar.backgroundImage, isA<NetworkImage>());
      });
    });
    testWidgets('should show FileImage when a local image is selected', (tester) async {
      final file = File('test_path.jpg');
      when(() => mockProfileVM.state).thenReturn(
        ProfileState(selectedProfileImage: file),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      final circleAvatar = tester.widget<CircleAvatar>(find.byType(CircleAvatar));
      expect(circleAvatar.backgroundImage, isA<FileImage>());
    });

    testWidgets('should show CircularProgressIndicator when isUploading is true', (tester) async {
      when(() => mockProfileVM.state).thenReturn(
        ProfileState(uploadPhotoState: BaseState(isLoading: true)),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(Container), findsAtLeastNWidgets(1)); // The overlay
    });

    testWidgets('should show camera icon and trigger image picker logic on tap', (tester) async {
      when(() => mockProfileVM.state).thenReturn(ProfileState());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byIcon(Icons.camera_alt_outlined), findsOneWidget);

      // We can't easily test the actual ImagePicker OS dialog,
      // but we verify the GestureDetector exists.
      await tester.tap(find.byIcon(Icons.camera_alt_outlined));
      await tester.pump();

      // Note: Full testing of _pickImage would require mocking ImagePicker
      // via MethodChannel or a wrapper service.
    });
  });
}