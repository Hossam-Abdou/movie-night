// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:movie_night/feature/home/view_model/home_cubit.dart';
// import 'package:pod_player/pod_player.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// class Trailer extends StatelessWidget {
//   const Trailer({super.key});
//
//   static String routeName = 'trailer';
//
//   @override
//   Widget build(BuildContext context) {
//     final videoKey = ModalRoute.of(context)!.settings.arguments as String;
//     // final videoKey = ModalRoute.of(context)!.settings.arguments as String;
//     // print(videoKey.runtimeType);
//     return BlocProvider(
//       create: (context) => HomeCubit()..getMovieTrailer(videoKey),
//       child: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           final cubit = HomeCubit.get(context);
//           return Scaffold(
//             body: SafeArea(
//               child: Padding(
//                 padding:  EdgeInsets.all(18.r),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//
//                     Text(
//                       'Trailers',
//                       style: GoogleFonts.poppins(
//                         color: Colors.white,
//                         fontSize: 22.sp,
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//                    Expanded(
//                      child: ListView.separated(
//                        shrinkWrap: true,
//                        itemBuilder: (context, index) {
//
//                        //  final PodPlayerController controller = PodPlayerController(
//                        //   playVideoFrom: PlayVideoFrom.youtube(
//                        //     'https://youtu.be/${cubit.movieTrailerModel?.results?[index].key}',
//                        //   ),
//                        //   podPlayerConfig: const PodPlayerConfig(
//                        //     autoPlay: false,
//                        //     isLooping: false,
//                        //   ),
//                        // );
//                         return Column(
//                           children: [
//                             // PodVideoPlayer(
//                             //   controller: controller,
//                             // ),
//                             Row(
//                               children: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Uri uri = Uri.parse(
//                                         'https://youtu.be/${cubit.movieTrailerModel?.results?[index].key}');
//                                     launchUrl(uri);
//                                   },
//                                   child: Text(
//                                     'watch',
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   height: 10.h,
//                                 ),
//                                 SizedBox(
//                                   child: Text(
//                                     cubit.movieTrailerModel?.results?[index].name??'',
//                                     style: TextStyle(
//                                      color:Colors.white,
//                                       fontSize: 14.sp,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         );
//                          // Text( cubit.movieTrailerModel?.results?[index].name??'',style: TextStyle(color: Colors.white),);
//                      }, separatorBuilder: (context, index) => SizedBox(height: 15.h,),
//                          itemCount: cubit.movieTrailerModel?.results?.length??0,
//                      ),
//                    )
//                   ],
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
