import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/app_states.dart';
import 'package:untitled/comicvine_model.dart';

import 'bloc/app_bloc.dart';
import 'bloc/app_events.dart';
import 'comicvine_api.dart';

class Accueil extends StatelessWidget {
  @override
  final AppBloc appBloc = AppBloc(ComicVineRequests());
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => appBloc..add(FetchMovies()),
      child: Scaffold(

        body: MovieListBuilder(),
      ),
    );
  }
}

class MovieListBuilder extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is MoviesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is MoviesLoaded) {
          return _buildMovieList(state.movies);
        } else if (state is MoviesError) {
          return Center(child: Text('Erreur: ${state.errorMessage}'));
        } else {
          return Center(child: Text('État inconnu'));
        }
      },
    );
  }

  Widget _buildMovieList(List<ComicVineMovie> movies) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E3243),
        borderRadius: BorderRadius.circular(20.0),
      ),

      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Films populaires',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Logique pour "Voir plus"
                  },
                  child: Text(
                    'Voir plus',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 200.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = movies[index];
                return Container(
                  width: 160.0,
                  margin: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF3A4750),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          child: Image.network(
                            movie.image?.iconUrl ?? 'URL par défaut',
                            height: 140.0,
                            width: 160.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        width: 160.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF3A4750),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                        child: Text(
                          movie.name ?? 'Titre du Film',
                          style: TextStyle(color: Colors.white),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
