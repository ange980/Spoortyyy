import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class SeriesDetailPage extends StatelessWidget {
  final Map<String, dynamic> serie;

  SeriesDetailPage({required this.serie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardBackground,
      appBar: AppBar(
        title: Text('Détails de la série'),
        backgroundColor: AppColors.cardBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Fonction appelée lorsque le bouton de retour est pressé
            GoRouter.of(context).go('/');
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serie['name'] ?? 'Nom inconnu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                serie['imageUrl'] ?? 'URL par défaut',
                width: 300,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Description:',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Ajoutez votre texte descriptif ici...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Icon(
                  Icons.sports,
                  color: Colors.white,
                ),
                SizedBox(width: 8.0),
                Text(
                  'Liste des sports:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView(
                children: [
                  _buildSportListItem('Football'),
                  _buildSportListItem('Basketball'),
                  _buildSportListItem('Tennis'),
                  // Ajoutez d'autres sports ici...
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSportListItem(String sportName) {
    return ListTile(
      leading: Icon(
        Icons.sports_soccer,
        color: Colors.white,
      ),
      title: Text(
        sportName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      ),
      onTap: () {
        // Implémentez ici ce que vous souhaitez faire lorsqu'un sport est sélectionné
      },
    );
  }
}

class AppColors {
  static const Color cardBackground = Color(0xFF1E3243);
}
