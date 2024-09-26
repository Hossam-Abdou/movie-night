import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/feature/home/view/movie_details/movie_details_screen.dart';
import 'package:movie_night/feature/home/view_model/home_cubit.dart';
import 'package:movie_night/feature/watch_list/view_model/watch_list_cubit.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';
import 'package:movie_night/utils/app_images/app_images.dart';
import 'package:movie_night/utils/constants/constants.dart';
import 'package:shimmer/shimmer.dart';


class NewReleaseWidget extends StatelessWidget {
  const NewReleaseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var homeCubit = HomeCubit.get(context);

        return BlocBuilder<WatchListCubit, WatchListState>(
          builder: (context, state) {
            var watchListCubit = WatchListCubit.get(context);

            return Container(
              height: MediaQuery.of(context).size.height * 0.37,
              color: AppColors.greyColor,
              child: Padding(
                padding: EdgeInsets.all(12.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Releases',
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => SizedBox(
                          width: 12.w,
                        ),
                        itemCount:
                            homeCubit.newReleaseModel?.results?.length ?? 0,
                        itemBuilder: (context, index) {
                          final movie =
                              homeCubit.newReleaseModel?.results?[index];
                          final isInWatchlist = watchListCubit
                                  .watchListModel?.results
                                  ?.any((e) => e.id == movie?.id) ??
                              false;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: '${Constants.imageBaseUrl}${movie?.posterPath}',
                                    fit: BoxFit.fill,
                                    width: MediaQuery.of(context).size.width * 0.39,
                                    height: MediaQuery.of(context).size.height * 0.28,
                                    placeholder: (context, url) =>Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child:  Container(
                                        width: MediaQuery.of(context).size.width * 0.39,
                                        height: MediaQuery.of(context).size.height * 0.28,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.r),),),
                                    ),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                    imageBuilder: (context, imageProvider) => InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                          context,
                                          MovieDetailsScreen.routeName,
                                          arguments: movie?.id,
                                        );
                                      },
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        width: MediaQuery.of(context).size.width * 0.39,
                                        height: MediaQuery.of(context).size.height * 0.28,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.r),
                                          image: DecorationImage(
                                            image: imageProvider, // Use image from CachedNetworkImage
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            // Toggle watchlist
                                            watchListCubit.addToWatchList(
                                              isWatchList: (watchListCubit.watchListModel?.results
                                                  ?.any((e) => e.id == homeCubit.newReleaseModel
                                                  ?.results?[index].id) ??
                                                  false)
                                                  ? false
                                                  : true,
                                              id: homeCubit.newReleaseModel?.results?[index].id,
                                            );
                                          },
                                          child: Image.asset(
                                            width: 24.w,
                                            isInWatchlist ? AppImages.bookmark13 : AppImages.bookmark12,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
