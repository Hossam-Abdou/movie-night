import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/feature/home/view_model/home_cubit.dart';
import 'package:movie_night/feature/home/widgets/movie_details/genres_grid_view.dart';
import 'package:movie_night/feature/home/widgets/movie_details/movie_background_poster.dart';
import 'package:movie_night/feature/home/widgets/movie_details/movie_poster.dart';
import 'package:movie_night/feature/home/widgets/movie_details/rate_dialog.dart';
import 'package:movie_night/feature/home/widgets/movie_details/similar_movies.dart';
import 'package:movie_night/feature/watch_list/view_model/watch_list_cubit.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';

class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({super.key});

  static String routeName = 'movieDetails';

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<WatchListCubit>(context).loadRateMovies();

    final id = ModalRoute.of(context)?.settings.arguments as dynamic;
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getMovieDetails(id)
        ..getSimilarMovie(id),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          if (state is GetSimilarMovieLoadingState ||
              state is GetMovieDetailsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.yellow,
              ),
            );
          }

          return BlocBuilder<WatchListCubit, WatchListState>(
            builder: (context, state) {
              var watchListCubit = WatchListCubit.get(context);

              bool isRated =
                  watchListCubit.moviesRate.any((movie) => movie.id == id);

              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    cubit.moviesDetailsModel?.title ?? '',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  centerTitle: true,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const MovieBackgroundPoster(),
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cubit.moviesDetailsModel?.title ?? '',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        cubit.moviesDetailsModel?.releaseDate ??
                                            '',
                                        style: GoogleFonts.inter(
                                          color: Colors.grey,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                isRated
                                    ? Text(
                                        'Rated',
                                        // Modify according to your data structure
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    : TextButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return RateDialog(
                                                  cubit: BlocProvider.of<
                                                      WatchListCubit>(context),
                                                  moviesDetailsModel:
                                                      cubit.moviesDetailsModel!,
                                                );
                                              });
                                        },
                                        child: Text(
                                          'Rate Now',
                                          style: TextStyle(
                                            color: AppColors.yellowColor,
                                            fontSize: 13.sp,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const MoviePoster(),
                                SizedBox(width: 10.w),
                                const GenresGridView(),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SimilarMovies(
                              id: id,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
