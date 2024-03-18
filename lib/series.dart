import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/comicvine_api.dart';
import 'package:untitled/comicvine_model.dart';

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

///PAGE LISTE SERIES
class SeriesPage extends StatelessWidget {
  const SeriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15232E),
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Séries les plus populaires',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                // FutureBuilder pour récupérer les séries depuis l'API
                child: FutureBuilder<ComicVineSeriesResponse>(
                  future: ComicVineRequests().getSeries(), // Assurez-vous que cette méthode retourne les bonnes données
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    }
                    if (snapshot.hasError) {
                      return Text('Une erreur est survenue !', style: TextStyle(color: Colors.white));
                    }
                    if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
                      return Text('Aucune série trouvée.', style: TextStyle(color: Colors.white));
                    }
                    // ListView pour afficher les séries
                    return ListView.builder(
                      itemCount: snapshot.data!.results.length,
                      itemBuilder: (BuildContext context, int index) {
                        final series = snapshot.data!.results[index];
                        return Column(
                          children: [
                            SeriesWidget(
                              rank: index + 1,
                              title: series.name ?? 'Nom inconnu',
                              imageUrl: series.image?.iconUrl ?? 'URL par défaut',
                              publisher: 'Marvel',
                              numberOfEpisodes: series.nbEpisode ?? 22,
                              date: series.year ?? '1999',
                            ),
                            SizedBox(height: 16.0), // Espace entre chaque série
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class SeriesWidget extends StatelessWidget {

  final String title;
  final String imageUrl;
  final String publisher;
  final int numberOfEpisodes;
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
        color: Color(0xFF1E3243),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: EdgeInsets.all(16.0),
      child: Stack(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(this.imageUrl, width: 100, height: 100) ,
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
                          'Marvel',
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

///PAGE DETAILS SERIES
class DetailSeries extends StatelessWidget {

  final String seriesId;
  DetailSeries({Key? key, required this.seriesId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // THEME APPLICATION
    return Scaffold(
      backgroundColor: theme.primaryColor,

      body: DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/image/arrow_cover.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Text("Détails pour la série ID: $seriesId"),
                      Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            /// COTE DROIT

                            /// IMAGE SERIE **CHANGER**
                            Image.asset('assets/image/arrow_cover.jpg'),
                            SizedBox(width: 24), //Espace icône et texte
                            ///COTE GAUCHE
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center, // To center the Column contents vertically
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Title Serie',
                                  style: TextStyle(
                                    color: AppColors.element,
                                    fontSize: 24, // Taille de police plus grande
                                    fontWeight: FontWeight.bold, // Texte en gras
                                  ),
                                ),
                                /// ******REUTILISABLE***** Icone + texte
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/svg/ic_publisher_bicolor.svg',
                                      color: AppColors.element,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Title Serie',
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
                                      'assets/svg/ic_tv_bicolor.svg',
                                      color: AppColors.element,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Number of episode',
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
                                      'Date',
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
                    ],
                  ),
                ),
              ),
            ),
            /// ******REUTILISABLE***** Onglet Histoire/personnage/Episode
            TabBar(
              tabs: [
                Tab(text: 'Histoire'),
                Tab(text: 'Personnages'),
                Tab(text: 'Épisodes'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    ///TEXTE HISTOIRE SERIE
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
                  ///LISTE PERSONNAGES
                  Icon(Icons.people), // Remplacer par le contenu réel
                  ///LISTE EPISODE
                  Icon(Icons.list),  // Remplacer par le contenu réel
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}