import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ComicListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildSerieList(context);
  }

  Widget _buildSerieList(BuildContext context) {
    // Simuler des données de séries statiques
    List<Map<String, dynamic>> series = [
      {'id': 1, 'name': 'Tournoi pétanque', 'imagePath': 'assets/image/serie1.jpeg'},
      {'id': 2, 'name': 'Découverte badminton', 'imagePath': 'assets/image/badminton.jpeg'},
      {'id': 3, 'name': 'Cours escrime', 'imagePath': 'assets/image/escrime.jpeg'},
    ];

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
                  'Vos Evenements',
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
                    // Navigation vers la page détail
                    GoRouter.of(context).go('/moviesDetail/${serie['id']}');
                    print('Événement sélectionné : ${serie['name']}');
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
                            child: Image.asset(
                              serie['imagePath'] ?? 'assets/default_image.jpeg',
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
                            serie['name'] ?? 'Nom de l\'événement',
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
