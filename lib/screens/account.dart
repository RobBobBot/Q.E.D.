import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        centerTitle: true,
        backgroundColor: Color(0xFF3B22A1),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'settings',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      backgroundColor: Color(0xFFE8F3FF),
      body: Column(
        children: [
          Spacer(),
          Row(
            children: [
              Spacer(),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFFE8F3FF),
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/realAD.png'))),
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    'realAD',
                    style: TextStyle(fontSize: 25),
                  ),
                  Text('A smartass.')
                ],
              ),
              Spacer()
            ],
          ),
          Spacer(),
          Row(
            children: [
              Spacer(),
              Column(
                children: [
                  Text('Status:'),
                  Text(
                    'Online',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  )
                ],
              ),
              Spacer(),
              Text('Contests:'),
              Spacer()
            ],
          ),
          Row(
            children: [
              Spacer(flex: 4),
              Column(
                children: [
                  Text('QED 2021'),
                  Text('QED 2019'),
                  Text('QED 2018'),
                  Text('QED 2017'),
                  Text('QED 2016'),
                ],
              ),
              Spacer()
            ],
          ),
          Spacer(flex: 4)
        ],
      ),
    );
  }
}
