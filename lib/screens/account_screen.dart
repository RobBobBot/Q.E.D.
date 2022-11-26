import 'package:flutter/material.dart';
import 'package:qed/custom_widgets/mydrawer.dart';

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
        title: Text('User'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.admin_panel_settings)),
          IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
        ],
      ),
      drawer: MyDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 50,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Username'),
                      Text('Real Name'),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 32,
              ),
              Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse lobortis at neque nec interdum. Maecenas bibendum lacus urna, sit amet vulputate nisl mattis a. Nulla pulvinar consectetur malesuada. Cras sed lorem nec tellus aliquam sagittis. '),
              SizedBox(
                height: 10,
              ),
              Text('Status: elev'),
              Text('rating: 4.5'),
              Text('solved problems: 12'),
            ],
          ),
        ),
      ),
    );
  }
}
