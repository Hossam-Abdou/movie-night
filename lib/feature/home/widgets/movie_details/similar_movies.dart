import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/feature/home/view/movie_details/movie_details_screen.dart';
import 'package:movie_night/feature/home/view_model/home_cubit.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';
import 'package:movie_night/utils/constants/constants.dart';

class SimilarMovies extends StatelessWidget {
  final int id;

  const SimilarMovies({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getSimilarMovie(id),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return Container(
            height: MediaQuery.sizeOf(context).height * 0.37,
            padding: EdgeInsets.all(5.r),
            color: AppColors.greyColor,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: cubit.similarMoviesModel?.results?.length ?? 0,
              separatorBuilder: (context, index) => SizedBox(
                width: 12.w,
              ),
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              MovieDetailsScreen.routeName,
                              arguments: cubit.similarMoviesModel?.results?[index].id,
                            );
                          },
                          child: Container(
                              alignment: Alignment.topLeft,
                              width: MediaQuery.of(context).size.width * 0.42,
                              height: MediaQuery.of(context).size.height * 0.25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: DecorationImage(
                                  image: NetworkImage(
                                    (cubit.similarMoviesModel?.results?[index]
                                        .posterPath !=
                                        null &&
                                        cubit
                                            .similarMoviesModel!
                                            .results![index]
                                            .posterPath!
                                            .isNotEmpty)
                                        ? '${Constants.imageBaseUrl}${cubit.similarMoviesModel?.results?[index].posterPath}'
                                        : 'https://img.freepik.com/premium-vector/modern-design-concept-no-image-found-design_637684-247.jpg',
                                  ),

                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: Container(
                                height:MediaQuery.sizeOf(context).height * 0.05,
                                decoration: const BoxDecoration(
                                  color: Colors.transparent,
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/bookmark.png',
                                    ),
                                  ),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          const ImageIcon(
                            AssetImage('assets/images/star.png'),
                            color: Color(0xffFFBB3B),
                          ),
                          // Icon(Icons.star,color: Colors.yellow,),
                          Text(
                            cubit.similarMoviesModel?.results?[index]
                                    .voteAverage
                                    .toString() ??
                                '',
                            style: GoogleFonts.poppins(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        cubit.similarMoviesModel?.results?[index].title ?? '',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Text(
                      '2018  R  1h 59m',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
