
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/datasource/movies_datasource.dart';
import 'package:cinemapedia/domain/repositories/movies_repsository.dart';

class MovieRepositoryImpl extends MoviesRepsository {
  
  final MoviesDataSource dataSource;
  MovieRepositoryImpl(this.dataSource);
  
  @override
  Future<List<Movie>> getNowPlaing({int page = 1}) {
    return dataSource.getNowPlaing(page: page);
  }
  
  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return dataSource.getPopular(page: page);
  }
  
  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return dataSource.getTopRated(page: page);
  }
  
  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
    return dataSource.getUpComing(page: page);
  }


}