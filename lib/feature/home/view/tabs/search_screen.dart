import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_night/feature/home/view_model/home_cubit.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';
import 'package:movie_night/utils/app_images/app_images.dart';
import 'package:movie_night/utils/constants/constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      cursorColor: Colors.white.withOpacity(0.67),
                      onChanged: (query) {
                        cubit.searchMovies(query);
                       if( query =='')
                       {
                         // if the search field is empty show the empty image
                         cubit.searchModel?.results?.isEmpty ?? true;
                       }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.whiteColor,
                        ),
                        fillColor: AppColors.searchFieldColor,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.whiteColor,
                          ),
                        ),
                        hintText: 'Search',
                        hintStyle: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.67),
                          fontSize: 14.sp,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: const BorderSide(
                            color: Color(0xff7a7a7a),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: const BorderSide(
                            color: Color(0xff7a7a7a),
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: const BorderSide(
                            color: Color(0xff7a7a7a),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h,),
                    if (state is SearchMovieLoadingState)
                       Padding(
                        padding: EdgeInsets.all(20.r),
                        child:const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.yellowColor,
                          ),
                        ),
                      ),
                    if (cubit.searchModel?.results?.isEmpty ??
                        true && state is! SearchMovieLoadingState)
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.25,
                          ),
                          Image.asset(
                            AppImages.nothing,
                          ),
                          Text(
                            'No movies Found',
                            style: GoogleFonts.inter(
                              color: Colors.white.withOpacity(0.67),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        separatorBuilder: (context, index) => Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            const Divider(),
                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                        itemCount: cubit.searchModel?.results?.length ?? 0,
                        itemBuilder: (context, index) => Row(
                          children: [
                            InkWell(
                              onTap: () {

                              },
                              child: Container(
                                alignment: Alignment.topLeft,
                                width: MediaQuery.of(context).size.width * 0.33,
                                height:
                                    MediaQuery.of(context).size.height * 0.195,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      '${Constants.imageBaseUrl}${cubit.searchModel?.results?[index].posterPath ?? ''}',
                                    ),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    height: 40.h,
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          AppImages.wishList,
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
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cubit.searchModel?.results?[index].title ??
                                        '',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    maxLines: 2,
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    cubit.searchModel?.results?[index]
                                            .releaseDate ??
                                        '',
                                    style: GoogleFonts.inter(
                                      color: AppColors.secondaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                    cubit.searchModel?.results?[index]
                                            .popularity
                                            .toString() ??
                                        '',
                                    style: GoogleFonts.inter(
                                      color: AppColors.secondaryColor,
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
  }
}
