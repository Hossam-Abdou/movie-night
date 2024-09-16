import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/feature/home/view/movie_details/movie_details_screen.dart';
import 'package:movie_night/feature/home/view_model/home_cubit.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';
import 'package:movie_night/utils/app_images/app_images.dart';
import 'package:movie_night/utils/constants/constants.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomPopularWidget extends StatelessWidget {
  const CustomPopularWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        // Show skeleton loader while data is loading
        if (state is PopularLoadingState) {
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
                                    height: MediaQuery.of(context).size.height * 0.038,
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

        // Display actual content when data is loaded
        return CarouselSlider(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.45,
            autoPlay: true,
            viewportFraction: 1,
          ),
          items: cubit.popularMoviesModel?.results?.map((movie) {
            return Builder(
              builder: (BuildContext context) {
                return Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          MovieDetailsScreen.routeName,
                          arguments: movie.id,
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: MediaQuery.of(context).size.height * 0.3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                '${Constants.imageBaseUrl}${movie.backdropPath}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
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
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  '${Constants.imageBaseUrl}${movie.posterPath}',
                                ),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                height:MediaQuery.sizeOf(context).height * 0.041,
                                decoration:  BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      AppImages.bookmark,
                                    ),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 40.h),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: DefaultTextStyle(
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  child: AnimatedTextKit(
                                    repeatForever: true,
                                    animatedTexts: [
                                      TyperAnimatedText(movie.title ?? ''),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                movie.releaseDate?.substring(0, 4) ?? '',
                                style: GoogleFonts.inter(
                                  color: Colors.grey,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 5.h),
                              InkWell(
                                onTap: () async {
                                  await cubit.getMovieTrailer(movie.id.toString());
                                  if (cubit.movieTrailerModel?.results?.isNotEmpty ?? false) {
                                    final trailerKey = cubit.movieTrailerModel?.results?[0].key;
                                    if (trailerKey != null) {
                                      Uri uri = Uri.parse('https://youtu.be/$trailerKey');
                                      if (await canLaunchUrl(uri)) {
                                        await launchUrl(uri);
                                      } else {
                                        debugPrint('Could not launch $uri');
                                      }
                                    } else {
                                      debugPrint('Trailer key is null');
                                    }
                                  } else {
                                    debugPrint('No trailer available for this movie');
                                  }
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  height: MediaQuery.of(context).size.height * 0.038,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColors.yellowColor,
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  child: Text(
                                    'Watch Now',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 11.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList()??[],
        );
      },
    );
  }
}
