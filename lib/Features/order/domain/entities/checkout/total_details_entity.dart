import 'package:equatable/equatable.dart';

class TotalDetailsEntity extends Equatable {
  final int? amountDiscount;
  final int? amountShipping;
  final int? amountTax;

  const TotalDetailsEntity({
    this.amountDiscount,
    this.amountShipping,
    this.amountTax,
  });

  @override
  List<Object?> get props =>
      [amountDiscount, amountShipping, amountTax];
}