import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rich_notes_kp/app/routes/app_pages.dart';

import 'app/core/constants/app_constants.dart';
import 'app/data/providers/medical_record_provider.dart';
import 'app/modules/medical_record/widgets/quill/cubit/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SettingsCubit(),
        ),
      ],
      child: GetMaterialApp(
        navigatorKey: appNavigationKey,
        debugShowCheckedModeBanner: false,
        title: "Rich Text Editor",
        initialRoute: AppPages.INITIAL,
        // theme: ThemeData(fontFamily: "SFProDisplay"),
        getPages: AppPages.routes,
      ),
    ),
  );
}
