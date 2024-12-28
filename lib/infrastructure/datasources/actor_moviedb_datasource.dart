import 'package:dio/dio.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:cinemapedia/config/constants/enviroment.dart';
import 'package:cinemapedia/domain/datasource/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';

class ActorMoviedbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Enviroment.theMovieKEY,
        'language': 'es-MX'
      }));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {

    final response = await dio.get('/movie/$movieId/credits');
    if( response.statusCode != 200) throw Exception('Actor with movieId:$movieId not found');

    final CreditsResponse castResponse = CreditsResponse.fromJson(response.data);

    List<Actor> actors = castResponse.cast
      .map((cast) => ActorMapper.castToEntity(cast ))
      .toList();

    return actors;
  }
}
