import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/bloc/app_events.dart';
import 'package:untitled/comicvine_api.dart';
import 'package:untitled/comicvine_model.dart';
import 'package:go_router/go_router.dart';

import '../bloc/app_bloc.dart';
import '../bloc/app_states.dart';

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

///BLOC COMIC DETAIL
class AccueilComicDetail extends StatelessWidget {
  @override
  final String issueId;
  final AppBloc appBloc;

  AccueilComicDetail({Key? key, required this.issueId})
      : appBloc = AppBloc(ComicVineRequests()),
        super(key: key);

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appBloc..add(FetchIssueDetail(issueId)),
      child: Scaffold(

        body: DetailComics(comicsId: issueId),
      ),
    );
  }
}

///BLOC CHARACTER
class AccueilCharacterDetail extends StatelessWidget {

  @override
  final String characterId;
  final AppBloc appBloc;

  AccueilCharacterDetail({Key? key, required this.characterId})
      : appBloc = AppBloc(ComicVineRequests()),
        super(key: key);

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appBloc..add(FetchCharacter(characterId)),
      child: Scaffold(

        body: CharacterWidget(characterId: characterId),
      ),
    );
  }
}

class DetailComics extends StatelessWidget {

  final String comicsId;
  DetailComics({Key? key, required this.comicsId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is ComicDetailLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ComicDetailLoaded) {
          return _buildComicList(state.details);
        } else if (state is ComicDetailError) {
          return Center(child: Text('Erreur: ${state.errorMessage7}'));
        } else {
          return Center(child: Text('État inconnu'));
        }
      },
    );
  }

  Widget _buildComicList(ComicVineIssueDetail detail){
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
                    ),

                  ],
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
                  ListView.builder(
                    itemCount: detail.auteurs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final auteur = detail.auteurs[index];
                      return Container(
                        margin: EdgeInsets.only(top: index == 0 ? 16.0 : 0.0, bottom: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            child: ClipOval(
                              child: Image.network(
                                'assets/svg/img.png',
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          ),
                          title: Text(
                            auteur.name,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            auteur.role,
                            style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
                          ),
                        ),
                      );
                    },
                  ),

                  ///LISTE PERSONNAGES
                  ListView.builder(
                    itemCount: detail.character.length,
                    itemBuilder: (BuildContext context, int index){
                      final personnage = detail.character[index];
                      return InkWell(
                        onTap: () {
                          GoRouter.of(context).go('/character/${personnage.id}');
                          print(personnage.id);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: index == 0 ? 16.0 : 0.0, bottom: 8.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: 20,
                            ),
                            child: CharacterWidget(characterId: personnage.id.toString()), // Utilisation de CharacterWidget ajusté
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CharacterWidget extends StatelessWidget {

  final String characterId;

  CharacterWidget({Key? key, required this.characterId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is CharacterLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CharacterLoaded) {
          return _buildComicList(state.characters);
        } else if (state is CharacterError) {
          return Center(child: Text('Erreur: ${state.errorMessage4}'));
        } else {
          print(this.characterId);
          print(state);
          return Center(child: Text('État inconnu'));
        }
      },
    );
  }

  Widget _buildComicList(ComicVineCharacter character){
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(character.image?.iconUrl ?? 'url_to_default_image'),
      ),
      title: Text(character.name ?? 'Inconnu', style: TextStyle(color: Colors.white)),

    );
  }
}
