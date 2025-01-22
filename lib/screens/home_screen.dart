import 'package:flutter/material.dart';
import '../models/team.dart';
import '../widgets/score_input.dart';

class HomeScreen extends StatelessWidget {
  final List<Team> teams;
  final bool _isScrolled;

  HomeScreen({required this.teams, required bool isScrolled}) : _isScrolled = isScrolled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            elevation: _isScrolled ? 4 : 0,
            backgroundColor: _isScrolled ? Colors.white : Colors.transparent,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final top = constraints.biggest.height;
                final expandedHeight = 200.0;
                final shrinkOffset = expandedHeight - top;
                final progress = shrinkOffset / expandedHeight;
                
                return FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsets.only(left: 16, bottom: 16),
                  title: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: progress,
                    child: Text(
                      'Event Scoring',
                      style: TextStyle(
                        color: progress > 0.5 ? Colors.blue.shade900 : Colors.transparent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  background: AnimatedOpacity(
                    duration: Duration(milliseconds: 300),
                    opacity: 1 - progress,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Gradient Background
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.blue.shade700,
                                Colors.blue.shade500,
                              ],
                            ),
                          ),
                        ),
                        // Decorative Circles
                        Positioned(
                          right: -50,
                          top: -50,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -30,
                          bottom: -30,
                          child: Container(
                            width: 140,
                            height: 140,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                        ),
                        // Central Content
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withOpacity(0.2),
                                ),
                                child: Icon(
                                  Icons.emoji_events_rounded,
                                  size: 48,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 16),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${teams.length} Teams Participating',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Team Scores',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: teams.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: EdgeInsets.only(bottom: 16),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.blue.shade50,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                ),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.blue.shade100,
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        color: Colors.blue.shade900,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: TextFormField(
                                      initialValue: teams[index].name,
                                      onChanged: (value) {
                                        teams[index].name = value;
                                      },
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: 'Team Name',
                                        labelStyle: TextStyle(
                                          color: Colors.blue.shade900,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ScoreInput(team: teams[index]),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

