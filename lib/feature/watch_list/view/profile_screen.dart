import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/feature/watch_list/view/watch_list_screen.dart';
import 'package:movie_night/feature/watch_list/view_model/watch_list_cubit.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';
import 'package:movie_night/utils/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shimmer/shimmer.dart';

import 'rated_movies_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) =>
      WatchListCubit()
        ..getProfileData()
        ..getWatchList(),
      child: BlocBuilder<WatchListCubit, WatchListState>(
        builder: (context, state) {
          var cubit = WatchListCubit.get(context);
          if (state is GetProfileDataLoadingState ||
              state is GetMoviesWatchListLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.yellowColor,
              ),
            );
          }

          return Padding(
            padding: EdgeInsets.all(12.r),
            child: SafeArea(
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: '${Constants.imageBaseUrl}${cubit.getProfileModel?.avatar
                        ?.tmdb?.avatarPath }',
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child:  CircleAvatar(
                        radius: 45.r,
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),

                    imageBuilder: (context, imageProvider) => CircleAvatar(
                      radius: 45.r,
                      backgroundImage: NetworkImage(
                        '${Constants.imageBaseUrl}${cubit.getProfileModel?.avatar
                            ?.tmdb?.avatarPath ?? ''}',
                      ),
                    ),
                  ),
                  // CircleAvatar(
                  //   radius: 45.r,
                  //   backgroundImage: NetworkImage(
                  //     '${Constants.imageBaseUrl}${cubit.getProfileModel?.avatar
                  //         ?.tmdb?.avatarPath ?? ''}',
                  //   ),
                  // ),
                  Text(
                    cubit.getProfileModel?.name ?? '',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    cubit.getProfileModel?.username ?? '',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'My Movies',
                      style: GoogleFonts.poppins(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, WatchListScreen.routeName);
                    },
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: AppColors.yellowColor, width: 2.w)),
                    title: Text(
                      'WatchList ',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                    ),
                    leading: const Icon(Icons.bookmark_border_outlined,
                      color: AppColors.yellowColor,),
                    // trailing: CircleAvatar(
                    //   radius: 13.r,
                    //   backgroundColor: AppColors.lightGreyColor,
                    //   child: Text(
                    //     cubit.watchListModel?.results?.length.toString() ?? '0',
                    //     style: GoogleFonts.poppins(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.bold,
                    //     ),
                    //   ),
                    // ),
                  ),
                  SizedBox(height: 20.h),
                  ListTile(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: AppColors.yellowColor, width: 2.w)),
                    onTap: () async {
                      final result = await Navigator.pushNamed(
                        context,
                        RatedMoviesScreen.routeName,
                      );
                      if (result == true) {
                        cubit.loadRateMovies();
                      }
                    },
                    title: Text(
                      'Rated Movies',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                    ),
                    leading: const Icon(
                        Icons.star_rate_outlined, color: AppColors.yellowColor),
                    // trailing: Text(
                    //   cubit.getRatedMoviesModel?.totalResults.toString() ?? '0',
                    //   style: GoogleFonts.poppins(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ),
                  SizedBox(height: 20.h),
                  ListTile(
                    shape: StadiumBorder(
                        side: BorderSide(
                            color: AppColors.yellowColor, width: 2.w)),
                    onTap: () {
                      Uri uri = Uri.parse(
                          'https://developer.themoviedb.org/docs/faq');
                      launchUrl(uri);
                    },
                    title: Text(
                      'About',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                      ),
                    ),
                    leading:const ImageIcon(
                        color: AppColors.yellowColor,
                        AssetImage(
                      'assets/images/movies.png',

                    )),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
