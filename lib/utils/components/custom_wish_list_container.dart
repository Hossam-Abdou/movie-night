import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_night/utils/constants/constants.dart';

class CustomWishListContainer extends StatelessWidget {
  final String? firstImage;
  final String? secondImage;
  final double imageHeight;
  final double imageWidth;
  final IconData icon;
  final Function()? onTap;

  const CustomWishListContainer({super.key,
    this.firstImage,
    this.secondImage,
    this.imageHeight=0.23,
    this.imageWidth=0.34,
    this.icon=Icons.add,
    required this.onTap

  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {

          },
          child: Container(
              alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width * imageWidth,
              height: MediaQuery.of(context).size.height * imageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: NetworkImage(
                    '${Constants.imageBaseUrl}$firstImage',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: InkWell(
                onTap: onTap,
                child: Container(
                  height: MediaQuery.sizeOf(context).height*0.048,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      image: AssetImage(
                        '$secondImage',
                      ),
                    ),
                  ),
                  child:  Icon(
                    icon,
                    color: Colors.white,
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
