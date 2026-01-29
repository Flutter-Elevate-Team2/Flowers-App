import 'package:equatable/equatable.dart';

class CustomerDetailsEntity extends Equatable {
  final String? address;
  final String? bussinessName;
  final String? email;
  final String? individualName;
  final String? name;
  final String? phone;
  final String? taxExempt;

  const CustomerDetailsEntity({this.email, this.phone, this.name ,this.address, this.bussinessName, this.individualName, this.taxExempt});

  @override
  List<Object?> get props => [email, phone, name , address, bussinessName, individualName, taxExempt];
}