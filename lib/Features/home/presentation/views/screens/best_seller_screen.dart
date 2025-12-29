

import 'package:flutter/material.dart';

import '../../../../../core/constants/assets_manager.dart';
import '../../../../../core/constants/constant_keys.dart';
import '../../widgets/custom_card_flower.dart';



class BestSeller extends StatelessWidget{
  const BestSeller({super.key});

  @override
  Widget build(BuildContext context) {
    // ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ConstKeys.bestseller,style: Theme.of(context).textTheme.titleLarge),
            Text(ConstKeys.bestseller2,style: Theme.of(context).textTheme.titleSmall)
          ],
        ),
        centerTitle: false,

      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 0.6,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return const CustomCardFlower(title:ConstKeys.cardtitle,oldPrice: 800,image: AssetsManager.testPhoto, newPrice: 600,discount: 20,);
        },
      ),

    );
  }

}