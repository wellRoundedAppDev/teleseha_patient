import '../../general_exports.dart';

class NotificationsController extends GetxController {
  List notifications = <dynamic>[
    <String, String>{
      'title': 'delay_has_occurred'.tr,
      'text': 'your_readiness'.tr,
      'icon': iconTimeNotficion,
      'time': 'after_hour'.tr,
      'text_btn': 'booking_confirmation'.tr,
    },
    <String, String>{
      'title': 'update_your_recepone'.tr,
      'text': 'your_new_time'.tr,
      'icon': iconRotate,
      'time': 'after_hour'.tr,
      'text_btn': 'booking_confirmation'.tr,
    },
    <String, String>{
      'title': 'update_your_recepone'.tr,
      'text': 'book_again'.tr,
      'icon': iconStar,
      'time': 'after_hour'.tr,
      'text_btn': 'evaluation'.tr,
    },
  ];
}
