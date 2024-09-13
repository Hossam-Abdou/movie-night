import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/feature/home/view/movie_details/movie_details_screen.dart';
import 'package:movie_night/feature/watch_list/delete_dialog.dart';
import 'package:movie_night/feature/watch_list/view_model/watch_list_cubit.dart';
import 'package:movie_night/utils/app_images/app_images.dart';
import 'package:movie_night/utils/constants/constants.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';

class RatedMoviesScreen extends StatelessWidget {
  static const String routeName = 'RatedMoviesScreen';

  const RatedMoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchListCubit()..getRatedMovies(),
      child: BlocBuilder<WatchListCubit, WatchListState>(
        builder: (context, state) {
          var cubit = WatchListCubit.get(context);

          if (state is GetRatedMoviesLoadingState ||
              state is DeleteRatedMoviesLoadingState) {
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.yellowColor,
            ));
          }
          if (state is GetRatedMoviesSuccessState &&
              cubit.getRatedMoviesModel!.results!.isEmpty) {
            return Scaffold(
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.25,
                  ),
                  Image.asset(
                    AppImages.nothing,
                    height: MediaQuery.sizeOf(context).height * 0.2,
                  ),
                  Text(
                    'No movies Found',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      color: Colors.white.withOpacity(0.67),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is GetRatedMoviesErrorState) {
            return Scaffold(
              body: Center(
                child: Text(
                  'Error loading movies:',
                  style: GoogleFonts.inter(color: Colors.red, fontSize: 16.sp),
                ),
              ),
            );
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Rates',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 22.sp,
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: EdgeInsets.all(12.r),
              child: ListView.separated(
                itemCount: cubit.getRatedMoviesModel?.totalResults ?? 0,
                separatorBuilder: (context, index) => SizedBox(
                  height: 15.h,
                ),
                itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, MovieDetailsScreen.routeName,
                            arguments:
                                cubit.getRatedMoviesModel?.results?[index].id);
                      },
                      child: Container(
                        alignment: Alignment.topLeft,
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * .2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          image: DecorationImage(
                            image: NetworkImage(
                              '${Constants.imageBaseUrl}/${cubit.getRatedMoviesModel?.results?[index].posterPath}',
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.06,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            cubit.getRatedMoviesModel?.results?[index].title ??
                                '',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '${cubit.getRatedMoviesModel?.results?[index].releaseDate ?? " ".substring(0, 4)}',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          // Rating Display and Update

                          SizedBox(
                            height: 10.h,
                          ),
                          Row(
                            children: [
                              Text(
                                'Your Rate  ',
                                style: GoogleFonts.poppins(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(8.r),
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreyColor,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Text(
                                  cubit.getRatedMoviesModel?.results?[index]
                                          .rating
                                          .toString() ??
                                      '',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.46,
                            child: PannableRatingBar(
                              rate: cubit.getRatedMoviesModel?.results?[index]
                                      .rating ??
                                  0,
                              // This will display the current rating
                              items: List.generate(
                                10,
                                (index) => const RatingWidget(
                                  selectedColor: AppColors.yellowColor,
                                  unSelectedColor: Colors.grey,
                                  child: Icon(
                                    Icons.star,
                                    size: 20,
                                  ),
                                ),
                                growable: true,
                              ),
                            ),
                          ),
                          TextButton(
                              onPressed: () async {
                                await showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (BuildContext context) {
                                    return DeleteDialog(onTap: () {
                                      cubit.deleteRate(cubit.getRatedMoviesModel
                                          ?.results?[index].id);

                                      Navigator.of(context).pop();
                                    });
                                  },
                                );
                              },
                              child: Text(
                                'Delete Rate',
                                style: GoogleFonts.poppins(
                                  color: Colors.redAccent,
                                  fontSize: 12.sp,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
