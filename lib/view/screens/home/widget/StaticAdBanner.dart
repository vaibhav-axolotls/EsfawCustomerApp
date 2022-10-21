import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sixam_mart/util/images.dart';
import '../../../../util/dimensions.dart';

class StaticAdBanner extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Center(
        child: Container(
          margin:
          EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL,left: Dimensions.PADDING_SIZE_SMALL),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_LARGE),
            boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], blurRadius: 5, spreadRadius: 2)],

          ),
          alignment: Alignment.center,
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(
                  Dimensions.RADIUS_LARGE),
              child: Image.asset(Images.static_banner),
            ),
            SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),

          ]),),);



  }
}