import 'package:flowers_app/Features/home/presentation/widgets/custom_button_nav_bar.dart';
import 'package:flowers_app/Features/home/presentation/widgets/home_screen_body.dart';
import 'package:flowers_app/Features/products/presentation/views/screens/categories_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreenBody(),
    CategoriesScreen(),
    Container(),
    Container(),
    // CategoriesScreen(),
    // CartScreen(),
    // ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomButtonNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}