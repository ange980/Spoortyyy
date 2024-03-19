
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'comics.dart';
import 'search.dart';
import 'movies.dart';
import 'series.dart';

class Accueil extends StatelessWidget{
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
    );
  }

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

