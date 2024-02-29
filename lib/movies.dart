import 'package:flutter/material.dart';

///PAGE LISTE FILMS
class MoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecran des Films '),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Aller ecran Serie'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MoviesPage()),
            );
          },
        ),
      ),
    );
  }
}