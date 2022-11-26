import 'package:flutter/material.dart';

import '../contest.dart';
import 'leaderboard_screen.dart';

class FinishedContestScreen extends StatelessWidget {
  FinishedContestScreen({required this.contest, Key? key}) : super(key: key);
  Contest contest;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Finished Contest Name'),
          centerTitle: true,
          backgroundColor: Color(0xFF3B22A1),
        ),
        backgroundColor: Color(0xFFE8F3FF),
        body: Column(
          children: [
            Spacer(),
            Text('Give scores to submissions:'),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Card(
                  child: ListTile(
                    leading: Image.asset('assets/realAD.png'),
                    title: Text('realAD'),
                    subtitle: Text('Who is this person?'),
                  ),
                ),
                Positioned(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    child: Text("Vote"),
                    onPressed: () {},
                  ),
                  right: 10.0,
                  left: 340.0,
                  bottom: 0,
                )
              ],
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Card(
                  child: ListTile(
                    leading: Image.network(
                        'https://static.vecteezy.com/system/resources/previews/006/892/625/original/discord-logo-icon-editorial-free-vector.jpg'),
                    title: Text('Discord'),
                    subtitle: Text('Joins the game!'),
                  ),
                ),
                Positioned(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    child: Text("Vote"),
                    onPressed: () {},
                  ),
                  right: 10.0,
                  left: 340.0,
                  bottom: 0,
                )
              ],
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Card(
                  child: ListTile(
                    leading: Image.network(
                        'https://pretty-chic.ro/wp-content/uploads/2021/04/tunsoare-scurta.jpg'),
                    title: Text('Alice'),
                    subtitle: Text('My babe is Joey'),
                  ),
                ),
                Positioned(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                    ),
                    child: Text("Vote"),
                    onPressed: () {},
                  ),
                  right: 10.0,
                  left: 340.0,
                  bottom: 0,
                )
              ],
            ),
            Spacer(),
            Text('Current Leaderboard:'),
            Text('1st: '),
            Text('2nd: '),
            Text('3rd: '),
            Spacer(),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LeaderboardScreen()));
              },
              child: Text(
                'SEE FINAL SCORES',
                style: TextStyle(color: Colors.black),
              ),
            ),
            Spacer(),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
          height: 60.0,
          color: Color(0xFF3B22A1),
          child: Row(
            children: [
              Spacer(),
              Text(
                'Time Left: HH:MM:SS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              Spacer()
            ],
          ),
        )),
      ),
    );
  }
}
