import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/provider/movies/movie_info_provider.dart';

class MovieScreen extends ConsumerStatefulWidget {

  static const name = 'movie-screen';

  final String movieId;

  const MovieScreen({
    super.key, 
    required this.movieId
  });

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);

  }


  @override
  Widget build(BuildContext context) {

    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if( movie == null){
      return const Scaffold(body: Center(child: CircularProgressIndicator(strokeWidth: 2)));
    }


    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [

          _CustomSliverAppBar(movie: movie),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => _MovieDetails(movie: movie) ,
              childCount: 1
            )
          ),

        ],
      ),

    );
  }
}


class _MovieDetails extends StatelessWidget {
  
  final Movie movie;

  const _MovieDetails({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: size.width * 0.3,
                ),
              ),
              
              const SizedBox(width: 10),
              
              // Descripción
              SizedBox(
                width: (size.width-40) * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(movie.title, style: textStyle.titleLarge),
                    Text(movie.overview),
                  ],
                ),
              ),

            ],
          ),
        ),

        // Generos de la pelicula
        Padding(
          padding: const EdgeInsets.all(8),
          child: Wrap(
            children: [
              ...movie.genreIds.map((genero) => Container(
                margin: const EdgeInsets.only(right: 10),
                child: Chip(
                  label: Text(genero),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
              ))
            ],
          ),
        ),

        //TODO Mostrar actores.

        const SizedBox(height: 100)

      ],
    );
  }
}



// Clase que muetra la imagen
class _CustomSliverAppBar extends StatelessWidget {

  final Movie movie;
  
  const _CustomSliverAppBar({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height *0.7 ,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        title: Text(
          movie.title,
          style: const TextStyle(fontSize: 20, color: Colors.white),
          textAlign: TextAlign.start,
          ),
        background:Stack(
          children: [

            SizedBox.expand(
              child: Image.network(
                movie.posterPath,
                fit: BoxFit.cover,
              ),
            ),

            //* este es el gradiente
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7,1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black87
                    ]
                  )
                )
              ),
            ),
            
            //* este es el gradiente, de la flecha para regresar
            const SizedBox.expand(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    stops: [0.0,0.3],
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ]
                  )
                )
              ),
            )



          ],
        ) ,
      ),
    );
  }
}