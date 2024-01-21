import 'package:get/get.dart';

import '../../../controllers/encryptor_controller/encryptor_controller.dart';
import '../../../data/providers/medical_record_provider.dart';
import '../controllers/rich_editor_controller.dart';

class RichEditorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RichEditorController>(
      () => RichEditorController(),
    );

    // Get.lazyPut<MedicalRecordProvider>(() => MedicalRecordProvider());
    // Initializing encryption controller because in my case this is first screen
    // You have to initialize whenever new screen opens after user's login

    // Get.lazyPut<EncryptorController>(() => EncryptorController());

    // Get.put(MedicalRecordProvider());

    Get.put(EncryptorController());
  }
}
