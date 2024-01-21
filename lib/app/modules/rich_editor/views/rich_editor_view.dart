import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rich_notes_kp/app/routes/app_pages.dart';

import '../../../controllers/encryptor_controller/encryptor_controller.dart';
import '../../../data/providers/medical_record_provider.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'RichEditorView is working',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.toNamed(Routes.MEDICAL_RECORD); // Navigate to EncrypterView
              },
              child: Text('Go to EncrypterView'),
            ),
          ],
        ),
      ),
    );
  }
}
