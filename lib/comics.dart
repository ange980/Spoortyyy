import 'package:flutter/material.dart';

///PAGE LISTE COMICS
class ComicsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecran sur les Comics '),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Aller ecran Film'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ComicsPage()),
            );
          },
        ),
      ),
    );
  }
}