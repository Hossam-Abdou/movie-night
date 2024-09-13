import 'dart:io';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
part 'hive_adapter.g.dart';

@HiveType(typeId: 2)
class HiveWatchList extends HiveObject {
  @HiveField(0)
  String? title;

  @HiveField(1)
  int? id;

  @HiveField(2)
  String? posterPath;

  @HiveField(3)
  double? voteAverage;

  HiveWatchList({
    this.title,
    this.id,
    this.posterPath,
    this.voteAverage,
  });
}

class AddToWatchListManager {
  Future<void> saveMovieToWatchList({
    required String? title,
    required int? id,
    required String? posterPath,
    required double? voteAverage,
  }) async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    // Open Hive box with a custom path
    var box = await Hive.openBox<HiveWatchList>('myBox', path: appDocumentsDir.path);

    // Create a new AddToWatchList object using the input parameters
    var movie = HiveWatchList(
      title: title,
      id: id,
      posterPath: posterPath,
      voteAverage: voteAverage,
    );

    // Add the movie to the Hive box
    await box.add(movie);

    print('Movie saved: ${movie.title}');
    print('Movie saved: ${movie.posterPath}');
    print('Movie saved: ${movie.id}');
  }


  Future<List<HiveWatchList>> getMoviesFromWatchList() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();

    // Open the Hive box
    var box = await Hive.openBox<HiveWatchList>('myBox', path: appDocumentsDir.path);

    // Retrieve all movies from the box
    List<HiveWatchList> movies = box.values.toList();

    return movies;
  }
}

