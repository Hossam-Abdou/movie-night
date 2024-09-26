import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_night/feature/home/view_model/home_cubit.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';
import 'package:movie_night/utils/constants/constants.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return CachedNetworkImage(
          imageUrl: '${Constants.imageBaseUrl}${cubit.moviesDetailsModel?.posterPath}',
          placeholder: (context, url) => SizedBox(
              width: MediaQuery.of(context).size.width * 0.34,
              child: const Center(
                child: CircularProgressIndicator(
                  color: AppColors.yellowColor,
                ),
              )),
          errorWidget: (context, url, error) => Container(
            width: MediaQuery.of(context).size.width * 0.34,
            height: MediaQuery.of(context).size.height * 0.24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: const DecorationImage(
                image: NetworkImage(
                  'https://img.freepik.com/premium-vector/modern-design-concept-no-image-found-design_637684-247.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          imageBuilder: (context, imageProvider) => Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width * 0.34,
            height: MediaQuery.of(context).size.height * 0.24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: NetworkImage(
                    '${Constants.imageBaseUrl}${cubit.moviesDetailsModel?.posterPath}'),
                fit: BoxFit.fill,
              ),
            ),
            // child: Container(
            //   height: MediaQuery.of(context).size.height * 0.05,
            //   decoration: const BoxDecoration(
            //     color: Colors.transparent,
            //     image: DecorationImage(
            //       image: AssetImage('assets/images/bookmark.png'),
            //     ),
            //   ),
            //   child: const Icon(
            //     Icons.add,
            //     color: Colors.white,
            //   ),
            // ),
          ),
        );
      },
    );
  }
}
