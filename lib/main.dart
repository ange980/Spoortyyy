import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'accueil.dart';
import 'comics.dart';
import 'movies.dart';
import 'search.dart';
import 'series.dart';

/// COULEURS
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

/// exemple appel des images/icones
// SvgPicture.asset('assets/svg/your_icon.svg')
// Image.asset('assets/images/your_image.png')

/// appel API
// https://comicvine.gamespot.com/api/{nomEndpoint}?api_key={cd0f322e37a01eacb8ec8fe4089d14f5107f4c41}&format=json

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => HomePage(),
    ),
    GoRoute(
      path: '/comics',
      builder: (BuildContext context, GoRouterState state) => ComicsPage(),
    ),
    GoRoute(
      path: '/comicsDetail/:id',
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['id']!;
        return DetailComics(comicsId: id);
      },
    ),
    GoRoute(
      path: '/series',
      builder: (BuildContext context, GoRouterState state) => SeriesPage(),

    ),
    GoRoute(
      path: '/seriesDetail/:id',
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['id']!;
        return DetailSeries(seriesId: id);
      },
    ),
    GoRoute(
      path: '/movies',
      builder: (BuildContext context, GoRouterState state) => MoviesPage(),
    ),
    GoRoute(
      path: '/moviesDetail/:id',
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['id']!;
        return DetailMovies(moviesId: id);
      },
    ),
    GoRoute(
      path: '/search',
      builder: (BuildContext context, GoRouterState state) => SearchPage(),
    ),
  ],
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData(
        primaryColor: AppColors.screenBackground,
        useMaterial3: true,
        fontFamily: 'Nunito',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentTabPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15232E),
      body: Stack(
        children: [
          _getContent(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: AppColors.bottomBarBackground,
              ),

              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                currentIndex: _currentTabPosition,
                type: BottomNavigationBarType.fixed,
                items: AppTabs.values
                    .map((tab) =>
                    BottomNavigationBarItem(label: tab.label, icon: Icon(tab.icon)))
                    .toList(growable: false),
                onTap: (int position) {
                  setState(() {
                    _currentTabPosition = position;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getContent() {
    switch (AppTabs.values[_currentTabPosition]) {
      case AppTabs.home:
        return Accueil();
      case AppTabs.comics:
        return AccueilComic();
      case AppTabs.series:
        return AccueilSerie();
      case AppTabs.movies:
        return AccueilMovie();
      case AppTabs.search:
        return SearchPage();
    }
  }
}

enum AppTabs {
  home('Accueil', Icons.home),
  comics('Comics', Icons.book),
  series('Séries', Icons.tv),
  movies('Films', Icons.movie),
  search('Recherche', Icons.search);

  final String label;
  final IconData icon;

  const AppTabs(this.label, this.icon);
}
