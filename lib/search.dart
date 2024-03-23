import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled/main.dart';

///PAGE RECHERCHE
class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      body: Column(
        children: [
          SearchBarContainer(),
          SizedBox(height: 150),
          Column(
            children: [
              // Espacement pour des raisons de visibilité
              Container(
                width: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Stack(
                  clipBehavior: Clip.none, // Permettre le dépassement de l'image
                  children: [
                    Positioned(
                      top: -50,
                      right: -50, // Positionner l'image à l'extérieur du conteneur
                      child: SvgPicture.asset(
                        'assets/svg/astronaut.svg',
                        height: 100,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Titre",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Description du contenu...",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}






class SearchBarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500, // Largeur du conteneur
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: AppColors.cardBackground, // Couleur de fond du conteneur
        borderRadius: BorderRadius.circular(30.0), // Bordure arrondie
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
      padding: EdgeInsets.only(top:25,left: 10),
      child: Text(
            'Recherche', // Texte au-dessus de la barre de recherche
            style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          ),
          SizedBox(height: 20.0), // Espacement entre le texte et la barre de recherche
          SearchBar(),
          SizedBox(height: 5.0),
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      child: TextField(
      controller: _controller,
      style: TextStyle(color: Colors.white), // Couleur du texte de recherche
      decoration: InputDecoration(
        hintText: 'Comic, film, série...',
        hintStyle: TextStyle(color: Colors.white70), // Couleur du texte d'indice
        suffixIcon: IconButton(
          icon: Icon(Icons.search, color: Colors.white), // Couleur de l'icône de recherche
          onPressed: () {
            // Mettre ici le code à exécuter lors de la recherche
            print('Recherche: ${_controller.text}');
          },
        ),
        filled: true,
        fillColor: AppColors.screenBackground, // Couleur de fond de la barre de recherche
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none, // Enlever la bordure
        ),
      ),
    )
    );
  }
}