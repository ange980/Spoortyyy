import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Simuler des données de séries statiques
    List<Map<String, dynamic>> series = [
      {
        'id': 1,
        'name': 'Padel',
        'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Pala_de_padel.jpg/1200px-Pala_de_padel.jpg',
      },
      {
        'id': 2,
        'name': 'Natation',
        'imageUrl': 'https://www.planetegrandesecoles.com/wp-content/uploads/2023/08/avantages-sport-natation-etudiant-activite-850x560.jpg',
      },
      {
        'id': 3,
        'name': 'kabadi',
        'imageUrl': 'https://img.freepik.com/vecteurs-premium/athlete-jouant-du-kabadi-dans-arenes_689830-587.jpg',
      },
    ];

    return _buildSerieList(context, series);
  }

  Widget _buildSerieList(BuildContext context, List<Map<String, dynamic>> series) {
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
                  'Sports',
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
                    GoRouter.of(context).go('/comicsDetail/${serie['id']}');
                    print('Série sélectionnée : ${serie['name']}');
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
                              serie['imageUrl'] ?? 'URL par défaut',
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
                            serie['name'] ?? 'Titre de la Série',
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
