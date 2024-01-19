import 'package:get/get.dart';

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
  ];
}
