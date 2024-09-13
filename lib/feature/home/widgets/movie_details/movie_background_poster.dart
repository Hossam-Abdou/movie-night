import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_night/feature/home/view_model/home_cubit.dart';
import 'package:movie_night/utils/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';


class MovieBackgroundPoster extends StatelessWidget {
  const MovieBackgroundPoster({super.key});


  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return InkWell(
          onTap: () async {
            await cubit.getMovieTrailer(cubit.moviesDetailsModel?.id.toString()); // Ensure this finishes first
            if (cubit.movieTrailerModel?.results
                ?.isNotEmpty ??
                false) {
              final trailerKey = cubit.movieTrailerModel?.results?[0].key;
              if (trailerKey != null) {
                Uri uri = Uri.parse(
                    'https://youtu.be/$trailerKey');
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                } else {
                  // Handle error if the URL cannot be launched
                  debugPrint('Could not launch $uri');
                }
              } else {
                debugPrint('Trailer key is null');
              }
            } else {
              debugPrint(
                  'No trailer available for this movie');
            }
          },
          child: Container(
            height: MediaQuery
                .sizeOf(context)
                .height * 0.3,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  (cubit.moviesDetailsModel?.backdropPath != null &&
                      cubit.moviesDetailsModel!.backdropPath!.isNotEmpty)
                      ? '${Constants.imageBaseUrl}${cubit.moviesDetailsModel?.backdropPath}'
                      : 'https://img.freepik.com/premium-vector/modern-design-concept-no-image-found-design_637684-247.jpg',
                ),
              ),
            ),
            child: const Align(
              alignment: Alignment.center,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.black54,
                child: Icon(
                  Icons.play_arrow,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
