import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rich_notes_kp/app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Rich Text Editor",
      initialRoute: AppPages.INITIAL,
      // theme: ThemeData(fontFamily: "SFProDisplay"),
      getPages: AppPages.routes,
    ),
  );
}
