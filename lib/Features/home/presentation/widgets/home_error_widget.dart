import 'package:flowers_app/Features/home/presentation/view_model/home_events.dart';
import 'package:flowers_app/Features/home/presentation/view_model/home_view_model.dart';
import 'package:flowers_app/core/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeErrorWidget extends StatelessWidget {
  final String errorMessage;

  const HomeErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(errorMessage),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              context.read<HomeViewModel>().doIntent(GetHomeDataEvent());
            },
            child: Text(AppLocalizations.of(context)!.retryButton),
          ),
        ],
      ),
    );
  }
}
