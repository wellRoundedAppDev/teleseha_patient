import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../../../general_exports.dart';

class ListPresciption extends GetxController {
  final GlobalKey previewContainer = GlobalKey();
  // RxString ChangeContent = 'The prescription'.obs;

  final List<Map<String, String>> prescriptionList = <Map<String, String>>[
    <String, String>{
      'title': 'Radiological Examination Request',
      'description': '٤٠ مجم مرة يوميًا قبل الأكل',
    },
    <String, String>{
      'title': 'Radiological Examination Request',
      'description': '٣٠ مجم مرتين يوميًا بعد الأكل',
    },
    <String, String>{
      'title': 'Radiological Examination Request',
      'description': '٢٥ مجم عند الحاجة فقط',
    },
    <String, String>{
      'title': 'Radiological Examination Request',
      'description': '٥٠ مجم كل ٨ ساعات',
    },
    <String, String>{
      'title': 'Radiological Examination Request',
      'description': '١٠٠ مجم مرة واحدة في اليوم',
    },
  ];

  final List<Map<String, String>> radiologyList = <Map<String, String>>[
    <String, String>{
      'title': 'Doppler Ultrasound',
      'description': '(Doppler Ultrasound',
    },
    <String, String>{
      'title': 'Doppler Ultrasound',
      'description': '(Doppler Ultrasound',
    },
  ];

  final List<Map<String, String>> analysesList = <Map<String, String>>[
    <String, String>{'title': 'Urea - Creatinine'},
    <String, String>{
      'title': 'Urea - Creatinine',
    },
  ];

  Future<Uint8List?> capturePng(GlobalKey key) async {
    try {
      final RenderRepaintBoundary boundary =
          key.currentContext!.findRenderObject() as RenderRepaintBoundary;
      final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      final ByteData? byteData = await image.toByteData(
        format: ui.ImageByteFormat.png,
      );
      return byteData?.buffer.asUint8List();
    } catch (e) {}
    return null;
  }

  Future<void> savedPdf() async {
    final Uint8List? imageBytes = await capturePng(previewContainer);
    if (imageBytes == null) {
      return;
    }
    final pw.Document pdf = pw.Document();
    final pw.MemoryImage image = pw.MemoryImage(imageBytes);
    pdf.addPage(
      pw.Page(build: (pw.Context context) => pw.Center(child: pw.Image(image))),
    );
    final String? path = await getDownloadsPath();
    if (path != null) {
      final File file = File(
        '$path/prescription_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await file.writeAsBytes(await pdf.save());
      Get.snackbar('success_pattern'.tr, '${'pdf_saved'.tr} ${file.path}');
    }
  }

  Future<String?> getDownloadsPath() async {
    if (Platform.isAndroid) {
      final PermissionStatus status = await Permission.storage.request();
      if (!status.isGranted) {
        print('❌ Storage permission denied');
        return null;
      }

      final Directory directory = Directory('/storage/emulated/0/Download');
      if (!(await directory.exists())) {
        await directory.create(recursive: true);
      }
      return directory.path;
    }

    return null;
  }
}
