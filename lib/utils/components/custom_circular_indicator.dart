import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';

class CustomCircularIndicator extends StatelessWidget {
   bool isSearchScreen;

  CustomCircularIndicator({super.key, this.isSearchScreen = false}); // default value

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(isSearchScreen ? 20.r : 12), // ternary operator to handle padding
      child: const Center(
        child: CircularProgressIndicator(
          color: AppColors.yellowColor,
        ),
      ),
    );
  }
}
