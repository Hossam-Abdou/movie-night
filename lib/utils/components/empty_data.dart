import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/utils/app_images/app_images.dart';

class CustomEmptyData extends StatelessWidget {
  const CustomEmptyData({super.key});


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.25,
        ),
        Image.asset(
          AppImages.nothing,
        ),
        Text(
          'No movies Found',
          style: GoogleFonts.inter(
            color: Colors.white.withOpacity(0.67),
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
