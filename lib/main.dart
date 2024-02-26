import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
}

///exemple appel des images/icones
//SvgPicture.asset('assets/svg/your_icon.svg')
//Image.asset('assets/images/your_image.png')

///appel API
//https://comicvine.gamespot.com/api/{nomEndpoint}?api_key={cd0f322e37a01eacb8ec8fe4089d14f5107f4c41}&format=json

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ComicsApplication',
      theme: ThemeData(
        primaryColor: AppColors.screenBackground,
        useMaterial3: true,
        fontFamily: 'Nunito',
      ),
      home: MyCustomScreen(),
    );
  }
}

class MyCustomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);//THEME APPLICATION

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        title: Text('Application'),
        backgroundColor: theme.cardTheme.color,
      ),
      body: Center(
        child: Text(
          'Welcome to the app!',
          style: TextStyle(fontFamily: 'RobotoMono'),
        ),
      ),
      // Rest of your UI components
    );
  }
}