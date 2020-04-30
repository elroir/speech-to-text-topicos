import 'package:flutter/material.dart';
import 'package:speechtotext/pages/home_page.dart';
import 'package:speechtotext/pages/theme_page.dart';

class BottomBarPage extends StatefulWidget {
  @override
  _BottomBarPageState createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _callPage(currentIndex),
      bottomNavigationBar: _createBottomNavigationBar(),
    );
  }

  _callPage(int paginaActual) {

    switch ( paginaActual){
      case 0: return HomePage();
      case 1: return ThemePage();
    }

  }

  Widget _createBottomNavigationBar(){
    return BottomNavigationBar(
     // backgroundColor: Colors.greenAccent,
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.add_to_home_screen),
            title: Text('Principal')
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Opciones')
        ),
      ],
    );
  }
}
