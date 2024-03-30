import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/bloc/app_states.dart';
import 'package:untitled/comicvine_api.dart';
import 'package:untitled/comicvine_model.dart';
import 'package:go_router/go_router.dart';

import '../bloc/app_bloc.dart';
import '../bloc/app_events.dart';

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
class AccueilSerieDetail extends StatelessWidget {
  @override
  final String serieId;
  final AppBloc appBloc;

  AccueilSerieDetail({Key? key, required this.serieId})
      : appBloc = AppBloc(ComicVineRequests()),
        super(key: key);

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appBloc..add(FetchSeriesDetail(serieId)),
      child: Scaffold(

        body: DetailSeries(seriesId: serieId),
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
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is SerieDetailLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SerieDetailLoaded) {
          return _buildComicList(state.details);
        } else if (state is SerieDetailError) {
          return Center(child: Text('Erreur: ${state.errorMessage6}'));
        } else {
          return Center(child: Text('État inconnu'));
        }
      },
    );
  }

  Widget _buildComicList(ComicVineSerieDetail detail){
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
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child:
                            Image.network(detail.image?.iconUrl?? 'null', width: 128, height: 163, fit: BoxFit.cover),
                          ),
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
                    ),

                  ],
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
                  ListView.builder(
                    itemCount: detail.characters.length,
                    itemBuilder: (BuildContext context, int index){
                      final personnage = detail.characters[index];
                      return InkWell(
                        onTap: () {
                          GoRouter.of(context).go('/character/${personnage.id}');
                          print(personnage.id);
                        },
                          child: Container(
                            margin: EdgeInsets.only(top: index == 0 ? 16.0 : 0.0, bottom: 8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: ClipOval(
                                  child: Image.network(
                                    'null',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                ),
                              ),
                              title: Text(
                                personnage.name,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                      );
                    },
                  ),
                  ///LISTE EPISODE
                  Icon(Icons.list),  // Remplacer par le contenu réel
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}