import 'package:get/get.dart';

import 'package:rich_notes_kp/app/modules/medical_record/controllers/add_record_controller.dart';

import '../../../data/providers/medical_record_provider.dart';
import '../controllers/medical_record_controller.dart';

class MedicalRecordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddRecordController>(
      () => AddRecordController(),
    );
    Get.lazyPut<MedicalRecordController>(
      () {
        return MedicalRecordController();
      },
    );
  }
}
