import 'package:get/get.dart';

import '../modules/counter/bindings/counter_binding.dart';
import '../modules/counter/views/counter_view.dart';
import '../modules/medical_record/bindings/medical_record_binding.dart';
import '../modules/medical_record/views/medical_record_view.dart';
import '../modules/rich_editor/bindings/rich_editor_binding.dart';
import '../modules/rich_editor/views/rich_editor_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.RICH_EDITOR;

  static final routes = [
    GetPage(
      name: _Paths.RICH_EDITOR,
      page: () => const RichEditorView(),
      binding: RichEditorBinding(),
    ),
    GetPage(
      name: _Paths.COUNTER,
      page: () => const CounterView(),
      binding: CounterBinding(),
    ),
    GetPage(
      name: _Paths.MEDICAL_RECORD,
      page: () => const MedicalRecordView(),
      binding: MedicalRecordBinding(),
    ),
  ];
}
