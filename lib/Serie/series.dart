import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppColors {
  static const Color cardBackground = Color(0xFF1E3243);
}

class AccueilSerie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: SeriesPage(),
    );
  }
}

class SeriesPage extends StatelessWidget {
  const SeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 48.0, left: 20),
          child: Text(
            'Lieux les plus populaires',
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
          itemCount: seriesData.length,
          itemBuilder: (BuildContext context, int index) {
            final serie = seriesData[index];
            return InkWell(
              onTap: () {
                context.go('/seriesDetail/${serie['id']}');
                print(serie['id']);
              },
              child: Column(
                children: [
                  SeriesWidget(
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

class SeriesWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String publisher;
  final String numberOfEpisodes;
  final String date;
  final int rank;

  SeriesWidget({
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
                        Icons.sports_football,
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
                          Icons.pin_drop,
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
                        SvgPicture.asset(
                          'assets/svg/ic_calendar_bicolor.svg',
                          width: 15,
                          height: 15,
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

List<Map<String, dynamic>> seriesData = [
  {
    'id': 1,
    'name': 'Stade Suzanne Lenglen ',
    'imageUrl': 'https://cdn.paris.fr/eqpts-prod/2022/05/10/6a9accf9247e4bf1858044d81b78881e.jpg',
    'publisher': 'Foot,Rugby,Tennis',
    'numberOfEpisodes': '15 ème arrondissemnt',
    'date': '2001',
  },
  {
    'id': 2,
    'name': 'Stade Emile Antoine',
    'imageUrl': 'https://cdn.paris.fr/eqpts-prod/2022/05/10/82c4c2293ee4ba12c729aab03065e7f2.jpg',
    'publisher': 'DC Comics',
    'numberOfEpisodes': '15 ème arrondissement',
    'date': '1998',
  },
  {
    'id': 3,
    'name': 'Piscine Keller',
    'imageUrl': 'https://cdn.paris.fr/eqpts-prod/2022/05/30/091c85bff65e9ae7c85c279ac1a293e7.jpeg',
    'publisher': 'Image Comics',
    'numberOfEpisodes': '15 ème arrondissement',
    'date': '2005',
  },
];
