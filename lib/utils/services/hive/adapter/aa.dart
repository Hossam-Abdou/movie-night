import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movie_night/utils/services/hive/adapter/hive_adapter.dart';
import 'package:path_provider/path_provider.dart';

class Watch extends StatefulWidget {
  @override
  _WatchlistScreenState createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<Watch> {
  final _titleController = TextEditingController();
  final _idController = TextEditingController();
  final _posterPathController = TextEditingController();
  final _voteAverageController = TextEditingController();

  List<HiveWatchList> _movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
    var box = await Hive.openBox<HiveWatchList>('myBox', path: appDocumentsDir.path);
    setState(() {
      _movies = box.values.toList();
    });
  }

  Future<void> _saveMovie() async {
    final title = _titleController.text;
    final id = int.tryParse(_idController.text);
    final posterPath = _posterPathController.text;
    final voteAverage = double.tryParse(_voteAverageController.text);

    if (title.isNotEmpty && id != null && posterPath.isNotEmpty && voteAverage != null) {
      final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
      var box = await Hive.openBox<HiveWatchList>('myBox', path: appDocumentsDir.path);

      var movie = HiveWatchList(
        title: title,
        id: id,
        posterPath: posterPath,
        voteAverage: voteAverage,
      );

      await box.add(movie);
      _loadMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _idController,
              decoration: InputDecoration(labelText: 'ID'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _posterPathController,
              decoration: InputDecoration(labelText: 'Poster Path'),
            ),
            TextField(
              controller: _voteAverageController,
              decoration: InputDecoration(labelText: 'Vote Average'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveMovie,
              child: Text('Save Movie'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _movies.length,
                itemBuilder: (context, index) {
                  final movie = _movies[index];
                  return ListTile(
                    title: Text(movie.title ?? 'No Title'),
                    subtitle: Text('ID: ${movie.id}, Poster: ${movie.posterPath}, Vote: ${movie.voteAverage}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
