import 'package:flutter/foundation.dart' as foundation;
import 'package:get/get.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:archive/archive.dart';
import 'package:encrypt/encrypt.dart';
import 'package:path/path.dart' as p;
import 'package:rich_notes_kp/app/core/helpers/helpers.dart';
import '../../core/constants/app_constants.dart';
import 'base_cryptor.dart';
import 'package:path_provider/path_provider.dart';

part 'file_cryptor.dart';

// Initialize encryption controller as user successfully logged in
class EncryptorController extends GetxController {
  String? temporaryDirectoryPath;

  // Modify below object according to need
  late _FileCryptor _fileCryptor;

  final count = 0.obs;

  void increment() => count.value++;

  void decrement() {
    if (count.value > 0) {
      count.value--;
    }
  }

  @override
  void onInit() {
    checkPathExist();
    initializeEncryptorInstance(userPassword);
    super.onInit();
  }

  initializeEncryptorInstance(String secureKey) {
    String key = create16DigitKey(secureKey);
    // Initialize _fileCryptor value
    _fileCryptor = _FileCryptor(
      key: key, //"qwertyuiop@#%^&*()_+1234567890,;",
      iv: 8,
      dir: "richTestFiles",
      // useCompress: true,
    );
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  inputPermission() async {
    PermissionStatus status = await Permission.storage.status;
    debugLog("status: $status");
    if (status.isDenied) {
      PermissionStatus pStatus = await Permission.storage.request();
      debugLog("pStatus: $pStatus");
    }
  }

  Future<String> encryptSalsa(String dataInString, fileName) async {
    await inputPermission();

    debugLog("start encryption: ${DateTime.now()}");
    // setState(() {
    //   encrypting = true;
    // });
    try {
      // debugLog("inputFile: pickedFile?.path,: ${pickedFile?.path}");
      // File pickedFile = File("p.join(dir, inputFile)");
      // File appDocumentsDir = File("");
      File outputDirectory = File("${temporaryDirectoryPath}/encryptedData");

      File encryptedFile = await _fileCryptor.encryptSalsa20(
        // inputFile: pickedFile?.path,
        dataInStringForm: dataInString,
        outputFile: "${outputDirectory.path}/${fileName}.aes",
      );
      debugLog(encryptedFile.absolute);
      debugLog("end encryption: ${DateTime.now()}");
      return encryptedFile.path;
      // setState(() {
      //   encryptedPath = encryptedFile.absolute.toString();
      //   encrypting = false;
      // });
    } catch (e) {
      debugLog("exception: $e");
      throw "Error in encryption: $e";
      // setState(() {
      //   encryptedPath = "exception: $e";
      //   encrypting = false;
      // });
    }
  }

  Future<String> decryptSalsa(String filePath) async {
    debugLog("start decryption: ${DateTime.now()}");

    // setState(() {
    //   decrypting = true;
    // });

    File appDocumentsDir = File("");
    File outputDirectory = File("");

    try {
      String decryptedFileContent = await _fileCryptor.decryptSalsa20(
        inputFile: filePath, // "${appDocumentsDir.path}/${fileName}.aes",
        // outputFile: "${outputDirectory.path}/${fileName}",
      );

      debugLog(decryptedFileContent);
      debugLog("end decryption: ${DateTime.now()}");
      return decryptedFileContent;
      // setState(() {
      //   decryptedPath = decryptedFile.absolute.toString();
      //   decrypting = false;
      // });
    } catch (e) {
      debugLog("exception: $e");
      throw "Error in encryption: $e";
      // setState(() {
      //   decryptedPath = "exception: $e";
      //   decrypting = false;
      // });
    }
  }

  checkPathExist() async {
    if (temporaryDirectoryPath == null) {
      debugLog("not exist");
      await getPath();
    } else {
      debugLog("yes exist: ${temporaryDirectoryPath}");
    }
  }

  getPath() async {
    Directory pathDirectory = await getApplicationDocumentsDirectory();
    debugLog("appDocumentsDir: $pathDirectory");
    temporaryDirectoryPath = pathDirectory.path;
  }

  String create16DigitKey(String userPassword) {
    String mergedString = userPassword + userPassword;
    while (true) {
      if (mergedString.length < 16) {
        mergedString = mergedString + userPassword;
      } else {
        break;
      }
    }

    return mergedString.substring(0, 16);
  }

  generateKeys() {
    String userPassword = 'u!@er1234';

    debugLog('Derived Key: ${create16DigitKey(userPassword)}');
  }

  debugLog(Object object) {
    if (foundation.kDebugMode) {
      print(object);
    }
  }
}
