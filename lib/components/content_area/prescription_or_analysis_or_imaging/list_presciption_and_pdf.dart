import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

import '../../../general_exports.dart';

class ListPresciption extends GetxController {
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
    <String, String>{'title': 'Urea - Creatinine'},
  ];

  Future<void> savedPdf({
    required List<Map<String, String>> data,
    required String fileName,
  }) async {
    final font = await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
    final pw.Font ttf = pw.Font.ttf(font);

    final pw.Document pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: data.map((item) {
                return pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      item['title'] ?? '',
                      style: pw.TextStyle(
                        font: ttf,
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      item['description'] ?? '',
                      style: pw.TextStyle(font: ttf, fontSize: 14),
                    ),
                    pw.SizedBox(height: 10),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );

    final String? path = await getDownloadsPath();
    if (path != null) {
      final File file = File(
        '$path/${fileName}_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      await file.writeAsBytes(await pdf.save());
      Get.snackbar('تم الحفظ', 'تم حفظ ملف PDF بنجاح في ${file.path}');
    } else {
      Get.snackbar(
        'فشل الحفظ',
        'لم يتم الحصول على صلاحيات التخزين',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  Future<String?> getDownloadsPath() async {
    if (Platform.isAndroid) {
      final PermissionStatus status = await Permission.storage.request();
      if (!status.isGranted) {
        return null;
      }

      final Directory directory = Directory('/storage/emulated/0/Downloads');
      if (!(await directory.exists())) {
        await directory.create(recursive: true);
      }
      return directory.path;
    } else if (Platform.isIOS) {
      final Directory directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }

    return null;
  }
}
