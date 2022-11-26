import 'package:flutter/material.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Leaderboard'),
            centerTitle: true,
            backgroundColor: Colors.black,
          ),
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/top.png',
                  height: 200,
                ),
              ),
              Positioned(
                top: 225.0,
                left: 69.0,
                width: 80,
                height: 80,
                child: Image.network(
                    'https://static.vecteezy.com/system/resources/previews/006/892/625/original/discord-logo-icon-editorial-free-vector.jpg'),
              ),
              Positioned(
                top: 175.0,
                right: 77.0,
                width: 80,
                height: 80,
                child: Image.network(
                    'https://pretty-chic.ro/wp-content/uploads/2021/04/tunsoare-scurta.jpg'),
              ),
              Positioned(
                width: 80,
                height: 80,
                top: 115.0,
                left: 163.0,
                child: Image.asset('assets/realAD.png'),
              ),
              Positioned(
                bottom: 90.0,
                left: 90.0,
                child: Text(
                  'realAD is the winner!',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.0,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
