import 'package:flutter/material.dart';

///PAGE RECHERCHE
class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecran Recherche '),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Aller ecran Bienvneu'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}