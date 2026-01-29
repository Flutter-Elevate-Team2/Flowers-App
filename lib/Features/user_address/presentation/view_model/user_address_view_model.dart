import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_response_entity.dart';
import 'package:flowers_app/Features/user_address/domain/use_case/add_address_use_case.dart';
import 'package:flowers_app/Features/user_address/domain/use_case/get_addresses_use_case.dart';
import 'package:flowers_app/Features/user_address/domain/use_case/user_address_use_case.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_event.dart';
import 'package:flowers_app/Features/user_address/presentation/view_model/user_address_state.dart';
import 'package:flowers_app/core/base_response/base_response.dart';
import 'package:flowers_app/core/base_states/base_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserAddressViewModel extends Cubit<UserAddressState> {
  final GetAddressesUseCase _getAddressesUseCase;
  final AddAddressUseCase _addAddressUseCase;
  final UserAddressUseCase _userAddressUseCase;

  UserAddressViewModel(
    this._getAddressesUseCase,
    this._addAddressUseCase,
    this._userAddressUseCase,
  ) : super(UserAddressState());

  void doIntent(UserAddressEvent event) {
    switch (event) {
      case GetAddressesEvent():
        _getAddresses();
        break;
      case AddAddressEvent():
        _addAddress(event.request);
        break;
      case EditAddressEvent():
        _editAddress(event.request, event.id);
        break;
      case DeleteAddressEvent():
        _deleteAddress(event.id);
        break;
    }
  }

  Future<void> _getAddresses() async {
    if (isClosed) return;
    emit(
      state.copyWith(
        getAddressesState: BaseState<AddressResponseEntity>(isLoading: true),
      ),
    );

    final response = await _getAddressesUseCase.call();

    switch (response) {
      case SuccessResponse<AddressResponseEntity>():
        if (isClosed) return;
        emit(
          state.copyWith(
            getAddressesState: BaseState(isLoading: false, data: response.data),
          ),
        );
        break;

      case ErrorResponse<AddressResponseEntity>():
        if (isClosed) return;
        emit(
          state.copyWith(
            getAddressesState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _addAddress(AddAddressRequest request) async {
    emit(
      state.copyWith(
        addAddressState: BaseState<AddressResponseEntity>(isLoading: true),
      ),
    );

    final response = await _addAddressUseCase.call(request);

    switch (response) {
      case SuccessResponse<AddressResponseEntity>():
        if (isClosed) return;
        emit(
          state.copyWith(
            addAddressState: BaseState(isLoading: false, data: response.data),
          ),
        );
        await _getAddresses();
        break;

      case ErrorResponse<AddressResponseEntity>():
        emit(
          state.copyWith(
            addAddressState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _editAddress(EditAddressRequest request, String id) async {
    emit(
      state.copyWith(
        editAddressState: BaseState<AddressResponseEntity>(isLoading: true),
      ),
    );

    final response = await _userAddressUseCase.editAddress(request, id);

    switch (response) {
      case SuccessResponse<AddressResponseEntity>():
        if (isClosed) return;
        emit(
          state.copyWith(
            editAddressState: BaseState(isLoading: false, data: response.data),
          ),
        );
        await _getAddresses();
        break;

      case ErrorResponse<AddressResponseEntity>():
        emit(
          state.copyWith(
            editAddressState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  Future<void> _deleteAddress(String id) async {
    emit(
      state.copyWith(
        deleteAddressState: BaseState<AddressResponseEntity>(isLoading: true),
      ),
    );

    final response = await _userAddressUseCase.deleteAddress(id);

    switch (response) {
      case SuccessResponse<AddressResponseEntity>():
        if (isClosed) return;
        emit(
          state.copyWith(
            deleteAddressState: BaseState(
              isLoading: false,
              data: response.data,
            ),
          ),
        );

        await _getAddresses();
        break;

      case ErrorResponse<AddressResponseEntity>():
        emit(
          state.copyWith(
            deleteAddressState: BaseState(
              isLoading: false,
              errorMessage: response.errorMessage,
            ),
          ),
        );
        break;
    }
  }


  void resetDeleteState() {
    emit(
      state.copyWith(deleteAddressState: BaseState<AddressResponseEntity>()),
    );
  }
}
