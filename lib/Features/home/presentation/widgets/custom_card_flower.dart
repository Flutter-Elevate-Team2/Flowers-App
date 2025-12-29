import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/theming/font_style_manager.dart';

class CustomCardFlower extends StatelessWidget {
  const CustomCardFlower({super.key,
    required this.image,required this.title,
    required this.newPrice, this.oldPrice,
    this.discount,
  });
  final String image;final String title;final double newPrice;
  final double? oldPrice;final  int? discount;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 163.0,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.circular(8.0),
          border: Border.all(
              width: 1.0,
              color: AppColors.gray
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(imageUrl: image,width:147.0 ,
            height:131.0 ,
            fit: BoxFit.cover,
            placeholder: (context,_)=>CircularProgressIndicator(),
            errorWidget: (context,_,error)=>Center(
              child: Icon(Icons.image_not_supported_rounded,
                color: AppColors.gray,
                size: 24.0,
              ),
            ),
          ),

          SizedBox(height: 5.0,),
          Text(title,style: getRegularStyle(color:
          AppColors.black[60]!,fontSize: 12.0),)
          ,SizedBox(height: 5.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("EGP ${newPrice} ",style: getMediumStyle(color:
              AppColors.black[60]!,fontSize: 14.0),),
              Text("${oldPrice}",style:
              getRegularStyle(color:
              AppColors.black[60]!,fontSize: 12.0).copyWith(
                  decoration: TextDecoration.lineThrough
              ),),
              Text("${discount}%",style:
              getRegularStyle(color:
              AppColors.green,fontSize: 12.0),),

            ],
          ),
          SizedBox(height: 5.0,),
          ElevatedButton(

              onPressed: (){}, child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.cart,color: Colors.white,),
              SizedBox(width: 7.0,),
              Text("Add to Cart",style: getMediumStyle(color: Colors.white,fontSize: 13.0),)
            ],
          ))
        ],
      ),
    );
  }
}