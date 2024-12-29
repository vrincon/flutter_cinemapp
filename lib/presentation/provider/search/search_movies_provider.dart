import 'package:cinemapedia/presentation/provider/prodivers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchedMoviesProvider = StateNotifierProvider<SearchedMoviesNotifier, List<Movie>>((ref){

  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchedMoviesNotifier(
    searchMovies: movieRepository.searchMovie, 
    ref: ref
    );
});

typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

class SearchedMoviesNotifier extends StateNotifier<List<Movie>> {
  
  final SearchMoviesCallBack searchMovies;
  final Ref ref;

  SearchedMoviesNotifier({
    required this.searchMovies,
    required this.ref
  }) : super([]);

  Future<List<Movie>> searchMoviesByQuery(String query) async {

    final List<Movie> movies = await searchMovies(query);
    ref.read( searchQueryProvider.notifier).update((state) => query);
    
    state = movies;

    return movies;
  }
}
