import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:qed/custom_widgets/mydrawer.dart';
import 'package:qed/firebase/qedstore.dart';

import '../probleminfo.dart';

class CreateContestScreen extends StatefulWidget {
  const CreateContestScreen({super.key});

  @override
  State<CreateContestScreen> createState() => _CreateContestScreenState();
}

class _CreateContestScreenState extends State<CreateContestScreen> {
  List<problemInfo> problemInfos = [];
  List<TextEditingController> problemControllers = [];
  TextEditingController contestTitle = TextEditingController();
  DateTime? timeStart;
  DateTime? timeEnd;

  @override
  void dispose() {
    contestTitle.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () async {
                  timeStart = await DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    onConfirm: (date) {
                      print('confirm $date');
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.en,
                  );
                  setState(() {});
                },
                child: Text("${timeStart ?? "Start Time"}"),
              ),
              TextButton(
                onPressed: () async {
                  timeEnd = await DatePicker.showDatePicker(
                    context,
                    showTitleActions: true,
                    onConfirm: (date) {
                      print('confirm $date');
                    },
                    currentTime: DateTime.now(),
                    locale: LocaleType.en,
                  );
                  setState(() {});
                },
                child: Text("${timeEnd ?? "End Time"}"),
              ),
            ],
          ),
          ...List.generate(
              problemInfos.length,
              (index) => _ProblemCreatorListTile(
                  controller: problemControllers[index],
                  onDeletedTap: () => setState(() {
                        print("here $index");
                        problemControllers[index].dispose();
                        problemControllers.removeAt(index);
                        problemInfos.removeAt(index);
                      }),
                  onStatementSelectTap: () async {
                    var value = await FilePicker.platform.pickFiles(
                        type: FileType.custom, allowedExtensions: ['pdf']);
                    if (value != null) {
                      setState(() {
                        problemInfos[index].statement = value.files.first;
                      });
                    }
                  },
                  onSolutionSelectTap: () async {
                    var value = await FilePicker.platform.pickFiles(
                        type: FileType.custom, allowedExtensions: ['pdf']);
                    if (value != null) {
                      setState(() {
                        problemInfos[index].solution = value.files.first;
                      });
                    }
                  },
                  info: problemInfos[index])).toList(),

          ///Controlerul baii baiii
          ListTile(
            leading: IconButton(
              onPressed: () => setState(() {
                FocusManager.instance.primaryFocus?.unfocus();
                problemControllers.add(TextEditingController());
                problemInfos.add(problemInfo());
              }),
              icon: Icon(Icons.add_box_outlined),
            ),
            title: Text("Add problem"),
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
            onPressed: () async {
              for (int index = 0; index < problemControllers.length; index++) {
                problemInfos[index].name = problemControllers[index].text;
              }
              await QEDStore.instance.createContest(
                contestTitle.text,
                problemInfos,
                Timestamp.fromDate(timeStart!),
                Timestamp.fromDate(timeEnd!),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ProblemCreatorListTile extends StatefulWidget {
  final problemInfo info;
  final void Function() onStatementSelectTap;
  final void Function() onSolutionSelectTap;
  final void Function() onDeletedTap;
  final TextEditingController controller;

  _ProblemCreatorListTile({
    super.key,
    required this.onSolutionSelectTap,
    required this.info,
    required this.onStatementSelectTap,
    required this.onDeletedTap,
    required this.controller,
  });

  @override
  State<_ProblemCreatorListTile> createState() =>
      _ProblemCreatorListTileState();
}

class _ProblemCreatorListTileState extends State<_ProblemCreatorListTile> {
  @override
  dispose() {
    //controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //FocusScope.of(context).requestFocus();
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.remove_circle_outline),
              ),
              onLongPress: widget.onDeletedTap,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                //autofocus: true,
                controller: widget.controller,
                //textInputAction: TextInputAction.next,
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
                  child: Text(widget.info.statement == null
                      ? "Choose statement"
                      : widget.info.statement!.name),
                  onPressed: widget.onStatementSelectTap,
                ),
                ElevatedButton(
                  child: Text(widget.info.solution == null
                      ? "Choose solution"
                      : widget.info.solution!.name),
                  onPressed: widget.onSolutionSelectTap,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
