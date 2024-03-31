import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/bloc/app_states.dart';
import 'package:untitled/comicvine_model.dart';

import 'bloc/app_bloc.dart';
import 'bloc/app_events.dart';
import 'comicvine_api.dart';

class ComicListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComicBloc, AppState>(
      builder: (context, state) {
        if (state is ComicsLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ComicsLoaded) {
          return _buildComicList(context, state.comics.cast<ComicVineIssues>());
        } else if (state is ComicsError) {
          return Center(child: Text('Erreur: ${state.errorMessage3}'));
        } else {
          return Center(child: Text('État inconnu'));
        }
      },
    );
  }

  Widget _buildComicList(BuildContext context, List<ComicVineIssues> comics) {
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
                  'Comics populaires',
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
              itemCount: comics.length,
              itemBuilder: (BuildContext context, int index) {
                final comic = comics[index];
                return InkWell(
                  onTap: () {
                    // Logique pour rediriger vers les détails du comic
                    GoRouter.of(context).go('/comicsDetail/${comic.id}');
                    print('Comic sélectionné : ${comic.name}');
                  },
                  child: Container(
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
                              comic.image?.iconUrl ?? 'URL par défaut',
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
                            comic.name ?? 'Titre du Comic',
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
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
