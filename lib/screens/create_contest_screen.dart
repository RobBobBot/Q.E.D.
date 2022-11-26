import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:qed/custom_widgets/mydrawer.dart';

class CreateContestScreen extends StatefulWidget {
  const CreateContestScreen({super.key});

  @override
  State<CreateContestScreen> createState() => _CreateContestScreenState();
}

class _problemInfo {
  FilePickerResult? files;
  String? name;
}

class _CreateContestScreenState extends State<CreateContestScreen> {
  List<_problemInfo> problemInfos = [];
  TextEditingController contestTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create a new contest:")),
      drawer: MyDrawer(),
      body: ListView(
        children: [
          TextField(
            controller: contestTitle,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              hintText: "Epic title goes here...",
              labelStyle: Theme.of(context).textTheme.headline2,
              //hintStyle: Theme.of(context).textTheme.headline3,
            ),
          ),
          Divider(),
          ...problemInfos
              .map((e) => _ProblemCreatorListTile(
                  onStatementSelectTap: () {},
                  onSolutionSelectTap: () {},
                  onNameChanged: (name) {
                    e.name = name;
                  },
                  info: e))
              .toList(),
          ListTile(
            title: Icon(Icons.add_box_outlined),
            onTap: () => setState(() {
              problemInfos.add(_problemInfo());
            }),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text("Upload"),
            ),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}

class _ProblemCreatorListTile extends StatelessWidget {
  final _problemInfo info;
  final void Function() onStatementSelectTap;
  final void Function() onSolutionSelectTap;
  final void Function(String) onNameChanged;
  const _ProblemCreatorListTile(
      {super.key,
      required this.onSolutionSelectTap,
      required this.onNameChanged,
      required this.info,
      required this.onStatementSelectTap});

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   visualDensity: VisualDensity(horizontal: 40, vertical: 40),
    //   leading: Icon(Icons.picture_as_pdf_rounded),
    //   title: TextField(
    //     onSubmitted: onNameChanged,
    //     decoration: InputDecoration(
    //       hintText: "Problem name...",
    //     ),
    //   ),
    //   trailing: Column(
    //     children: [
    //       ElevatedButton(
    //         child: Text("Choose statement"),
    //         onPressed: onStatementSelectTap,
    //       ),
    //       ElevatedButton(
    //         child: Text("Choose solution"),
    //         onPressed: onSolutionSelectTap,
    //       ),
    //     ],
    //   ),
    // );
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.picture_as_pdf_rounded),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onSubmitted: onNameChanged,
                decoration: InputDecoration(
                  hintText: "Problem name...",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                ElevatedButton(
                  child: Text("Choose statement"),
                  onPressed: onStatementSelectTap,
                ),
                ElevatedButton(
                  child: Text("Choose solution"),
                  onPressed: onSolutionSelectTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
