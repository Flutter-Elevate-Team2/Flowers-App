import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';
import 'package:flowers_app/core/widget/selected_address_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SelectedAddressCubit', () {
    final tAddress = AddressEntity(
      id: "1",
      street: "123 Street",
      phone: "123456",
      city: "City",
      lat: "30.0",
      long: "31.0",
      username: "User",
    );

    blocTest<SelectedAddressCubit, AddressEntity?>(
      'initial state is null',
      build: () => SelectedAddressCubit(),
      verify: (cubit) => expect(cubit.state, isNull),
    );

    blocTest<SelectedAddressCubit, AddressEntity?>(
      'emits address when select is called',
      build: () => SelectedAddressCubit(),
      act: (cubit) => cubit.select(tAddress),
      expect: () => [tAddress],
    );

    blocTest<SelectedAddressCubit, AddressEntity?>(
      'emits null when clear is called',
      build: () => SelectedAddressCubit(),
      seed: () => tAddress,
      act: (cubit) => cubit.clear(),
      expect: () => [null],
    );
  });
}
