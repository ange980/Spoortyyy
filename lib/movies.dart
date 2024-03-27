import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/comicvine_model.dart';
import 'package:untitled/comicvine_api.dart';
import 'package:go_router/go_router.dart';

///COULEURS
class AppColors {
  static const Color screenBackground = Color(0xFF15232E);
  static const Color orange = Color(0xFFFF8100);
  static const Color cardBackground = Color(0xFF1E3243);
  static const Color cardElementBackground = Color(0xFF284C6A);
  static const Color seeMoreBackground = Color(0xFF0F1921);
  static const Color bottomBarBackground = Color(0xFF0F1E2B);
  static const Color bottomBarSelectedBackground = Color(0xFF12273C);
  static const Color bottomBarSelectedText = Color(0xFF12273C);
  static const Color bottomBarUnselectedText = Color(0xFF778BA8);
  static const Color element = Colors.white;
}

///PAGE LISTE FILMS
class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15232E),
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Films les plus populaires',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                // FutureBuilder pour récupérer les séries depuis l'API
                child: FutureBuilder<ComicVineMoviesResponse>(
                  future: ComicVineRequests().getMovies(), // Assurez-vous que cette méthode retourne les bonnes données
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Une erreur est survenue !', style: TextStyle(color: Colors.white));
                    }
                    if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
                      return Text('Aucune série trouvée.', style: TextStyle(color: Colors.white));
                    }
                    // ListView pour afficher les séries
                    return ListView.builder(
                      itemCount: snapshot.data!.results.length,
                      itemBuilder: (BuildContext context, int index) {
                        final movies = snapshot.data!.results[index];
                        return InkWell(
                          onTap: () {
                            GoRouter.of(context).go('/moviesDetail/${movies.id}');
                            print(movies.id);
                          },
                          child: Column(
                            children: [
                              MovieWidget(
                                  rank: index + 1,
                                  title: movies.name ?? 'Nom inconnu',
                                  imageUrl: movies.image?.iconUrl ?? 'URL par défaut',
                                  time: movies.runtime ?? '160',
                                  date: movies.releaseDate ?? '1999'
                              ),
                              SizedBox(height: 16.0), // Espace entre chaque série
                            ],
                          ),

                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class MovieWidget extends StatelessWidget {

  final String title;
  final String imageUrl;
  final String time;
  final String date;
  final int rank;

  MovieWidget({
    required this.rank,
    required this.title,
    required this.imageUrl,
    required this.time,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E3243),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child:
                Image.network(this.imageUrl, width: 128, height: 163, fit: BoxFit.cover),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/ic_movie_bicolor.svg',
                          width: 15,
                          height: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          '${this.time} minutes',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/ic_calendar_bicolor.svg',
                          width: 15,
                          height: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          this.date,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFFF8100),
              ),
              child: Text(
                '#$rank',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class DetailMovies extends StatelessWidget {

  final String moviesId;
  DetailMovies({Key? key, required this.moviesId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder<ComicVineMoviesDetailResponse>(
        future: ComicVineRequests().getMoviesDetail(moviesId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Une erreur est survenue: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            final detail = snapshot.data!.results;
            return DefaultTabController(
              length: 3,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32.0),
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity, // Prend toute la largeur disponible
                              height: double.infinity, // Prend toute la hauteur disponible
                              child: Stack(
                                children: [
                                  Image.network(
                                    detail.image?.iconUrl?? 'null',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                  BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                    child: Container(
                                      color: Colors.black.withOpacity(0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /// COTE DROIT
                                /// IMAGE SERIE **CHANGER**
                                Image.network(detail.image?.iconUrl?? 'null', width: 128, height: 163, fit: BoxFit.cover),
                                SizedBox(width: 24),
                                ///COTE GAUCHE
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detail.name?? 'Null',
                                      style: TextStyle(
                                        color: AppColors.element,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    /// ******REUTILISABLE***** Icone + texte
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/ic_movie_bicolor.svg',
                                          color: AppColors.element,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          detail.name?? 'Null',
                                          style: TextStyle(
                                            color: AppColors.element,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/ic_calendar_bicolor.svg',
                                          color: AppColors.element,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                           detail.date?? 'Mai 1999',
                                          style: TextStyle(
                                            color: AppColors.element,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  /// ******REUTILISABLE***** Onglet Histoire/personnage/Episode
                  TabBar(
                    tabs: [
                      Tab(text: 'Synopsis'),
                      Tab(text: 'Auteurs'),
                      Tab(text: 'Personnages'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          ///TEXTE HISTOIRE SERIE
                          child: Text(
                            'The missions of the Strategic Homeland Intervention, Enforcement and Logistics Division. '
                                'A small team of operatives led by Agent Coulson (Clark Gregg) who must deal with the '
                                'strange new world of "superheroes" after the "Battle of New York", protecting the public '
                                'from new and unknown threats.',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ///LISTE PERSONNAGES
                        Icon(Icons.people), // Remplacer par le contenu réel
                        ///LISTE EPISODE
                        Icon(Icons.list),  // Remplacer par le contenu réel
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('Données non disponibles');
          }
        },
      ),
    );
  }
}