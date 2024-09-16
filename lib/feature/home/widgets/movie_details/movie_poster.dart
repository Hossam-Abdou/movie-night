import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_night/feature/home/view_model/home_cubit.dart';
import 'package:movie_night/utils/constants/constants.dart';

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key});


  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeCubit, HomeState>(
  builder: (context, state) {
    var cubit = HomeCubit.get(context);
    return Container(
      alignment: Alignment.topLeft,
      width: MediaQuery.of(context).size.width * 0.34,
      height: MediaQuery.of(context).size.height * 0.24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        image: DecorationImage(
          image: NetworkImage(
            (cubit.moviesDetailsModel?.posterPath != null &&
                cubit.moviesDetailsModel!.posterPath!.isNotEmpty)
                ? '${Constants.imageBaseUrl}${cubit.moviesDetailsModel?.posterPath}'
                : 'https://img.freepik.com/premium-vector/modern-design-concept-no-image-found-design_637684-247.jpg',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Container(
        height:MediaQuery.sizeOf(context).height * 0.041,
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),

          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage(
                'assets/images/bookmark.png'),
          ),
        ),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  },
);
  }
}
