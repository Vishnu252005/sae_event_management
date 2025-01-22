import 'package:flutter/material.dart';
import '../screens/home_screen.dart';
import '../screens/results_screen.dart';
import '../screens/statistics_screen.dart';
import '../models/team.dart';

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  List<Team> teams = List.generate(5, (index) => Team(name: 'Team ${index + 1}'));
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset > 0 && !_isScrolled) {
      setState(() => _isScrolled = true);
    } else if (_scrollController.offset <= 0 && _isScrolled) {
      setState(() => _isScrolled = false);
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      teams.forEach((team) => team.calculateTotalScore());
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomeScreen(teams: teams, isScrolled: _isScrolled),
      ResultsScreen(teams: teams),
      StatisticsScreen(teams: teams),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.edit_note_rounded),
                activeIcon: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.edit_note_rounded),
                ),
                label: 'Input',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.leaderboard_rounded),
                activeIcon: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.leaderboard_rounded),
                ),
                label: 'Results',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.analytics_rounded),
                activeIcon: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.analytics_rounded),
                ),
                label: 'Statistics',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue.shade700,
            unselectedItemColor: Colors.grey.shade600,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: true,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
} 