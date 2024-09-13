import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_night/feature/bottom_nav_bar/view_model/bottom_bar_cubit.dart';
import 'package:movie_night/utils/app_colors/app_colors.dart';
import 'package:movie_night/utils/app_strings/app_strings.dart';


class BottomBarScreen extends StatelessWidget {
  const BottomBarScreen({super.key});
  static String routeName = 'bottomBar';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomBarCubit, BottomBarState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = BottomBarCubit.get(context);
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: AppColors.lightGreyColor,
            selectedItemColor: AppColors.yellowColor,
            backgroundColor: AppColors.primaryColor,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.home,
                  size: 20,
                  // color: Colors.red,
                ),
                label: AppStrings.home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.search,
                  size: 25,
                  // color: Colors.white,
                ),
                label: AppStrings.search,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.movie,
                  size: 20,
                  // color: Colors.white,
                ),
                label: AppStrings.browse,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.account_circle_outlined,
                  size: 20,
                  // color: Colors.white,
                ),
                label: AppStrings.profile,
              ),
            ],
            currentIndex: cubit.currentIndex,
            onTap: (currentIndex) => cubit.changeIndex(currentIndex),
          ),
          body: cubit.layouts[cubit.currentIndex],
        );
      },
    );
  }
}
