import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/results_screen.dart';
import '../models/team.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  List<Team> teams = List.generate(5, (index) => Team(name: 'Team ${index + 1}'));

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      teams.forEach((team) => team.calculateTotalScore());
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(teams: teams),
      ResultsScreen(teams: teams),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Input Scores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'View Results',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }
} 