import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:myflix/services/api_service.dart';

import '../models/movie.dart';

class DataRepository with ChangeNotifier{
  final APIService apiService = APIService();
  final List<Movie> _popularMovieList = [] ;
  int _popularMoviePageIndex = 1;
  final List<Movie> _nowPlaying = [];
  int _nowPlayingPageIndex = 1;
  final List<Movie> _upcomingMovies = [];
  int _upcomingMoviesIndex = 1;
  final List<Movie> _animationMovies = [];
  int _animationMoviesPageIndex = 1;
  final List<Movie> _horrorMovies = [];
  int _horrorMoviesPageIndex = 1;
  final List<Movie> _adventureMovie = [];
  int _adventureMoviePageIndex = 1;

  //getters
  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlaying => _nowPlaying;
  List<Movie> get upcomingMovies => _upcomingMovies;
  List<Movie> get animationMovies => _animationMovies;
  List<Movie> get horrorMovies => _horrorMovies;
  List<Movie> get adventureMovie => _adventureMovie;

  Future<void> getPopularMovies() async {
    try {
      List<Movie> movies = await apiService.getPopularMovies(pageNumber: _popularMoviePageIndex);
      _popularMovieList.addAll(movies);
      _popularMoviePageIndex ++ ;
      notifyListeners();
    }on Response catch (response){
      if (kDebugMode) {
        print("Error: ${response.statusCode}");
      }
      rethrow;
    }
  }
  Future<void> getNowPlaying() async {
    try {
      List<Movie> movies = await apiService.getNowPlaying(pageNumber: _nowPlayingPageIndex);
      _nowPlaying.addAll(movies);
      _nowPlayingPageIndex ++ ;
      notifyListeners();
    }on Response catch (response){
      if (kDebugMode) {
        print("Error: ${response.statusCode}");
      }
      rethrow;
    }
  }

  Future<void> getUpcomingMovies() async {
    try {
      List<Movie> movies = await apiService.getNowPlaying(pageNumber: _upcomingMoviesIndex);
      _upcomingMovies.addAll(movies);
      _upcomingMoviesIndex ++ ;
      notifyListeners();
    }on Response catch (response){
      if (kDebugMode) {
        print("Error: ${response.statusCode}");
      }
      rethrow;
    }
  }
  Future<void> getAnimationMovies() async {
    try {
      List<Movie> movies = await apiService.getAnimation(pageNumber: _animationMoviesPageIndex);
      _animationMovies.addAll(movies);
      _animationMoviesPageIndex ++ ;
      notifyListeners();
    }on Response catch (response){
      if (kDebugMode) {
        print("Error: ${response.statusCode}");
      }
      rethrow;
    }
  }
  Future<void> getHorrorMovies() async {
    try {
      List<Movie> movies = await apiService.getHorror(pageNumber: _horrorMoviesPageIndex);
      _horrorMovies.addAll(movies);
      _horrorMoviesPageIndex ++ ;
      notifyListeners();
    }on Response catch (response){
      if (kDebugMode) {
        print("Error: ${response.statusCode}");
      }
      rethrow;
    }
  }
  Future<void> getAdventureMovie() async {
    try {
      List<Movie> movies = await apiService.getAdventure(pageNumber: _adventureMoviePageIndex);
      _adventureMovie.addAll(movies);
      _adventureMoviePageIndex ++ ;
      notifyListeners();
    }on Response catch (response){
      if (kDebugMode) {
        print("Error: ${response.statusCode}");
      }
      rethrow;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    try {
      //recuperation des informations du film
      Movie newMovie = await apiService.getMovie(movie: movie);
      // //on récupere les videos
      // newMovie = await apiService.getMovieVideos(movie: newMovie);
      // //On récupère le casting
      // newMovie = await apiService.getMovieCast(movie: newMovie);
      // //Onrecupere les images
      // newMovie = await apiService.getMovieImage(movie: newMovie);
      return newMovie;
    } on Response catch (response) {
      print("Error : ${response.statusCode}");
      rethrow;
    }


  }


  Future <void> initData() async {
    await Future.wait([getPopularMovies(), getNowPlaying(),getUpcomingMovies(),getAnimationMovies(),getAdventureMovie(),getHorrorMovies()]);
  }
}