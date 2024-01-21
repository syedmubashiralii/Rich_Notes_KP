import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill_extensions/models/config/shared_configurations.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:get/get.dart';
import 'package:printing/printing.dart';
import 'package:quill_pdf_converter/quill_pdf_converter.dart';
import 'package:quill_html_converter/quill_html_converter.dart';
import 'package:rich_notes_kp/app/core/constants/app_constants.dart';
// import 'package:share_plus/share_plus.dart' show Share;

import '../controllers/add_record_controller.dart';
import '../widgets/quill/my_quill_editor.dart';
import '../widgets/quill/my_quill_toolbar.dart';

class AddNewRecordView extends GetView<AddRecordController> {
  const AddNewRecordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddRecordController addRecordController = Get.find<AddRecordController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Quill'),
        actions: [
          MenuAnchor(
            builder: (context, controller, child) {
              return IconButton(
                onPressed: () {
                  if (controller.isOpen) {
                    controller.close();
                    return;
                  }
                  controller.open();
                },
                icon: const Icon(
                  Icons.more_vert,
                ),
              );
            },
            menuChildren: [
              // MenuItemButton(
              //   onPressed: () {
              //     final html = addRecordController.controller.value.document
              //         .toDelta()
              //         . //.toHtml();
              //         addRecordController
              //         .controller
              //         .value
              //         .document = Document.fromDelta(Document.fromHtml(html));
              //   },
              //   child: const Text('Load with HTML'),
              // ),
              MenuItemButton(
                onPressed: () async {
                  final pdfDocument = pw.Document();
                  final pdfWidgets = await addRecordController
                      .controller.value.document
                      .toDelta()
                      .toPdf();
                  pdfDocument.addPage(
                    pw.MultiPage(
                      maxPages: 200,
                      pageFormat: PdfPageFormat.a4,
                      build: (context) {
                        return pdfWidgets;
                      },
                    ),
                  );
                  await Printing.layoutPdf(
                      onLayout: (format) async => pdfDocument.save());
                },
                child: const Text('Print as PDF'),
              ),
              MenuItemButton(
                onPressed: () async {
                  addRecordController.saveToLocal();
                },
                child: const Text('Save to local'),
              ),
            ],
          ),
          // IconButton(
          //   tooltip: 'Share',
          //   onPressed: () {
          //     final plainText = _controller.document.toPlainText(
          //       FlutterQuillEmbeds.defaultEditorBuilders(),
          //     );
          //     if (plainText.trim().isEmpty) {
          //       ScaffoldMessenger.of(context).showText(
          //         "We can't share empty document, please enter some text first",
          //       );
          //       return;
          //     }
          //     Share.share(plainText);
          //   },
          //   icon: const Icon(Icons.share),
          // ),
          // IconButton(
          //   tooltip: 'Print to log',
          //   onPressed: () {
          //     print(
          //       jsonEncode(_controller.document.toDelta().toJson()),
          //     );
          //     ScaffoldMessenger.of(context).showText(
          //       'The quill delta json has been printed to the log.',
          //     );
          //   },
          //   icon: const Icon(Icons.print),
          // ),
          // const HomeScreenButton(),
        ],
      ),
      body: Obx(
        () => addRecordController.loading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  // if (!_isReadOnly)
                  MyQuillToolbar(
                    // myContext: appNavigationKey.currentState!.context,
                    controller: addRecordController.controller.value,
                    focusNode: addRecordController.editorFocusNode.value,
                  ),
                  Builder(
                    builder: (context) {
                      return Expanded(
                        child: MyQuillEditor(
                          configurations: QuillEditorConfigurations(
                            sharedConfigurations: _sharedConfigurations,
                            controller: addRecordController.controller.value,
                            readOnly: false,
                          ),
                          scrollController:
                              addRecordController.editorScrollController.value,
                          focusNode: addRecordController.editorFocusNode.value,
                        ),
                      );
                    },
                  ),
                ],
              ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(_isReadOnly ? Icons.lock : Icons.edit),
      //   onPressed: () => setState(() => _isReadOnly = !_isReadOnly),
      // ),
    );
  }

  QuillSharedConfigurations get _sharedConfigurations {
    return const QuillSharedConfigurations(
      // locale: Locale('en'),
      extraConfigurations: {
        QuillSharedExtensionsConfigurations.key:
            QuillSharedExtensionsConfigurations(
          assetsPrefix: 'assets', // Defaults to assets
        ),
      },
    );
  }
}
