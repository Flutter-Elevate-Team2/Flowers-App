import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/core/base_states/base_states.dart';

class UserAddressState {
  final BaseState<AddressResponseEntity>? getAddressesState;
  final BaseState<AddressResponseEntity>? addAddressState;
  final BaseState<AddressResponseEntity>? editAddressState;
  final BaseState<AddressResponseEntity>? deleteAddressState;

  UserAddressState({
    this.getAddressesState,
    this.addAddressState,
    this.editAddressState,
    this.deleteAddressState,
  });

  UserAddressState copyWith({
    BaseState<AddressResponseEntity>? getAddressesState,
    BaseState<AddressResponseEntity>? addAddressState,
    BaseState<AddressResponseEntity>? editAddressState,
    BaseState<AddressResponseEntity>? deleteAddressState,
  }) {
    return UserAddressState(
      getAddressesState: getAddressesState ?? this.getAddressesState,
      addAddressState: addAddressState ?? this.addAddressState,
      editAddressState: editAddressState ?? this.editAddressState,
      deleteAddressState: deleteAddressState ?? this.deleteAddressState,
    );
  }
}
