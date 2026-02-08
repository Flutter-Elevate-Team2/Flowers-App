import 'package:flowers_app/Features/user_address/data/models/add_address_request.dart';
import 'package:flowers_app/Features/user_address/data/models/edit_address_request/edit_address_request.dart';

sealed class UserAddressEvent {}

class GetAddressesEvent extends UserAddressEvent {}

class AddAddressEvent extends UserAddressEvent {
  final AddAddressRequest request;
  AddAddressEvent(this.request);
}

class EditAddressEvent extends UserAddressEvent {
  final EditAddressRequest request;
  final String id;
  EditAddressEvent(this.request, this.id);
}

class DeleteAddressEvent extends UserAddressEvent {
  final String id;
  DeleteAddressEvent(this.id);
}
