import 'package:flutter/material.dart';

class TextSection extends StatelessWidget {
  const TextSection({super.key, required this.tittle, required this.subTitle});
final String tittle;
final String subTitle;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(tittle ,style: Theme.of(context).textTheme.headlineMedium,textAlign: TextAlign.center,),
        SizedBox(height: 10,),
        Text(subTitle,style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Colors.grey,
          fontSize: 14
        ),textAlign: TextAlign.center,),
        
      ],
    );
  }
}
