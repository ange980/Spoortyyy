import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:untitled/main.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.screenBackground,
      appBar: AppBar(
        backgroundColor: AppColors.screenBackground,
        title: Text(
          'Profil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Utilisez GoRouter pour naviguer à la page d'accueil
            GoRouter.of(context).go('/');
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SvgPicture.asset(
                'assets/svg/avatar.svg', // Chemin vers votre fichier SVG dans le dossier des actifs
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nom d\'utilisateur:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              'Angelo', // Remplacez par le nom d'utilisateur de l'utilisateur
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Nombre d\'amis:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              '100', // Remplacez par le nombre d'amis de l'utilisateur
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Paramètres:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            ListTile(
              title: Text(
                'Modifier le profil',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Action à effectuer lors du clic sur "Modifier le profil"
              },
            ),
            ListTile(
              title: Text(
                'Notifications',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Action à effectuer lors du clic sur "Notifications"
              },
            ),
            ListTile(
              title: Text(
                'Préférences',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Action à effectuer lors du clic sur "Préférences"
              },
            ),
            // Ajoutez d'autres paramètres ici...
          ],
        ),
      ),
    );
  }
}
