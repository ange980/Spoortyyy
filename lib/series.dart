import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/bloc/app_states.dart';
import 'package:untitled/comicvine_api.dart';
import 'package:untitled/comicvine_model.dart';
import 'package:go_router/go_router.dart';

import 'bloc/app_bloc.dart';
import 'bloc/app_events.dart';

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
class AccueilSerie extends StatelessWidget {
  @override
  final AppBloc appBloc = AppBloc(ComicVineRequests());
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appBloc..add(FetchSeries()),
      child: Scaffold(

        body: SeriesPage(),
      ),
    );
  }
}

///PAGE LISTE SERIES
class SeriesPage extends StatelessWidget {
  const SeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is SeriesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SeriesLoaded) {
          return _buildSerieList(state.series);
        } else if (state is SeriesError) {
          return Center(child: Text('Erreur: ${state.errorMessage2}'));
        } else {
          return Center(child: Text('État inconnu'));
        }
      },
    );
  }

  Widget _buildSerieList(List<ComicVineSeries> series){
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E3243),
        borderRadius: BorderRadius.circular(20.0),
      ),

      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Séries les plus populaires',
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
              child: ListView.builder(
                itemCount: series.length,
                itemBuilder: (BuildContext context, int index) {
                  final serie = series[index];
                  return InkWell(
                    onTap: () {
                      GoRouter.of(context).go('/seriesDetail/${serie.id}');
                      print(serie.id);
                    },
                    child: Column(
                      children: [
                        SeriesWidget(
                          rank: index + 1,
                          title: serie.name ?? 'Nom inconnu',
                          imageUrl: serie.image?.iconUrl ?? 'URL par défaut',
                          publisher: serie.name?? 'Marvel',
                          numberOfEpisodes: serie.nbEpisode ?? 22,
                          date: serie.year ?? '1999',
                        ),
                        SizedBox(height: 16.0), // Espace entre chaque série
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class SeriesWidget extends StatelessWidget {

  final String title;
  final String imageUrl;
  final String publisher;
  final int numberOfEpisodes;
  final String date;
  final int rank;

  SeriesWidget({
    required this.rank,
    required this.title,
    required this.imageUrl,
    required this.publisher,
    required this.numberOfEpisodes,
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
                child: Image.network(this.imageUrl, width: 128, height: 163, fit: BoxFit.cover) ,
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
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/ic_publisher_bicolor.svg',
                          width: 15,
                          height: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          'Marvel',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/ic_tv_bicolor.svg',
                          width: 15,
                          height: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          this.numberOfEpisodes.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
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

///PAGE DETAILS SERIES
class DetailSeries extends StatelessWidget {

  final String seriesId;
  DetailSeries({Key? key, required this.seriesId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder<ComicVineSerieDetailResponse>(
        future: ComicVineRequests().getSeriesDetail(seriesId),
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
                            Text("Détails pour la série ID: $seriesId"),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                /// COTE DROIT

                                /// IMAGE SERIE **CHANGER**
                                Image.network(detail.image?.iconUrl?? 'null', width: 128, height: 163, fit: BoxFit.cover),
                                SizedBox(width: 24), //Espace icône et texte
                                ///COTE GAUCHE
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center, // To center the Column contents vertically
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detail.name,
                                      style: TextStyle(
                                        color: AppColors.element,
                                        fontSize: 24, // Taille de police plus grande
                                        fontWeight: FontWeight.bold, // Texte en gras
                                      ),
                                    ),
                                    /// ******REUTILISABLE***** Icone + texte
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/svg/ic_publisher_bicolor.svg',
                                          color: AppColors.element,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          detail.publisher?.name?? 'Marvel',
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
                                          'assets/svg/ic_tv_bicolor.svg',
                                          color: AppColors.element,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          '${detail.nbEpisode} épisodes',
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
                                          detail.year,
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
                      Tab(text: 'Histoire'),
                      Tab(text: 'Personnages'),
                      Tab(text: 'Épisodes'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          ///TEXTE HISTOIRE SERIE
                          child: Text(
                            detail.description,
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