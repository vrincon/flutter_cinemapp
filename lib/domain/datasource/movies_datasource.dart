import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesDataSource {
  Future<List<Movie>> getNowPlaing({int page = 1});

  Future<List<Movie>> getPopular({int page = 1});

  Future<List<Movie>> getUpComing({int page = 1});

  Future<List<Movie>> getTopRated({int page = 1});
}
