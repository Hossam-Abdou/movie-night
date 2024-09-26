import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:movie_night/feature/bottom_nav_bar/view/bottom_bar_screen.dart';
import 'package:movie_night/feature/bottom_nav_bar/view_model/bottom_bar_cubit.dart';
import 'package:movie_night/feature/category/view/category_movies.dart';
import 'package:movie_night/feature/home/view/movie_details/movie_details_screen.dart';
import 'package:movie_night/feature/home/view/tabs/home_screen.dart';
import 'package:movie_night/feature/home/view_model/home_cubit.dart';
import 'package:movie_night/feature/splash_screen/splash_screen.dart';
import 'package:movie_night/feature/watch_list/view/rated_movies_screen.dart';
import 'package:movie_night/feature/watch_list/view/watch_list_screen.dart';
import 'package:movie_night/feature/watch_list/view_model/watch_list_cubit.dart';
import 'package:movie_night/utils/services/shared_prefrence/sp_helper.dart';
import 'package:path_provider/path_provider.dart';
import 'utils/app_colors/app_colors.dart';
import 'utils/my_bloc_observer.dart';
import 'utils/services/hive/adapter/hive_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  SharedPrefrenceHelper.init();
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);

  // Register your adapter here
  // Hive.registerAdapter(HiveWatchListAdapter());
  Hive.registerAdapter(HiveRateAdapter());

  // await EasyLocalization.ensureInitialized();
  runApp(
    // EasyLocalization(
    //   supportedLocales: const [Locale('en'), Locale('ar')],
    //   path: 'assets/locales',
    //   startLocale: const Locale('en'),
    //   child:
      const MyApp(),
    // ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomBarCubit()),
        BlocProvider(create: (context) => WatchListCubit()),
        BlocProvider(
          create: (context) => HomeCubit()
            ..getNewReleasesMovies()
            ..getRecommendedMovies()
            ..getPopularMovies(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MaterialApp(
          // localizationsDelegates: context.localizationDelegates,
          // supportedLocales: context.supportedLocales,
          // locale: context.locale,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.primaryColor,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.greyColor,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: BottomBarScreen.routeName,
          routes: {
            HomeScreen.routeName: (context) =>  const HomeScreen(),
            SplashScreen.routeName: (context) => const SplashScreen(),
            BottomBarScreen.routeName: (context) => const BottomBarScreen(),
            CategoryMovies.routeName: (context) => const CategoryMovies(),
            MovieDetailsScreen.routeName: (context) => const MovieDetailsScreen(),
            WatchListScreen.routeName: (context) => const WatchListScreen(),
            RatedMoviesScreen.routeName: (context) => const RatedMoviesScreen(),
            // Trailer.routeName: (context) => const Trailer(),
          },

          // home: SplashScreen()
        ),
      ),
    );
  }
}
