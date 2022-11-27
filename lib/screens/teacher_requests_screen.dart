import 'package:flutter/material.dart';
import 'package:qed/firebase/qedstore.dart';
import 'package:qed/screens/loading_screen.dart';

class TeacherRequestsScreen extends StatefulWidget {
  const TeacherRequestsScreen({super.key});

  @override
  State<TeacherRequestsScreen> createState() => _TeacherRequestsScreenState();
}

class _TeacherRequestsScreenState extends State<TeacherRequestsScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Teacher Requests'),
            ),
            body: ListView(
                children: snapshot.data!
                    .map((e) => ListTile(
                          title: Text(e.name),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ElevatedButton(
                                child: Text('Reject'),
                                onPressed: () async {
                                  await QEDStore.instance.deleteRequest(e.uid);
                                  setState(() {});
                                },
                              ),
                              SizedBox(width: 5),
                              ElevatedButton(
                                child: Text('Accept'),
                                onPressed: () async {
                                  await QEDStore.instance.maketeacher(e.uid);
                                  await QEDStore.instance.deleteRequest(e.uid);
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        ))
                    .toList()),
          );
        }
        return LoadingScreen();
      },
      future: QEDStore.instance.getRequests(),
    );
  }
}
