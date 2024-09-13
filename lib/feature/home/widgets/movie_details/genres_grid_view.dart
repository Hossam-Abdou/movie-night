import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/feature/home/view_model/home_cubit.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';
import 'package:movie_night/utils/app_images/app_images.dart';

class GenresGridView extends StatelessWidget {
  const GenresGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 4.w,
                runSpacing: 10.h,
                children: List.generate(
                  cubit.moviesDetailsModel?.genres?.length ?? 0,
                      (genreIndex) => Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        color: AppColors.searchFieldColor,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      cubit.moviesDetailsModel?.genres?[genreIndex].name ?? '',
                      style: GoogleFonts.aBeeZee(
                        color: Colors.white,
                        fontSize: 10.sp,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h), // Added some spacing
              Text(
                cubit.moviesDetailsModel?.overview ?? '',
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 10.h), // Added some spacing
              Row(
                children: [
                   const ImageIcon(
                    AssetImage(AppImages.star),
                    color: AppColors.yellowColor,
                  ),
                  SizedBox(width: 4.w), // Added some spacing
                  Text(
                    cubit.moviesDetailsModel?.voteAverage.toString() ?? '',
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
