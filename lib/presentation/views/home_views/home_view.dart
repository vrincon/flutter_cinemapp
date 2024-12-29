import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia/presentation/provider/prodivers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({ super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    

  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);

    if( initialLoading ) return const FullScreenLoader();
    
    final slideShowMovies = ref.watch(moviesSlideShowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upComingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    
    return CustomScrollView(
      slivers: [

        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),


        SliverList(delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Column(
              children: [
            
                //const CustomAppBar(),
            
                MoviesSlideshow(movies: slideShowMovies),
            
                MovieHorizontalListView(
                  movies: nowPlayingMovies,
                  title: 'En Cines',
                  subTitle: 'Lunes 16 ',
                  loadNextPage: () {
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
                  },
                ),
            
                MovieHorizontalListView(
                  movies: upcomingMovies,
                  title: 'Proximamente',
                  subTitle: 'En este mes ',
                  loadNextPage: () {
                    ref.read(upComingMoviesProvider.notifier).loadNextPage();
                  },
                ),
            
                MovieHorizontalListView(
                  movies: popularMovies,
                  title: 'Populares',
                  //subTitle: 'Lunes 16 ',
                  loadNextPage: () {
                    ref.read(popularMoviesProvider.notifier).loadNextPage();
                  },
                ),
            
                MovieHorizontalListView(
                  movies: topRatedMovies,
                  title: 'Mejor calificadas',
                  subTitle: 'Desde siempre',
                  loadNextPage: () {
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                  },
                ),

                const SizedBox(height: 10)

                
              ],
            );
          },
          childCount: 1
        )),

      ]     
    );

  }
}

