import 'package:flowers_app/Features/home/presentation/widgets/custom_bottom_nav_bar.dart';
import 'package:flowers_app/Features/home/presentation/widgets/home_screen_body.dart';
import 'package:flowers_app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: CustomButtonNavigationBar(currentIndex: 0, onTap: (int p1) {  },),
      body: HomeScreenBody(),
    );
  }
}