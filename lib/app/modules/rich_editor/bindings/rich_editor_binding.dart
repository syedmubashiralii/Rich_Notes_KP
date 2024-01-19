import 'package:get/get.dart';

import '../controllers/rich_editor_controller.dart';

class RichEditorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RichEditorController>(
      () => RichEditorController(),
    );
  }
}
