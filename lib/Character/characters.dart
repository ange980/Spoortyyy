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

String gender(int gender) {

  if (gender == 1) {
    return "Masculin";
  } else {
    return "Féminin";
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
class AccueilCharacter extends StatelessWidget {
  @override
  final String characterId;
  final AppBloc appBloc;

  AccueilCharacter({Key? key, required this.characterId})
      : appBloc = AppBloc(ComicVineRequests()),
        super(key: key);

  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appBloc..add(FetchCharacter(characterId)),
      child: Scaffold(

        body: Character(characterId: characterId),
      ),
    );
  }
}

class Character extends StatelessWidget {

  final String characterId;
  Character({Key? key, required this.characterId}) : super(key: key);

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
          return Center(child: Text('État inconnu'));
        }
      },
    );
  }

  Widget _buildComicList(ComicVineCharacter character){
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: DefaultTabController(
        length: 2,
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
                            character.image?.iconUrl ?? 'null',
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
                          SizedBox(width: 24), //Espace icône et texte
                          ///COTE GAUCHE
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center, // To center the Column contents vertically
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                character.name?? 'Inconnu',
                                style: TextStyle(
                                  color: AppColors.element,
                                  fontSize: 24, // Taille de police plus grande
                                  fontWeight: FontWeight.bold, // Texte en gras
                                ),
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
                  ///INFOS
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, // Alignez le texte à gauche
                    children: [
                      buildInfoRow('Nom super-héros', character.name ?? 'Inconnu'),
                      buildInfoRow('Nom réel', character.realName ?? 'Inconnu'),
                      buildInfoRow('Aliases', character.aliases ?? 'Inconnu'),
                      ...character.createur.map((creator) => buildInfoRow('Créateur', creator.name)),
                      buildInfoRow('Genre', gender(character.gender)),
                      buildInfoRow('Date de naissance', character.birthday ?? 'Inconnu'),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildInfoRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
    child: Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(), // Cela crée un espace entre les éléments de la rangée
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right, // Alignez le texte à droite pour les valeurs
            style: TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}


