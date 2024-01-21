import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import 'package:rich_notes_kp/app/core/helpers/helpers.dart';
import 'package:rich_notes_kp/app/data/models/medical_record.dart';

import '../../../controllers/encryptor_controller/encryptor_controller.dart';
import '../../../data/providers/medical_record_provider.dart';
import 'medical_record_controller.dart';

class AddRecordController extends GetxController {
  final controller = QuillController.basic().obs;
  MedicalRecord? medicalRecord;
  late final EncryptorController encryptorController;
  late final MedicalRecordProvider medicalRecordProvider =
      Get.find<MedicalRecordProvider>();

  late final MedicalRecordController medicalRecordController =
      Get.find<MedicalRecordController>();
  final editorFocusNode = FocusNode().obs;
  final editorScrollController = ScrollController().obs;
  Rx<bool> loading = false.obs;

  saveToLocal() async {
    try {
      loading.value = true;

      //   encrypt, save meta data in local db and show meta data on home
      String fileName = DateTime.now().toString();
      String dataInJson =
          jsonEncode(controller.value.document.toDelta().toJson());

      String encryptedFilePath =
          await encryptorController.encryptSalsa(dataInJson, fileName);
      debugLog("encryptedFilePath: ${encryptedFilePath}");

      if (medicalRecord != null) {
        await deleteFileFromDirectory(medicalRecord!.path!);
        medicalRecord!.path = encryptedFilePath;
      } else {
        medicalRecord = MedicalRecord(
            createdOn: DateTime.now().millisecondsSinceEpoch,
            description: "Test file on ${DateTime.now()}",
            // extension:
            name: fileName,
            path: encryptedFilePath);
        debugLog(
            "before length: ${medicalRecordController.medicalRecords.length}");
      }

      medicalRecordController.medicalRecords.value.add(medicalRecord!);
      debugLog(
          "after length: ${medicalRecordController.medicalRecords.length}");

      loading.value = false;
    } catch (e) {
      loading.value = false;
      // handle exception here
      debugLog("Exception occur: $e");
    }
  }

  getDataFromLocal(MedicalRecord record) async {
    try {
      loading.value = true;
      String fileData = await encryptorController.decryptSalsa(record.path!);
      debugLog("decryptedFilePath: $fileData");
      medicalRecord = record;
      // isEdit.value = true;
      controller.value.document = Document.fromJson(jsonDecode(fileData));

      loading.value = false;
    } catch (e) {
      loading.value = false;
      // handle exception here
      // Get.off(page);
      debugLog("Exception occur: $e");
    }
  }

  deleteFileFromDirectory(filePath) async {
    try {
      // Check if the file exists before attempting to delete
      if (await File(filePath).exists()) {
        // Delete the file
        await File(filePath).delete();
        debugLog('File deleted successfully: $filePath');
      } else {
        debugLog('File does not exist: $filePath');
      }
    } catch (e) {
      debugLog('Error deleting file: $e');
    }
  }

  @override
  void onInit() {
    print("init called");
    super.onInit();
  }

  @override
  void onReady() {
    // Get.lazyPut(() => EncryptorController());

    encryptorController = Get.find<EncryptorController>();

    super.onReady();
  }

  @override
  void onClose() {
    controller.value.dispose();
    editorFocusNode.value.dispose();
    editorScrollController.value.dispose();
    super.onClose();
  }
}
