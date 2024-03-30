import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_states.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/comicvine_model.dart';
import 'package:untitled/comicvine_api.dart';
import 'package:go_router/go_router.dart';

import '../bloc/app_bloc.dart';
import '../bloc/app_events.dart';

String formatNumberAsMillions(String? numberStr) {

  if (numberStr == null || numberStr.isEmpty) return "null";

  int? number = int.tryParse(numberStr);
  if (number == null) return "null";
  double numberInMillions = number / 1000000;
  if (numberInMillions == numberInMillions.toInt().toDouble()) {
    return "${numberInMillions.toInt()} millions \$";
  } else {
    return "${numberInMillions.toStringAsFixed(2)} millions \$";
  }
}

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

///BLOC
class AccueilMovieDetail extends StatelessWidget {
  @override
  final String movieId;
  final AppBloc appBloc;

  AccueilMovieDetail({Key? key, required this.movieId})
      : appBloc = AppBloc(ComicVineRequests()),
        super(key: key);

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appBloc..add(FetchMoviesDetail(movieId)),
      child: Scaffold(

        body: DetailMovies(moviesId: movieId,),
      ),
    );
  }
}

class DetailMovies extends StatelessWidget {

  final String moviesId;
  DetailMovies({Key? key, required this.moviesId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is MovieDetailLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MovieDetailLoaded) {
          return _buildComicList(state.details);
        } else if (state is MovieDetailError) {
          return Center(child: Text('Erreur: ${state.errorMessage5}'));
        } else {
          return Center(child: Text('État inconnu'));
        }
      },
    );
  }

  @override
  Widget _buildComicList(ComicVineMovieDetail detail){
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity, // Prend toute la largeur disponible
                      height: double.infinity, // Prend toute la hauteur disponible
                      child: Stack(
                        children: [
                          Image.network(
                            detail.image?.iconUrl ?? 'null',
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
                    Padding(
                      padding:const EdgeInsets.only(left: 32.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// COTE DROIT
                          /// IMAGE SERIE **CHANGER**
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child:
                            Image.network(detail.image?.iconUrl?? 'null', width: 128, height: 163, fit: BoxFit.cover),
                          ),
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
                    ),

                  ],
                ),
              ),
            ),
            /// ******REUTILISABLE***** Onglet Histoire/personnage/Episode
            TabBar(
              tabs: [
                Tab(text: 'Synopsis'),
                Tab(text: 'Personnages'),
                Tab(text: 'Infos'),
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

                  ///LISTE Personnage
                  ListView.builder(
                    itemCount: detail.characters.length,
                    itemBuilder: (BuildContext context, int index){
                      final personnage = detail.characters[index];
                      return InkWell(
                        onTap: () {
                          print(personnage.id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(personnage.name, style: TextStyle(color: Colors.white)),
                        ),
                      );
                    },
                  ),

                  ///DETAILS
                  Column(
                    children: [
                      Text('Producteurs:'),
                      ...detail.producers.map((producer) => Text(producer.name, style: TextStyle(color: Colors.white))).toList(),
                      Text('Studios:'),
                      ...detail.studio.map((producer) => Text(producer.name, style: TextStyle(color: Colors.white))).toList(),
                      Text('Writers:'),
                      ...detail.writers.map((producer) => Text(producer.name, style: TextStyle(color: Colors.white))).toList(),
                      Text('Budget : ${formatNumberAsMillions(detail.budget)} et classe : ${detail.classe}', style: TextStyle(color: Colors.white)),
                      Text('Recette Box office : ${formatNumberAsMillions(detail.boxOffice)} ', style: TextStyle(color: Colors.white)),
                      Text('Recette totale : ${formatNumberAsMillions(detail.total)} ', style: TextStyle(color: Colors.white)),
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


