import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/feature/home/view/movie_details/movie_details_screen.dart';
import 'package:movie_night/feature/home/view_model/home_cubit.dart';
import 'package:movie_night/feature/home/widgets/search/custom_search_field.dart';
import 'package:movie_night/feature/watch_list/view_model/watch_list_cubit.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';
import 'package:movie_night/utils/app_images/app_images.dart';
import 'package:movie_night/utils/components/empty_data.dart';
import 'package:movie_night/utils/constants/constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, homeState) {
        final cubit = HomeCubit.get(context);
        final watchListCubit = WatchListCubit.get(context);

        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomSearchField(
                      onTap: (query) {
                        cubit.searchMovies(query);
                      },
                    ),
                    SizedBox(height: 16.h),
                    if (homeState is SearchMovieLoadingState)
                      Padding(
                        padding: EdgeInsets.all(20.r),
                        child: const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.yellowColor,
                          ),
                        ),
                      )
                    else if ((cubit.searchModel?.results?.isEmpty ?? true))
                      CustomEmptyData()
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Column(
                          children: [
                            SizedBox(height: 10.h),
                            const Divider(),
                            SizedBox(height: 10.h),
                          ],
                        ),
                        itemCount: cubit.searchModel?.results?.length ?? 0,
                        itemBuilder: (context, index) {
                          final movie = cubit.searchModel?.results?[index];
                          final isInWatchlist = watchListCubit.watchListModel?.results
                              ?.any((e) => e.id == movie?.id) ??
                              false;

                          return Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    MovieDetailsScreen.routeName,
                                    arguments: movie?.id,
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  width: MediaQuery.of(context).size.width * 0.33,
                                  height: MediaQuery.of(context).size.height * 0.195,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        '${Constants.imageBaseUrl}${movie?.posterPath ?? ''}',
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      watchListCubit.addToWatchList(
                                        isWatchList: !isInWatchlist,
                                        id: movie?.id,
                                      );
                                    },
                                    child: Image.asset(
                                      width: 24.w,
                                      isInWatchlist
                                          ? AppImages.bookmark13
                                          : AppImages.bookmark12,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      movie?.title ?? '',
                                      style: GoogleFonts.inter(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      maxLines: 2,
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      movie?.releaseDate ?? '',
                                      style: GoogleFonts.inter(
                                        color: AppColors.secondaryColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      movie?.popularity.toString() ?? '',
                                      style: GoogleFonts.inter(
                                        color: AppColors.secondaryColor,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
