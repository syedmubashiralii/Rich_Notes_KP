import 'package:get/get.dart';
import 'package:rich_notes_kp/app/core/helpers/helpers.dart';
import '/app/data/models/models.dart';

class MedicalRecordProvider extends GetxController {
  RxList<MedicalRecord> medicalRecords = <MedicalRecord>[].obs;

  // @override
  // void onInit() {
  //   print("inside MedicalRecordProvider init");
  //   httpClient.baseUrl = 'YOUR-API-URL';
  // }

  Future<RxList<MedicalRecord>> getAllRecords() async {
    debugLog(
        "in MedicalRecordProvider getAllRecords: ${medicalRecords.length}");
    return medicalRecords;
  }
}
