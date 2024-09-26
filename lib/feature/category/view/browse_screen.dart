import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/feature/category/view/category_movies.dart';
import 'package:movie_night/feature/category/view_model/category_cubit.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';
import 'package:movie_night/utils/constants/constants.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..getMovieGenres(),
      child: BlocConsumer<CategoryCubit, CategoryState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CategoryCubit.get(context);
          return GridView.builder(
            itemCount: cubit.moviesGenresModel?.genres?.length ?? 0,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 2,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  CategoryMovies.routeName,
                  arguments: cubit.moviesGenresModel?.genres?[index],
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.17,

                      child: Image.asset(
                        Constants.images[index],
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  ShaderMask(
                    shaderCallback: (bounds) => RadialGradient(
                      center: Alignment.topLeft,
                      radius: 1,
                      colors: <Color>[
                        AppColors.yellowColor,
                        AppColors.whiteColor
                      ],
                      tileMode: TileMode.mirror,
                    ).createShader(bounds),
                    child: Text(
                      cubit.moviesGenresModel?.genres?[index].name ?? '',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
