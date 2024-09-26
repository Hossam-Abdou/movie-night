import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';
import 'package:movie_night/utils/app_images/app_images.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomPopularLoadingState extends StatelessWidget {
  const CustomPopularLoadingState({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: CarouselSlider(
        options: CarouselOptions(
          height: MediaQuery.of(context).size.height * 0.45,
          autoPlay: false,
          viewportFraction: 1,
        ),
        items: List.generate(
          10, // Number of skeleton loaders to display
          (index) => Builder(
            builder: (BuildContext context) {
              return Stack(
                children: [
                  Container(
                    color: Colors.grey[300],
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.22,
                    left: MediaQuery.of(context).size.width * 0.07,
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.26,
                          height: MediaQuery.of(context).size.height * 0.21,
                          alignment: Alignment.topRight,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.25),
                                spreadRadius: 3,
                                blurRadius: 2,
                              ),
                            ],
                            borderRadius: BorderRadius.circular(15.r),
                          ),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.05,
                            width: MediaQuery.of(context).size.width * 0.1,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                              image: DecorationImage(
                                image: AssetImage(
                                  AppImages.bookmark,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ' ',
                              style: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 40.h),
                            Text(
                              '',
                              style: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height:
                                  MediaQuery.of(context).size.height * 0.038,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: AppColors.yellowColor,
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
