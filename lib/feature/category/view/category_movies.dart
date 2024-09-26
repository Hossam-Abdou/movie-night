import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/feature/category/view_model/category_cubit.dart';
import 'package:movie_night/feature/home/view/movie_details/movie_details_screen.dart';
import 'package:movie_night/feature/watch_list/view_model/watch_list_cubit.dart';
import 'package:movie_night/utils/components/custom_rate.dart';
import 'package:movie_night/utils/components/custom_wish_list_container.dart';

class CategoryMovies extends StatelessWidget {
  const CategoryMovies({super.key});

  static const String routeName = 'categoryMovies';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as dynamic;

    return BlocProvider(
      create: (context) => CategoryCubit()..getCategoryMovies(id.id.toString()),
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {
          if (state is CategoryMovieLoadingState) {
            const Center(child: CircularProgressIndicator());
          }
        },
        builder: (context, state) {
          var cubit = CategoryCubit.get(context);

          return BlocBuilder<WatchListCubit, WatchListState>(
            builder: (context, state) {
              var watchListCubit = WatchListCubit.get(context);
              return Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            id.name,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20.sp,
                            ),
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              final isInWatchlist = watchListCubit
                                      .watchListModel?.results
                                      ?.any((e) =>
                                          e.id ==
                                          cubit.categoryMovieModel
                                              ?.results?[index].id) ??
                                  false;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: CustomWishListContainer(
                                      isInWatchlist: isInWatchlist,
                                      firstImage:
                                          '${cubit.categoryMovieModel?.results?[index].posterPath}',
                                      // secondImage: AppImages.bookmark,
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          MovieDetailsScreen.routeName,
                                          arguments: cubit.categoryMovieModel
                                              ?.results?[index].id,
                                        );
                                      },
                                      iconOnTap: () {
                                        watchListCubit.addToWatchList(
                                          isWatchList: (watchListCubit
                                                      .watchListModel?.results
                                                      ?.any((e) =>
                                                          e.id ==
                                                          cubit
                                                              .categoryMovieModel
                                                              ?.results?[
                                                                  index]
                                                              .id) ??
                                                  false)
                                              ? false
                                              : true,
                                          id: cubit.categoryMovieModel
                                              ?.results?[index].id,
                                        );
                                      },
                                    ),
                                  ),
                                  CustomRate(
                                    rate: cubit.categoryMovieModel
                                        ?.results?[index].voteAverage
                                        .toString(),
                                  ),
                                  Text(
                                    cubit.categoryMovieModel?.results?[index]
                                            .title ??
                                        '',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '${cubit.categoryMovieModel?.results?[index].releaseDate?.substring(0, 4)}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              );
                            },
                            itemCount:
                                cubit.categoryMovieModel?.results?.length ?? 0,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10.h,
                              crossAxisSpacing: 10.w,
                              childAspectRatio: 0.6,
                            ),
                          ),
                        ],
                      ),
                    ),
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
