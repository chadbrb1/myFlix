import 'package:flutter/material.dart';
import 'package:myflix/repositories/data_repository.dart';
import 'package:myflix/utils/constants.dart';
import 'package:provider/provider.dart';

import 'movie_card.dart';
import 'movie_category.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        leading: Image.asset("assets/images/logo2.png"),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 500,
            child: MovieCard(movie: dataProvider.popularMovieList.first),
          ),
          MovieCategory(
            imageHeight: 160,
            imageWidth: 110,
            label: "Tendance Actuelle",
            movieList: dataProvider.popularMovieList,
            callback: dataProvider.getPopularMovies,
          ),
          MovieCategory(
            imageHeight: 320,
            imageWidth: 220,
            label: "Actuellement au cinéma",
            movieList: dataProvider.nowPlaying,
            callback: dataProvider.getNowPlaying,
          ),
            MovieCategory(
              imageHeight: 160,
            imageWidth: 110,
            label: "Bientôt dans vos salle",
            movieList: dataProvider.upcomingMovies,
            callback: dataProvider.getUpcomingMovies,
          ),MovieCategory(
            imageHeight: 160,
            imageWidth: 110,
            label: "Films d'animations",
            movieList: dataProvider.animationMovies,
            callback: dataProvider.getAnimationMovies,
          ),MovieCategory(
            imageHeight: 160,
            imageWidth: 110,
            label: "Films d'aventure",
            movieList: dataProvider.adventureMovie,
            callback: dataProvider.getAdventureMovie,
          ),MovieCategory(
            imageHeight: 160,
            imageWidth: 110,
            label: "Films d'horreur",
            movieList: dataProvider.horrorMovies,
            callback: dataProvider.getHorrorMovies,
          ),
        ],
      ),
    );
  }
}
