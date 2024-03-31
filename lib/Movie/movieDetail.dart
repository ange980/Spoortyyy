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
          return _buildComicList(state.details, context);
        } else if (state is MovieDetailError) {
          return Center(child: Text('Erreur: ${state.errorMessage5}'));
        } else {
          return Center(child: Text('État inconnu'));
        }
      },
    );
  }

  Widget _buildComicList(ComicVineMovieDetail detail, BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            GoRouter.of(context).go('/');
          },
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
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
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              detail.image?.iconUrl ?? 'null',
                              width: 128,
                              height: 163,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 24),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                detail.name ?? 'Null',
                                style: TextStyle(
                                  color: AppColors.element,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/svg/ic_movie_bicolor.svg',
                                    color: AppColors.element,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    detail.name ?? 'Null',
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
                                    detail.date ?? 'Mai 1999',
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

                  ListView.builder(
                    itemCount: detail.characters.length,
                    itemBuilder: (BuildContext context, int index) {
                      final personnage = detail.characters[index];
                      return InkWell(
                        onTap: () {
                          GoRouter.of(context).go('/character/${personnage.id}');
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
                        ),
                      );
                    },
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildInfoRow('Classification', 'R' ?? 'Inconnu'),
                      if (detail.writers.isNotEmpty)
                        buildInfoSection('Scénaristes', detail.writers.map((writer) => writer.name).toList()),
                      if (detail.producers.isNotEmpty)
                        buildInfoSection('Producteurs', detail.producers.map((producer) => producer.name).toList()),
                      if (detail.studio.isNotEmpty)
                        buildInfoSection('Studios', detail.studio.map((studio) => studio.name).toList()),
                      buildInfoRow('Budget', formatNumberAsMillions(detail.budget) ?? 'Inconnu'),
                      buildInfoRow('Recettes au box-office', formatNumberAsMillions(detail.boxOffice)),
                      buildInfoRow('Recette brutes totales',formatNumberAsMillions(detail.total)),
                    ],
                  )
                ],
              ),
            ),
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
        Spacer(),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    ),
  );
}

Widget buildInfoSection(String title, List<String> names) {
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
        Spacer(),
        for (var name in names)
          Text(
            name,
            style: TextStyle(color: Colors.white),
          ),
      ],
    ),
  );
}


