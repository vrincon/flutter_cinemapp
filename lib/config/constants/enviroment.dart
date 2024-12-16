

import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {

  static String theMovieKEY = dotenv.env['THE_MOVIEDB_KEY'] ?? 'No hay una API-KEY';


}