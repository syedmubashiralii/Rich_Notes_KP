import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/rich_editor_controller.dart';

class RichEditorView extends GetView<RichEditorController> {
  const RichEditorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RichEditorView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RichEditorView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
