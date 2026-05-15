import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flowers_app/core/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DriverInfo extends StatelessWidget {
  final String name ;
  final String phone ;
  const DriverInfo({required this.name , required this.phone , super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            'assets/icons/Delivery Boy.svg',
            fit: BoxFit.fill,
            height: 36,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name),
              const SizedBox(height: 4),
              Text(
                context.l10n.isYourDelivery,
                style: Theme.of(context).textTheme.bodySmall!
                    .copyWith(
                  color: AppColors.gray.withValues(alpha: 0.6),
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        IconButton(onPressed: () {
          launchUrl(Uri.parse("tel:$phone"));
        }, icon: Icon(Icons.call_outlined)),
        IconButton(
          onPressed: () {
            launchUrl(Uri.parse("https://wa.me/$phone"));
          },
          icon: FaIcon(FontAwesomeIcons.whatsapp),
        ),
      ],
    );
  }
}
