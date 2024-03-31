import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled/bloc/app_states.dart';
import 'package:untitled/comicvine_model.dart';

import 'bloc/app_bloc.dart';
import 'bloc/app_events.dart';
import 'comicvine_api.dart';

class SerieListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SerieBloc, AppState>(
      builder: (context, state) {
        if (state is SeriesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is SeriesLoaded) {
          return _buildSerieList(context, state.series);
        } else if (state is SeriesError) {
          return Center(child: Text('Erreur: ${state.errorMessage2}'));
        } else {
          return Center(child: Text('État inconnu'));
        }
      },
    );
  }

  Widget _buildSerieList(BuildContext context, List<ComicVineSeries> series) {
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
                  'Séries populaires',
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
              itemCount: series.length,
              itemBuilder: (BuildContext context, int index) {
                final serie = series[index];
                return InkWell(
                  onTap: () {
                    GoRouter.of(context).go('/seriesDetail/${serie.id}');
                    print('Série sélectionnée : ${serie.name}');
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
                              serie.image?.iconUrl ?? 'URL par défaut',
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
                            serie.name ?? 'Titre de la Série',
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
