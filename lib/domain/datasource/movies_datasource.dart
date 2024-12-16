import 'package:cinemapedia/domain/entities/movie.dart';



abstract class MoviesDatasource {

  Future<List<Movie>> getNowPlaing({int page = 1});

}