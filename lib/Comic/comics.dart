import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppColors {
  static const Color cardBackground = Color(0xFF1E3243);
}

class AccueilComic extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: ComicsPage(),
    );
  }
}

class ComicsPage extends StatelessWidget {
  const ComicsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 48.0, left: 20),
          child: Text(
            'Sports les plus populaires',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 16.0), // Espace
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: comicsData.length,
          itemBuilder: (BuildContext context, int index) {
            final serie = comicsData[index];
            return InkWell(
              onTap: () {
                GoRouter.of(context).go('/comicsDetail/${serie['id']}');
                print(serie['id']);
              },
              child: Column(
                children: [
                  ComicsWidget(
                    rank: index + 1,
                    title: serie['name'] ?? 'Nom inconnu',
                    imageUrl: serie['imageUrl'] ?? 'URL par défaut',
                    publisher: serie['publisher'] ?? 'Marvel',
                    numberOfEpisodes: serie['numberOfEpisodes'] ?? 22,
                    date: serie['date'] ?? '1999',
                  ),
                  SizedBox(height: 16.0), // Espace entre chaque série
                ],
              ),
            );
          },
        ),
        SizedBox(height: 40,)
      ],
    );

  }
}

class ComicsWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String publisher;
  final String numberOfEpisodes;
  final String date;
  final int rank;

  ComicsWidget({
    required this.rank,
    required this.title,
    required this.imageUrl,
    required this.publisher,
    required this.numberOfEpisodes,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  this.imageUrl,
                  width: 128,
                  height: 163,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      this.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Row(
                      children: [
                        Icon(
                          Icons.person,

                          color: Colors.grey,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          this.publisher,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.stadium,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          this.numberOfEpisodes.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.stadium,

                          color: Colors.grey,
                        ),
                        SizedBox(width: 15.0),
                        Text(
                          this.date,
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

List<Map<String, dynamic>> comicsData = [
  {
    'id': 1,
    'name': 'Padel',
    'imageUrl': 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/10/Pala_de_padel.jpg/1200px-Pala_de_padel.jpg',
    'publisher': '2-4',
    'numberOfEpisodes': 'intérieur et extérieur',
    'date': '2001',
  },
  {
    'id': 2,
    'name': 'Natation',
    'imageUrl': 'https://www.planetegrandesecoles.com/wp-content/uploads/2023/08/avantages-sport-natation-etudiant-activite-850x560.jpg',
    'publisher': '1',
    'numberOfEpisodes': 'intérieur',
    'date': '1998',
  },
  {
    'id': 3,
    'name': 'Kabadi',
    'imageUrl': 'https://img.freepik.com/vecteurs-premium/athlete-jouant-du-kabadi-dans-arenes_689830-587.jpg',
    'publisher': '14-24',
    'numberOfEpisodes': 'intérieur',
    'date': '2005',
  },
];
