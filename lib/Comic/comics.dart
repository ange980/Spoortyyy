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
import 'package:untitled/Comic/comicDetail.dart';

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