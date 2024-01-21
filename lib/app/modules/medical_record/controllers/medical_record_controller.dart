import 'package:get/get.dart';
import 'package:rich_notes_kp/app/core/helpers/helpers.dart';
import '../../../data/providers/medical_record_provider.dart';
import '/app/data/models/medical_record.dart';

class MedicalRecordController extends GetxController {
  final MedicalRecordProvider medicalRecordProvider =
      Get.put(MedicalRecordProvider(), permanent: true);
  RxList<MedicalRecord> medicalRecords = <MedicalRecord>[].obs;
  final loading = false.obs;

  // getAllRecords() {
  //   loading.value = true;
  //   medicalRecords = medicalRecordProvider.medicalRecords;
  //   loading.value = false;
  // }

  @override
  Future<void> onInit() async {
    print("MedicalRecordController init");
    debugLog(
        "medical record controller medicalRecords: ${medicalRecords.length}");

    // Observe changes in medicalRecords and update local variable
    ever(medicalRecordProvider.medicalRecords, (_) {
      medicalRecords.assignAll(medicalRecordProvider.medicalRecords);
    });
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    medicalRecords = medicalRecordProvider.medicalRecords;
    debugLog("onready medicalRecords: ${medicalRecords.length}");
    // medicalRecords.refresh();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
