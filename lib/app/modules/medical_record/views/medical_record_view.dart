import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';

import 'package:get/get.dart';
import 'package:rich_notes_kp/app/core/helpers/helpers.dart';

import '../../../data/models/medical_record.dart';
import '../controllers/add_record_controller.dart';
import '../controllers/medical_record_controller.dart';
import '../widgets/example_item.dart';
import 'add_new_record_view.dart';

class MedicalRecordView extends GetView<MedicalRecordController> {
  const MedicalRecordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(MedicalRecordController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('MedicalRecordView'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() {
                debugLog(
                    "controller.medicalRecords: ${controller.medicalRecords.value.length}");
                return controller.loading.value
                    ? const Text("Loading data")
                    : showMedicalRecordBuild(controller);
              }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddRecordController addRecordController =
              Get.put(AddRecordController());
          addRecordController.controller.value.document = Document();
          Get.to(() => const AddNewRecordView());
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget showMedicalRecordBuild(controller) {
    return Obx(() {
      // MedicalRecordController controller = Get.find<MedicalRecordController>();
      return controller.medicalRecords.value.isEmpty
          ? HomeScreenExampleItem(
              title: 'Empty',
              icon: const Icon(
                Icons.insert_drive_file,
                size: 50,
              ),
              text: 'Want start clean? be my guest',
              onPressed: () {
                AddRecordController addRecordController =
                    Get.put(AddRecordController());
                addRecordController.controller.value.document = Document();
                Get.to(() => const AddNewRecordView());
              },
              //     Navigator.of(context).pushNamed(
              //   QuillScreen.routeName,
              //   arguments: QuillScreenArgs(
              //     document: Document(),
              //   ),
              // ),
            )
          : ListView.builder(
              shrinkWrap: true,
              itemCount: controller.medicalRecords.value.length,
              itemBuilder: (context, index) {
                MedicalRecord record = controller.medicalRecords.value[index];
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: InkWell(
                      onTap: () {
                        // controller.isEdit

                        AddRecordController addRecordController =
                            Get.put(AddRecordController());

                        addRecordController.getDataFromLocal(record);
                        Get.to(() => const AddNewRecordView());
                      },
                      child: Text("Name: ${record.name}")),
                );
              },
            );
    });
  }
}
