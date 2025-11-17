import '../../../general_exports.dart';

class Policiesandprocedurescontroller extends GetxController {
  // ignore: always_specify_types
  final List<Map<String, dynamic>> listFirstSubject = [
    <String, dynamic>{
      'title': 'first_session_policies'.tr,
      'subTitle': 'first_session_text_policies'.tr,
      'list': <Map<String, String>>[
        <String, String>{
          'first_session_list_title_one_policies'.tr:
              'first_session_list_one_policies'.tr,
        },
        <String, String>{
          'first_session_list_title_two_policies'.tr:
              'first_session_list_two_policies'.tr,
        },
        <String, String>{
          'first_session_list_title_three_policies'.tr:
              'first_session_list_three_policies'.tr,
        },
      ],
    },
    <String, dynamic>{
      'title': 'second_session_policies'.tr,
      'list': <Map<String, String>>[
        <String, String>{
          'second_session_list_title_one_policies'.tr:
              'second_session_list_one_policies'.tr,
        },
        <String, String>{
          'second_session_list_title_two_policies'.tr: 'second_session_list_two_policies'.tr,
        },
        <String, String>{
          'second_session_list_title_three_policies'.tr: 'second_session_list_three_policies'.tr,
        },
      ],
    },
    <String, dynamic>{
      'title': 'thireed_session_policies'.tr,
      'list': <Map<String, String>>[
        <String, String>{
          'thireed_session_list_title_one_policies'.tr: 'thireed_session_list_one_policies'.tr,
        },
      ],
    },
  ];
}
