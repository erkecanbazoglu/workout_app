import 'package:flutter/material.dart';
import 'package:workout_app/ui/screens/empty_page.dart';
import 'package:workout_app/ui/screens/workout_list_page.dart';
import 'package:workout_app/ui/screens/workout_page.dart';
import '../../core/constants/styles.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    WorkoutListPage(),
    EmptyPage(title: "Empty Page"),
    EmptyPage(title: "Empty Page"),
    EmptyPage(title: "Empty Page"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).padding.bottom + 60,
        child: BottomNavigationBar(
          elevation: 0,
          selectedIconTheme: kBottomNavbarSelectedIconTheme,
          unselectedIconTheme: kBottomNavbarUnselectedIconTheme,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                size: 24,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
                size: 24,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite,
                size: 24,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                size: 24,
              ),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
