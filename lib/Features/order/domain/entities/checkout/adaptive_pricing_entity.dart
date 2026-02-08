import 'package:equatable/equatable.dart';

class AdaptivePricingEntity extends Equatable {
  final bool? enabled;

  const AdaptivePricingEntity({this.enabled});

  @override
  List<Object?> get props => [enabled];
}
