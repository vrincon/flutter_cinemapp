import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';

// Este repositorio en inmutable, (solo lectura)
final movieRepositoryProvider = Provider( (ref){
  return MovieRepositoryImpl(MoviedbDatasource());
});