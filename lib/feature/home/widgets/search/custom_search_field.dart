import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';

class CustomSearchField extends StatelessWidget {
  final Function(String)? onTap;

  const CustomSearchField({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.inter(
        color: Colors.white,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      cursorColor: Colors.white.withOpacity(0.67),
      onChanged: onTap, // Trigger the onChanged function when text is updated
      decoration: InputDecoration(
        filled: true,
        prefixIcon: const Icon(
          Icons.search,
          color: AppColors.whiteColor,
        ),
        fillColor: AppColors.searchFieldColor,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.whiteColor,
          ),
        ),
        hintText: 'Search',
        hintStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w400,
          color: Colors.white.withOpacity(0.67),
          fontSize: 14.sp,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: const BorderSide(
            color: Color(0xff7a7a7a),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: const BorderSide(
            color: Color(0xff7a7a7a),
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: const BorderSide(
            color: Color(0xff7a7a7a),
          ),
        ),
      ),
    );
  }
}
