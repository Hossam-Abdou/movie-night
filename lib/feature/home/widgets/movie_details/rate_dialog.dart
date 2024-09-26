import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/feature/home/model/movie_details_model.dart';
import 'package:movie_night/feature/watch_list/view_model/watch_list_cubit.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';
import 'package:movie_night/utils/services/hive/adapter/hive_adapter.dart';

class RateDialog extends StatelessWidget {
  final WatchListCubit cubit;
  final MoviesDetailsModel moviesDetailsModel;

  const RateDialog({super.key,
    required this.cubit,
    required this.moviesDetailsModel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.black.withOpacity(0.6),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColors.yellowColor,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Text(
                  cubit.rating.toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 17.sp,
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              PannableRatingBar(
                maxRating: 10,
                rate: cubit.rating,
                items: List.generate(
                  10,
                      (index) =>
                  const RatingWidget(
                    selectedColor: AppColors.yellowColor,
                    unSelectedColor: Colors.grey,
                    child: Icon(
                      Icons.star,
                      size: 30,
                    ),
                  ),
                  growable: true,
                ),
                onChanged: (value) {
                  final roundedValue = (value * 2).round() / 2;

                  setState(() {
                    cubit.rating = roundedValue;
                  });
                },
              ),
            ],
          );
        },
      ),
      actions: [
        BlocBuilder<WatchListCubit, WatchListState>(
          builder: (context, state) {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  MovieRateManager().rateMovie(
                    title:moviesDetailsModel.title,
                    id: moviesDetailsModel.id,
                    posterPath: moviesDetailsModel.posterPath,
                    voteAverage: moviesDetailsModel.voteAverage,
                    rating: cubit.rating,
                  );
                  // cubit.addRate(
                  //   rateValue: cubit.rating,
                  //   movieId: movieId,
                  // );
                  Navigator.pop(context);
                },
                child: Text(
                  'Rate',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
