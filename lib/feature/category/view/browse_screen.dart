import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/feature/category/view/category_movies.dart';
import 'package:movie_night/feature/category/view_model/category_cubit.dart';

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
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  CategoryMovies.routeName,
                  arguments: cubit.moviesGenresModel?.genres?[index],
                );
              },
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(6.r),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://img.freepik.com/premium-photo/photographer-captures-breathtaking-landscape_1275912-30798.jpg',
                    ),
                  ),
                ),
                child: Text(
                  cubit.moviesGenresModel?.genres?[index].name ?? '',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
