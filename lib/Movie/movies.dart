import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class AppColors {
  static const Color cardBackground = Color(0xFF1E3243);
}

class AccueilMovie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      body: MoviePage(),
    );
  }
}

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 48.0, left: 20),
          child: Text(
            'Evenements',
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
          itemCount: moviesData.length,
          itemBuilder: (BuildContext context, int index) {
            final serie = moviesData[index];
            return InkWell(
              onTap: () {
                GoRouter.of(context).go('/moviesDetail/${serie['id']}');
                print(serie['id']);
              },
              child: Column(
                children: [
                  MoviesWidget(
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

class MoviesWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String publisher;
  final int numberOfEpisodes;
  final String date;
  final int rank;

  MoviesWidget({
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
                child: Image.asset(
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
                        SvgPicture.asset(
                          'assets/svg/ic_publisher_bicolor.svg',
                          width: 15,
                          height: 15,
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
                        SvgPicture.asset(
                          'assets/svg/ic_tv_bicolor.svg',
                          width: 15,
                          height: 15,
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

List<Map<String, dynamic>> moviesData = [
  {
    'id': 1,
    'name': 'Tournoi pétanque',
    'imageUrl': 'assets/image/serie1.jpeg',
    'publisher': 'Intermédiaire',
    'numberOfEpisodes': 24,
    'date': '10-04-2024',
  },
  {
    'id': 2,
    'name': 'Match Badminton',
    'imageUrl': 'assets/image/badminton.jpeg',
    'publisher': 'Amateur',
    'numberOfEpisodes': 18,
    'date': '11-5-2024',
  },
  {
    'id': 3,
    'name': 'Cours escrime',
    'imageUrl': 'assets/image/escrime.jpeg',
    'publisher': 'Image Comics',
    'numberOfEpisodes': 30,
    'date': '13-4-2024',
  },
];
