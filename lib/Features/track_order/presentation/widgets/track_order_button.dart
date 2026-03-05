import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flowers_app/core/widget/custom_button.dart';
import 'package:flutter/material.dart';

class TrackOrderButton extends StatelessWidget {
  final bool isDelivered;
  const TrackOrderButton({this.isDelivered = false, super.key});

  @override
  Widget build(BuildContext context) {
    if (isDelivered) {
      return Row(
        children: [
          Expanded(
            flex: 2,
            child: CustomButton(title: context.l10n.showMap, onPressed: () {}),
          ),
          SizedBox(width: 9),

          Expanded(
            flex: 3,
            child: CustomButton(
              title: context.l10n.orderDelivered,
              onPressed: () {},
            ),
          ),
        ],
      );
    }
    return CustomButton(title: context.l10n.showMap, onPressed: () {});
  }
}
