import 'package:cinemapedia/domain/entities/movie.dart';



abstract class MoviesRepsository {

  Future<List<Movie>> getNowPlaing({int page = 1});

}