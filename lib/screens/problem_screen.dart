import 'dart:io';
import 'dart:math';

import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:photo_view/photo_view.dart';
import 'package:qed/firebase/qedstore.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../problem.dart';
import '../redux/app_state.dart';

class ProblemScreen extends StatefulWidget {
  Problem problem;
  final bool canSubmit;
  ProblemScreen({required this.problem, super.key, required this.canSubmit});

  @override
  State<ProblemScreen> createState() => _ProblemScreenState();
}

class _ProblemScreenState extends State<ProblemScreen> {
  List<PlatformFile> uploadedFiles = [];

  Future<void> uploadSolution() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['pdf', 'jpg', 'png']);
    if (result != null) {
      uploadedFiles.add(result.files.first);
    }
    setState(() {});
  }

  PDFDocument? doc;
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  void submitSolutions(String uid) async {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Uploading...")));
    await QEDStore.instance
        .uploadSolution(uploadedFiles, widget.problem.id.toString(), uid);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Uploaded!")));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // PDFDocument.fromURL('http://www.africau.edu/images/default/sample.pdf')
    //     .then((value) => doc = value);
  }

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var initHeight = 400;

    return Builder(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.problem.name),
          actions: [
            StoreBuilder<AppState>(
                builder: (context, vm) => IconButton(
                    onPressed: () =>
                        submitSolutions(vm.state.currentUser!.firebaseUser.uid),
                    icon: Icon(Icons.send)))
          ],
        ),
        body: Column(
          children: [
            // doc != null ? PDFViewer(document: doc!) : Container(),
            Flexible(
                flex: 1,
                child: widget.problem.statementLink!.isPDF
                    ? SfPdfViewer.network(
                        widget.problem.statementLink!.url,
                        key: _pdfViewerKey,
                      )
                    : PhotoView(
                        imageProvider:
                            NetworkImage(widget.problem.statementLink!.url))),
            screenheight > initHeight + 83 && widget.canSubmit
                ? Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: uploadSolution,
                          child: Text("Upload"),
                        ),
                        ...uploadedFiles.map(
                          (f) => ListTile(
                            title: Text(f.path!
                                .substring(f.path!.lastIndexOf('/') + 1)),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      );
    });
  }
}
