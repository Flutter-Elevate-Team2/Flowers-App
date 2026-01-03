import 'package:flowers_app/Features/auth/data/mappers/signup_mappers.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/signup_response.dart';
import 'package:flowers_app/Features/auth/data/models/signup_models/user_dto.dart';
import 'package:flowers_app/Features/auth/domain/entities/signup_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Signup Mappers Test Cases", () {

    // ========================================================
    // 1. UserDto Mapper Tests
    // ========================================================
    group("UserDtoMapper", () {
      test(
        "should map UserDto to SignupUserEntity correctly when all data is present",
        () {
          // ARRANGE
          final tUserDto = UserDto(
            firstName: "Ahmed",
            lastName: "Ali",
            email: "test@test.com",
            phone: "01012345678",
            gender: "male",
            id: "123",
          );

          // ACT
          final result = tUserDto.toEntity();

          // ASSERT
          expect(result, isA<SignupUserEntity>());
          expect(result.firstName, tUserDto.firstName);
          expect(result.lastName, tUserDto.lastName);
          expect(result.email, tUserDto.email);
          expect(result.phone, tUserDto.phone);
          expect(result.gender, tUserDto.gender);
        },
      );

      test(
        "should map null fields to empty strings when UserDto fields are null",
        () {
          // ARRANGE
          final tUserDtoWithNulls = UserDto(
            firstName: null,
            lastName: null,
            email: null,
            phone: null,
            gender: null,
          );

          // ACT
          final result = tUserDtoWithNulls.toEntity();

          // ASSERT
          // Since your mapper uses (?? ''), we expect empty strings
          expect(result.firstName, isEmpty);
          expect(result.lastName, isEmpty);
          expect(result.email, isEmpty);
          expect(result.phone, isEmpty);
          expect(result.gender, isEmpty);
        },
      );
    });

    // ========================================================
    // 2. SignupResponse Mapper Tests
    // ========================================================
    group("SignupResponseMapper", () {
      test(
        "should map SignupResponse to SignupEntity correctly when user is present",
        () {
          // ARRANGE
          final tUserDto = UserDto(
            firstName: "Ahmed",
            email: "test@test.com",
          );

          final tSignupResponse = SignupResponse(
            message: "Success",
            token: "valid_token_123",
            user: tUserDto,
          );

          // ACT
          final result = tSignupResponse.toEntity();

          // ASSERT
          expect(result, isA<SignupEntity>());
          expect(result.token, tSignupResponse.token);

          // Check if nested user is also mapped correctly
          expect(result.user, isNotNull);
          expect(result.user?.firstName, tUserDto.firstName);
        },
      );

      test(
        "should map SignupResponse to SignupEntity with null user when user is null",
        () {
          // ARRANGE
          final tSignupResponseNoUser = SignupResponse(
            message: "Success",
            token: "valid_token_123",
            user: null,
          );

          // ACT
          final result = tSignupResponseNoUser.toEntity();

          // ASSERT
          expect(result.token, tSignupResponseNoUser.token);
          expect(result.user, isNull);
        },
      );
    });
  });
}
