import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/provider/movies/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final nowPlayingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider).getNowPlaing;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final popularMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider).getPopular;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final upComingMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider).getUpComing;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});

final topRatedMoviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch( movieRepositoryProvider).getTopRated;
  return MoviesNotifier(
    fetchMoreMovies: fetchMoreMovies
  );
});



typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MoviesNotifier extends StateNotifier<List<Movie>> {

  int currentPage = 0;
  bool isLoading = false;
  MovieCallBack fetchMoreMovies;
  
  MoviesNotifier({
    required this.fetchMoreMovies
  }): super([]);

  Future<void> loadNextPage() async{
    if(isLoading) return;

    isLoading = true;
    currentPage++;
    final List<Movie> movies = await fetchMoreMovies( page: currentPage);
    state = [...state, ...movies];
    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }

}