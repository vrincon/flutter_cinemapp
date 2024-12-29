import 'dart:async';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'package:cinemapedia/config/helpers/human_format.dart';
import 'package:cinemapedia/domain/entities/movie.dart';


typedef SearchMoviesCallBack = Future<List<Movie>> Function( String query );


class SearchMovieDelegate extends SearchDelegate<Movie?> {

  final SearchMoviesCallBack serachMovies;
  List<Movie> initialMovies;

  StreamController<List<Movie>> debouncedMovie = StreamController.broadcast();
  StreamController<bool> isLoadingStream = StreamController.broadcast();

  Timer? _debounceTimer;

  SearchMovieDelegate({
    required this.serachMovies,
    required this.initialMovies,
  }):super(
    searchFieldLabel: 'Buscar peliculas',
    // textInputAction: TextInputAction.done
  );

  void clearStream(){
    debouncedMovie.close();
  }

  void _onQueryChanged( String query){
    isLoadingStream.add(true);
    
    if( _debounceTimer?.isActive ?? false ) _debounceTimer!.cancel();
    
    _debounceTimer = Timer( const Duration(milliseconds: 500), () async {
      
      // if( query.isEmpty){
      //   debouncedMovie.add([]);
      //   return;
      // }

      final movies = await serachMovies( query );
      initialMovies = movies;
      debouncedMovie.add(movies);
      isLoadingStream.add(false);

    });


  } 

  // @override
  // String get searchFieldLabel => 'Buscar peliculas'; 

  Widget buildResultSuggestions(){
    
    return StreamBuilder(
      initialData: initialMovies,
      stream: debouncedMovie.stream,
      builder: (context, snapshot) {

        final movies = snapshot.data ?? [];

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(
            movie: movies[index],
            onMovieSelected: (context, movie){
              clearStream();
              close(context, movie);
            } ,
          ),
        );

      },
    );

  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [

      StreamBuilder(
        initialData: false,
        stream: isLoadingStream.stream, 
        builder: (context, snapshot) {
          if( snapshot.data ?? false ){
              return SpinPerfect(
                  duration: const Duration( seconds: 20),
                  infinite: true,
                  child: IconButton(
                    onPressed: () => query= '', 
                    icon: const Icon(Icons.refresh_rounded)
                  ),
                );
          }

          return FadeIn(
                    animate: query.isNotEmpty,
                    child: IconButton(
                      onPressed: () => query= '', 
                      icon: const Icon(Icons.clear)
                    ),
                  );
        },
      ),

    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
          clearStream();
          close(context, null);
        }, 
        icon: const Icon(Icons.arrow_back_ios_new_rounded)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    
    return buildResultSuggestions();

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    _onQueryChanged( query );

    return buildResultSuggestions();

  }
}

class _MovieItem extends StatelessWidget {

  final Movie movie;
  final Function onMovieSelected;

  const _MovieItem({
    required this.movie, 
    required this.onMovieSelected
  });

  @override
  Widget build(BuildContext context) {

    final textStyle = Theme.of(context).textTheme; 
    final size = MediaQuery.of(context).size; 
    
    return GestureDetector(
      onTap: () {
        onMovieSelected(context, movie);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:10, vertical: 5),
        child: Row(
          children: [
      
            // Imagen
            SizedBox(
              width: size.width * 0.2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  movie.posterPath,
                  loadingBuilder: (context, child, loadingProgress) => FadeIn(child: child),  
                ),
              ),
            ),
            const SizedBox(width: 10),
      
            //Descripcion
            SizedBox(
              width: size.width *0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyle.titleMedium),
      
                  ( movie.overview.length > 100 )
                    ? Text( '${movie.overview.substring(0, 100)} ...'  )
                    : Text( movie.overview ),
      
                    Row(
                      children: [
                        Icon(Icons.star_half_rounded, color: Colors.yellow.shade800),
                        const SizedBox(width: 5),
                        Text(
                          HumanFormat.number(movie.voteAverage, 1),
                          style: textStyle.bodyMedium!.copyWith(color: Colors.yellow.shade900),
                        ),
                      ],
                    ),
                ],
              ),
            ),
      
          ],
        ),
      ),
    );

  }

}