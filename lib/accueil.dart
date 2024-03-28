import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/bloc/app_states.dart';
import 'package:untitled/comicvine_model.dart';

import 'bloc/app_bloc.dart';
import 'bloc/app_events.dart';
import 'comicvine_api.dart';
import 'movie_list.dart';

class Accueil extends StatelessWidget {
  @override
  final MovieBloc appBloc = MovieBloc(ComicVineRequests());
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appBloc..add(FetchMovies()),
      child: Scaffold(
      backgroundColor: Color(0xFF15232E),
      body: SafeArea(
      child: ListView( // Remplacé Column par ListView pour le défilement vertical
      children: <Widget>[
      Padding(
      padding: const EdgeInsets.symmetric(
      horizontal: 20.0, vertical: 10.0),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
      Text(
      'Bienvenue !',
      style: TextStyle(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      ),
      ),
      SvgPicture.asset(
      'assets/svg/astronaut.svg',
      height: 140,
    ),
    ],
    ),
    ),
MovieListBuilder(),
    // Ajoutez d'autres sections si nécessaire
    ],
    ),
    ),
      ),
    );
  }
}



