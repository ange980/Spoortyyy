import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _BienvenuePage();
}


///MON APP REGLAGES
class _BienvenuePage extends State<MyApp> {
  int _selectedIndex = 0;

  // Liste de chaque page correspondant aux onglets (Garder dans l'ordre)
  final List<Widget> _pages = [
    HomePage(),
    ComicsPage(),
    SeriesPage(),
    MoviesPage(),
    SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColors.screenBackground,
        useMaterial3: true,
        fontFamily: 'Nunito',
      ),
      /// ******NAVBAR******
      home: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: AppColors.bottomBarBackground,
          selectedItemColor: AppColors.bottomBarSelectedText,
          unselectedItemColor: AppColors.bottomBarUnselectedText,
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
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
        ),
      ),
    );
  }
}

///PAGE DE BIENVENUE
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Premier Écran'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Aller au second écran'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SeriesPage()),
            );
          },
        ),
      ),
    );
  }
}









