import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/bloc/app_events.dart';
import 'package:untitled/comicvine_api.dart';
import 'package:untitled/comicvine_model.dart';
import 'package:go_router/go_router.dart';

import 'bloc/app_bloc.dart';
import 'bloc/app_states.dart';

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
class AccueilComic extends StatelessWidget {
  @override
  final AppBloc appBloc = AppBloc(ComicVineRequests());
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appBloc..add(FetchComics()),
      child: Scaffold(

        body: ComicsPage(),
      ),
    );
  }
}

///PAGE LISTE COMICS
class ComicsPage extends StatelessWidget {
  const ComicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is ComicsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ComicsLoaded) {
          return _buildComicList(state.comics);
        } else if (state is ComicsError) {
          return Center(child: Text('Erreur: ${state.errorMessage3}'));
        } else {
          return Center(child: Text('État inconnu'));
        }
      },
    );
  }

  Widget _buildComicList(List<ComicVineIssues> comics){
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
                'Comics les plus populaires',
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
                itemCount: comics.length,
                itemBuilder: (BuildContext context, int index) {
                  final comic = comics[index];
                  return InkWell(
                    onTap: () {
                      GoRouter.of(context).go('/comicsDetail/${comic.id}');
                      print(comic.id);
                    },
                    child: Column(
                      children: [
                        ComicsWidget(
                          rank: index + 1,
                          title: comic.name ?? 'Nom inconnu',
                          comic: comic.comic?.name ?? 'Nom inconnu',
                          number: comic.number ?? '1',
                          date: comic.date ?? '1999',
                          imageUrl: comic.image?.iconUrl ?? 'URL par défaut',
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


class ComicsWidget extends StatelessWidget {

  final String title;
  final String comic;
  final String imageUrl;
  final String number;
  final String date;
  final int rank;

  ComicsWidget({
    required this.rank,
    required this.title,
    required this.comic,
    required this.number,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {

    // Convertir la chaîne de caractères en DateTime
    DateTime parsedDate = DateTime.parse(this.date);

    // Récupérer l'année en tant que chaîne de caractères
    String year = parsedDate.year.toString();

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
                Image.network(
                    this.imageUrl, width: 128, height: 163, fit: BoxFit.cover),
                ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.comic,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    SizedBox(height: 4.0),
                    Text(
                      this.title,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/ic_books_bicolor.svg',
                          width: 15,
                          height: 15,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          'N°: ${this.number}',
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
                          year,
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


class DetailComics extends StatelessWidget {

  final String comicsId;
  DetailComics({Key? key, required this.comicsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: FutureBuilder<ComicVineIssueDetailResponse>(
        future: ComicVineRequests().getIssueDetail(comicsId),
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
                                SizedBox(width: 24), //Espace icône et texte
                                ///COTE GAUCHE
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center, // To center the Column contents vertically
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      detail.comic?.name?? 'Inconnu',
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
                                          'assets/svg/ic_books_bicolor.svg',
                                          color: AppColors.element,
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          detail.name?? 'Inconnu',
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
                                          detail.date?? '1999',
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
                            detail.description?? 'The missions of the Strategic Homeland Intervention, Enforcement and Logistics Division. '
                                'A small team of operatives led by Agent Coulson (Clark Gregg) who must deal with the '
                                'strange new world of "superheroes" after the "Battle of New York", protecting the public '
                                'from new and unknown threats.',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ///LISTE AUTEURS
                        Column(
                          children: [
                            Text('Auteur:'),
                            ...detail.auteurs.map((producer) => Text(producer.name, style: TextStyle(color: Colors.white))).toList(),
                            Text('Personnages:'),
                            ...detail.character.map((producer) => Text(producer.name, style: TextStyle(color: Colors.white))).toList(),
                          ],
                        ),
                        ///LISTE PERSONNAGES
                        Column(
                          children: [
                            Text('Personnages:'),
                            ...detail.character.map((producer) => Text(producer.name, style: TextStyle(color: Colors.white))).toList(),
                          ],
                        ),
                      ],
                    ),
                  )
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