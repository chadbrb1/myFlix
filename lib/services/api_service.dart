import 'package:dio/dio.dart';

import '../models/movie.dart';
import '../models/person.dart';
import 'api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    String _url = api.baseURL + path;
    //on construit les paramêtres

    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': 'fr-FR',
    };
    //si param n'est pas null, on ajoute son contenu a query
    if (params != null) {
      query.addAll(params);
    }

    //on fait l'appel
    final response = await dio.get(_url, queryParameters: query);

    //on check que la requete soit bien passée

    if (response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response = await getData('/movie/popular', params: {
      'page': pageNumber,
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getNowPlaying({required int pageNumber}) async {
    Response response = await getData('/movie/now_playing', params: {
      'page': pageNumber,
      'region' : 'FR',
    });

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getUpcomingMovies({required int pageNumber}) async {
    Response response = await getData('/movie/upcoming', params: {
      'region' : 'FR',
      'page': pageNumber,
    });
    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getAnimation({required int pageNumber}) async {
    Response response = await getData('/discover/movie',
        params: {'page': pageNumber, 'with_genres': '16'});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getHorror({required int pageNumber}) async {
    Response response = await getData('/discover/movie',
        params: {'page': pageNumber, 'with_genres': '27'});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getAdventure({required int pageNumber}) async {
    Response response = await getData('/discover/movie',
        params: {'page': pageNumber, 'with_genres': '12'});

    if (response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();

      return movies;
    } else {
      throw response;
    }
  }



//   Future<Movie> getMovieDetails({required Movie movie}) async {
//     Response response = await getData('/movie/${movie.id}');
//     if (response.statusCode == 200) {
//       Map<String, dynamic> _data = response.data;
//       var genres = _data['genres'] as List;
//       List<String> genreList = genres.map((item) {
//         return item ['name'] as String;
//       }).toList();
//
//       Movie newMovie = movie.copyWith(genres: genreList,
//           releaseDate: _data['release_date'],
//           vote: _data['vote_average']);
//       return newMovie ;
//     }else {
//       throw response;
//   }
// }
//
//
// Future<Movie> getMovieVideos({required Movie movie}) async {
//   Response response = await getData('/movie/${movie.id}/videos');
//
//   if (response.statusCode == 200) {
//     Map data = response.data;
//
//     List<String> videoKeys = data['results'].map<String>(( videoJson){
//       return videoJson['key'] as String;
//     }).toList();
//
//     return movie.copyWith(videos: videoKeys);
//   }else {
//     throw response;
//   }
// }
//
// Future<Movie> getMovieCast({required Movie movie}) async {
//   Response response = await getData('/movie/${movie.id}/credits');
//
//   if (response.statusCode == 200) {
//     Map data = response.data;
//
//     List<Person> casting = data['cast'].map<Person>(( dynamic personJson){
//       return Person.fromJson(personJson);
//     }).toList();
//
//     return movie.copyWith(casting: casting);
//   }else {
//     throw response;
//   }
// }
//
// Future<Movie> getMovieImage({required Movie movie}) async {
//   Response response = await getData('/movie/${movie.id}/images', params : {
//     'include_image_language' : 'null',
//   });
//
//   if (response.statusCode == 200) {
//     //on recupere les images
//     Map data = response.data;
//
//     List<String>  imagePath = data['backdrops'].map<String>(( dynamic imageJson){
//       return imageJson['file_path'] as String;
//     }).toList();
//
//
//     return movie.copyWith(images: imagePath);
//   }else {
//     throw response;
//   }
// }
Future<Movie> getMovie({required Movie movie}) async {
  Response response = await getData('/movie/${movie.id}', params : {
    'include_image_language' : 'null',
    'append_to_response' : 'videos,images,credits',
  });

  if (response.statusCode == 200) {
    //on recupere les informations du film
    Map data = response.data;

    //on recupere les genres du film
    var genres = data['genres'] as List;
    List<String> genreList = genres.map((item) {
      return item ['name'] as String;
    }).toList();

    //On recupere les videos
    List<String> videoKeys = data['videos']['results'].map<String>(( videoJson){
      return videoJson['key'] as String;
    }).toList();

    //On recupere les images
    List<String>  imagePath = data['images']['backdrops'].map<String>(( dynamic imageJson){
      return imageJson['file_path'] as String;
    }).toList();

    //On recupere le casting
    List<Person> casting = data['credits']['cast'].map<Person>(( dynamic personJson){
      return Person.fromJson(personJson);
    }).toList();


    return movie.copyWith(videos : videoKeys, images: imagePath, casting: casting , genres: genreList, releaseDate: data['release_date'],
        vote: data['vote_average']);
  }else {
    throw response;
  }
}

}
