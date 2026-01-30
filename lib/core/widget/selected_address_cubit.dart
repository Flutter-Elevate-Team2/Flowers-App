import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/Features/user_address/domain/entities/address_entity.dart';

class SelectedAddressCubit extends Cubit<AddressEntity?> {
  SelectedAddressCubit() : super(null);

  void select(AddressEntity address) => emit(address);

  void clear() => emit(null);
}
