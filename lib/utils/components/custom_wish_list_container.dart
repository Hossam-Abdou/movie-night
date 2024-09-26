import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_night/utils/app_images/app_images.dart';
import 'package:movie_night/utils/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class CustomWishListContainer extends StatelessWidget {
  final String? firstImage;
  // final String? secondImage;
  final double imageHeight;
  final double imageWidth;
  final bool isInWatchlist;
  // final IconData icon;
  final Function()? iconOnTap;
  final Function()? onTap;

  const CustomWishListContainer({super.key,
    this.firstImage,
    required this.isInWatchlist,
    // this.secondImage,
    this.imageHeight=0.23,
    this.imageWidth=0.34,
    // this.icon=Icons.add,
    required this.iconOnTap,
    required this.onTap

  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '${Constants.imageBaseUrl}$firstImage',
          fit: BoxFit.fill,
          placeholder: (context, url) =>Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child:  Container(
              width: MediaQuery.of(context).size.width * imageWidth,
              height: MediaQuery.of(context).size.height * imageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),),),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
          imageBuilder: (context, imageProvider) => InkWell(
            onTap:onTap,
            child: Container(
              alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width * imageWidth,
              height: MediaQuery.of(context).size.height * imageHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                image: DecorationImage(
                  image: imageProvider, // Use image from CachedNetworkImage
                  fit: BoxFit.fill,
                ),
              ),
              child: InkWell(
                onTap:iconOnTap,
                child: Image.asset(
                  width: 24.w,
                  isInWatchlist ? AppImages.bookmark13 : AppImages.bookmark12,
                ),
              ),
            ),
          ),
        ),
        // InkWell(
        //   onTap: onTap,
        //   child: Container(
        //       alignment: Alignment.topLeft,
        //       width: MediaQuery.of(context).size.width * imageWidth,
        //       height: MediaQuery.of(context).size.height * imageHeight,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(10.r),
        //         image: DecorationImage(
        //           image: NetworkImage(
        //             '${Constants.imageBaseUrl}$firstImage',
        //           ),
        //           fit: BoxFit.fill,
        //         ),
        //       ),
        //       child: InkWell(
        //         onTap: iconOnTap,
        //         child: Image.asset(
        //           width: 24.w,
        //           isInWatchlist
        //               ? AppImages.bookmark13
        //               : AppImages.bookmark12,
        //         ),
        //       )),
        // ),
      ],
    );
  }
}
