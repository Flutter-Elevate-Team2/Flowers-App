import 'package:flowers_app/core/helpers/app_regex.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppRegex Test Cases', () {

    // =========================================================
    // 1. Email Validation Tests
    // =========================================================
    group('isEmailValid', () {
      test('should return true for valid emails', () {
        expect(AppRegex.isEmailValid('test@example.com'), true);
        expect(AppRegex.isEmailValid('user.name@domain.co'), true);
        expect(AppRegex.isEmailValid('user_name123@sub.domain.org'), true);
      });

      test('should return false for invalid emails', () {
        expect(AppRegex.isEmailValid('testexample.com'), false); // No @
        expect(AppRegex.isEmailValid('test@'), false); // No domain
        expect(AppRegex.isEmailValid('@example.com'), false); // No username
        expect(AppRegex.isEmailValid('test@.com'), false); // Dot immediately after @
        expect(AppRegex.isEmailValid(''), false); // Empty string
      });
    });

    // =========================================================
    // 2. Password Validation Tests (Full Complex Password)
    // =========================================================
    group('isPasswordValid', () {
      test('should return true for strong password meeting all criteria', () {
        // Contains: Upper, Lower, Number, Special, Length >= 8
        expect(AppRegex.isPasswordValid('StrongPass123!'), true);
        expect(AppRegex.isPasswordValid('A@1bcdef'), true);
      });

      test('should return false for weak passwords', () {
        expect(AppRegex.isPasswordValid('weak'), false); // Too short
        expect(AppRegex.isPasswordValid('nouppercase123!'), false); // Missing Uppercase
        expect(AppRegex.isPasswordValid('NOLOWERCASE123!'), false); // Missing Lowercase
        expect(AppRegex.isPasswordValid('NoSpecialChar123'), false); // Missing Special Char
        expect(AppRegex.isPasswordValid('NoNumber!@#'), false); // Missing Number
      });
    });

    // =========================================================
    // 3. Phone Validation Tests
    // =========================================================
    group('isPhoneNumberValid', () {
      test('should return true for valid international and local numbers', () {
        expect(AppRegex.isPhoneNumberValid('+201012345678'), true); // With +
        expect(AppRegex.isPhoneNumberValid('01012345678'), true); // Without +
        expect(AppRegex.isPhoneNumberValid('12345678'), true); // Min length (7+)
      });

      test('should return false for invalid phone numbers', () {
        expect(AppRegex.isPhoneNumberValid('123'), false); // Too short (<7)
        expect(AppRegex.isPhoneNumberValid('abcdefg'), false); // Contains letters
        expect(AppRegex.isPhoneNumberValid('+'), false); // Only +
      });
    });

    // =========================================================
    // 4. Helper Methods Tests (New functions coverage)
    // =========================================================
    group('Password Helper Methods', () {

      test('hasLowerCase checks correctly', () {
        expect(AppRegex.hasLowerCase('A'), false);
        expect(AppRegex.hasLowerCase('a'), true);
        expect(AppRegex.hasLowerCase('123'), false);
        expect(AppRegex.hasLowerCase('Abc'), true);
      });

      test('hasUpperCase checks correctly', () {
        expect(AppRegex.hasUpperCase('a'), false);
        expect(AppRegex.hasUpperCase('A'), true);
        expect(AppRegex.hasUpperCase('123'), false);
        expect(AppRegex.hasUpperCase('aBc'), true);
      });

      test('hasNumber checks correctly', () {
        expect(AppRegex.hasNumber('abc'), false);
        expect(AppRegex.hasNumber('1'), true);
        expect(AppRegex.hasNumber('a1b'), true);
      });

      test('hasSpecialCharacter checks correctly', () {
        expect(AppRegex.hasSpecialCharacter('abc123'), false);
        expect(AppRegex.hasSpecialCharacter('@'), true);
        expect(AppRegex.hasSpecialCharacter('#'), true);
        expect(AppRegex.hasSpecialCharacter('Pass!'), true);
      });

      test('hasMinLength checks correctly', () {
        expect(AppRegex.hasMinLength('1234567'), false); // Length 7
        expect(AppRegex.hasMinLength('12345678'), true); // Length 8
        expect(AppRegex.hasMinLength('123456789'), true); // Length 9
      });
    });
  });
}
