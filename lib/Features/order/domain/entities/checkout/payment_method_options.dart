import 'package:equatable/equatable.dart';

class PaymentMethodOptionsEntity extends Equatable {
  final Card? card;

  const PaymentMethodOptionsEntity({this.card});

  @override
  List<Object?> get props => [card];
}

class Card extends Equatable {
  final String? requestThreeDSecure;

  const Card({this.requestThreeDSecure});

  @override
  List<Object?> get props => [requestThreeDSecure];
}