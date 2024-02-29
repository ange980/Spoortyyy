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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// COTE DROIT
                      /// IMAGE SERIE **CHANGER**
                      SvgPicture.asset(
                        'assets/svg/ic_publisher_bicolor.svg',
                        color: AppColors.cardElementBackground,
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(width: 24), //Espace icône et texte
                      ///COTE GAUCHE
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center, // To center the Column contents vertically
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                  Icon(Icons.people), // Remplacer par le contenu réel
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