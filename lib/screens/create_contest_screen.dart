import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create a new contest:")),
      body: ListView(
        children: [
          ListTile(
            leading: Text("Name your contest:"),
          ),
          TextField(),
          Divider(),
          ...problemInfos
              .map((e) => _ProblemCreatorListTile(
                  onFilesSelectTap: () {},
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
    );
  }
}

class _ProblemCreatorListTile extends StatelessWidget {
  final _problemInfo info;
  final void Function() onFilesSelectTap;
  final void Function(String) onNameChanged;
  const _ProblemCreatorListTile(
      {super.key,
      required this.onFilesSelectTap,
      required this.onNameChanged,
      required this.info});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.picture_as_pdf_rounded),
      title: TextField(
        onSubmitted: onNameChanged,
        decoration: InputDecoration(
          hintText: "Problem name...",
        ),
      ),
      trailing: ElevatedButton(
        child: Text("Choose files"),
        onPressed: onFilesSelectTap,
      ),
    );
  }
}
