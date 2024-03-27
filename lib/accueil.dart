import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/comicvine_model.dart';
import 'package:untitled/comicvine_api.dart';
import 'package:go_router/go_router.dart';

class Accueil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF15232E),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
            _buildMoviesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF1E3243),
        borderRadius: BorderRadius.circular(20.0),
      ),
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(16.0),
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
                    // Logique pour "Voir plus"
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
            child: _buildHorizontalItemList(),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalItemList() {
    // À remplacer par l'appel d'API pour récupérer les données de la section respective
    // Pour l'instant, cela renvoie simplement une ListView vide
    return ListView();
  }

  Widget _buildMoviesSection(BuildContext context) {
    return FutureBuilder<ComicVineMoviesResponse>(
      future: ComicVineRequests().getMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Une erreur est survenue !', style: TextStyle(color: Colors.white));
        }
        if (!snapshot.hasData || snapshot.data!.results.isEmpty) {
          return Text('Aucun film trouvé.', style: TextStyle(color: Colors.white));
        }
        return Container(
          decoration: BoxDecoration(
            color: Color(0xFF1E3243),
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Films populaires',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        // Logique pour "Voir plus"
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
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.results.length,
                  itemBuilder: (BuildContext context, int index) {
                    final movie = snapshot.data!.results[index];
                    return InkWell(
                      onTap: () {
                        GoRouter.of(context).go('/moviesDetail/${movie.id}');
                      },
                      child: Container(
                        width: 160.0,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFF3A4750),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                                child: Image.network(
                                  movie.image?.iconUrl ?? 'URL par défaut',
                                  height: 140.0,
                                  width: 160.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              width: 160.0,
                              decoration: BoxDecoration(
                                color: Color(0xFF3A4750),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0),
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                              child: Text(
                                movie.name ?? 'Titre du Film',
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
