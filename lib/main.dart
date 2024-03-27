import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'comics.dart';
import 'search.dart';
import 'movies.dart';
import 'series.dart';

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

///exemple appel des images/icones
//SvgPicture.asset('assets/svg/your_icon.svg')
//Image.asset('assets/images/your_image.png')

///appel API
//https://comicvine.gamespot.com/api/{nomEndpoint}?api_key={cd0f322e37a01eacb8ec8fe4089d14f5107f4c41}&format=json

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => MoviesPage(),
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _BienvenuePage();
}

/// ******NAVBAR******
/*items: [
BottomNavigationBarItem(
icon: SvgPicture.asset(
'assets/svg/navbar_home.svg',
color: _selectedIndex == 0 ? AppColors.bottomBarSelectedText : AppColors.bottomBarUnselectedText,
),
label: 'Accueil',
),
BottomNavigationBarItem(
icon: SvgPicture.asset(
'assets/svg/navbar_comics.svg',
color: _selectedIndex == 1 ? AppColors.bottomBarSelectedText : AppColors.bottomBarUnselectedText,
),
label: 'Comics',
),
BottomNavigationBarItem(
icon: SvgPicture.asset(
'assets/svg/navbar_series.svg',
color: _selectedIndex == 2 ? AppColors.bottomBarSelectedText : AppColors.bottomBarUnselectedText,
),
label: 'Séries',
),
BottomNavigationBarItem(
icon: SvgPicture.asset(
'assets/svg/navbar_movies.svg',
color: _selectedIndex == 3 ? AppColors.bottomBarSelectedText : AppColors.bottomBarUnselectedText,
),
label: 'Films',
),
BottomNavigationBarItem(
icon: SvgPicture.asset(
'assets/svg/navbar_search.svg',
color: _selectedIndex == 4 ? AppColors.bottomBarSelectedText : AppColors.bottomBarUnselectedText,
),
label: 'Recherche',
),
],
*/

///MON APP REGLAGES
class _BienvenuePage extends State<MyApp> {


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


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15232E),
      body: SafeArea(
        child: ListView( // Remplacé Column par ListView pour le défilement vertical
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Bienvenue !',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SvgPicture.asset(
                    'assets/svg/astronaut.svg',
                    height: 140,
                  ),
                ],
              ),
            ),
            _buildSection('Séries populaires'),
            _buildSection('Comics populaires'),
            _buildSection('Films populaires'),
            // Ajoutez d'autres sections si nécessaire
          ],
        ),
      ),
      // BottomNavigationBar devrait être ici si vous l'avez déjà
    );
  }

  Widget _buildSection(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E3243),
        // Gris plus clair que le fond, ajustez selon votre design
        borderRadius: BorderRadius.circular(
            20.0), // Bord arrondi, ajustez selon votre design
      ),
      margin: EdgeInsets.all(10.0),
      // Espacement autour du conteneur, ajustez selon votre design
      padding: EdgeInsets.all(16.0),
      // Espacement à l'intérieur du conteneur, ajustez selon votre design
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22.0,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // Votre logique pour "Voir plus"
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
            // La hauteur fixe pour le ListView horizontal, ajustez selon votre design
            child: _buildHorizontalItemList(),
          ),
        ],
      ),
    );
  }


  Widget _buildHorizontalItemList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10, // Le nombre de séries à afficher
      itemBuilder: (BuildContext context, int index) {
        return Container(
          width: 160.0,
          // Largeur de l'élément dans la liste horizontale
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          // Espacement entre les éléments
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF3A4750), // Couleur du fond pour l'image
                  borderRadius: BorderRadius.circular(
                      8.0), // Arrondir les coins
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  child: Image.asset(
                    'assets/svg/img.png',
                    // Assurez-vous que le chemin de l'image est correct
                    height: 140.0, // Hauteur fixe pour l'image
                    width: 160.0, // Largeur fixe pour l'image
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: 160.0,
                // La largeur doit correspondre à celle de l'image ci-dessus
                decoration: BoxDecoration(
                  color: Color(0xFF3A4750), // Couleur de fond pour le titre
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ), // Coins arrondis en bas
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 8.0),
                // Padding pour le texte
                child: Text(
                  'Titre du Film', // Le titre du film
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  overflow: TextOverflow
                      .ellipsis, // Pour éviter le débordement de texte
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}












