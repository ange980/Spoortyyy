import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                child: ListView.builder(
                  itemCount: 10, // Nombre arbitraire de films à afficher
                  itemBuilder: (BuildContext context, int index) {
                    int rank = index + 1;
                    return Column(
                      children: [
                        SeriesWidget(rank),
                        SizedBox(height: 16.0), // Espace entre chaque film
                      ],
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
  final int rank;

  SeriesWidget(this.rank);

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
                child: Image.asset(
                  'assets/svg/img.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Titre de la série',
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
                          'Nb épisode',
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
                          'Date ',
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            // To center the Column contents vertically
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
                  ListView.builder(
                    itemCount: 10, //
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage('assets/svg/img.png'),
                        ),
                        title: Text(
                          'Nom du personnage',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    },
                  ),

                  ///LISTE EPISODES

                  ListView.builder(
                    itemCount: 10,
                    // Le nombre d'épisodes que vous souhaitez afficher
                    itemBuilder: (BuildContext context, int index) {
                      // Utilisation de votre widget directement dans ListView.builder
                      return Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF1E3243),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.all(16.0),
                        margin: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset(
                                'assets/svg/img.png',
                                // Assurez-vous que ce chemin est correct et que l'image est ajoutée aux assets
                                width: 100,
                                height: 150,
                                fit: BoxFit.fill,
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Numero de l épisode',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'titre de l episode',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/svg/ic_calendar_bicolor.svg',
                                        width: 15,
                                        height: 15,
                                        color: Colors.white,
                                      ),
                                      SizedBox(width: 5.0),
                                      // Ajustez l'espace comme vous le souhaitez
                                      Text(
                                        '24 septembre 2013',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  //... (Ajoutez d'autres widgets si nécessaire)
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
