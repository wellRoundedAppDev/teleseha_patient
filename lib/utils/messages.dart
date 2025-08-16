import '../../general_exports.dart';

enum MessageTypes { basic, success, error, warning, info }

void showMessage({
  String? description,
  String? title,
  MessageTypes? type,
  int? textColor,
  bool withBackground = true,
  int duration = 3,
  Color? messageBackgroundColor,
  bool withIcon = true,
}) {
  final Color fontColor = textColor != null
      ? Color(textColor)
      : type == MessageTypes.success
      ? const Color(0xff287D3C) // success
      : type == MessageTypes.error
      ? const Color(0xffDA1414) // error
      : type == MessageTypes.warning
      ? const Color(0xffB95000) // warning
      : type == MessageTypes.info
      ? const Color(0xff2E5AAC) // info
      : Colors.black; // basic

  final Color backgroundColor =
      messageBackgroundColor ??
      (type == MessageTypes.success
          ? const Color(0xffEDF9F0) // success
          : type == MessageTypes.error
          ? const Color(0xffFEEFEF) // error
          : type == MessageTypes.warning
          ? const Color(0xffFFF4EC) // warning
          : type == MessageTypes.info
          ? const Color(0xffEEF2FA) // info
          : Colors.white.withValues(alpha: 0.8)); // basic

  Get.snackbar(
    '',
    '',
    borderRadius: DEVICE_WIDTH * 0.02,
    margin: EdgeInsets.all(DEVICE_WIDTH * 0.04),
    titleText: title != null
        ? Row(
            children: <Widget>[
              SizedBox(width: DEVICE_WIDTH * 0.04),
              Text(
                title,
                style: Theme.of(
                  Get.context!,
                ).textTheme.bodyMedium!.copyWith(color: fontColor),
              ),
            ],
          )
        : const SizedBox(width: 0, height: 0),
    icon: withIcon
        ? Icon(Icons.info, color: fontColor)
        : const SizedBox(width: 0, height: 0),
    mainButton: TextButton(
      onPressed: null,
      child: GestureDetector(onTap: Get.closeCurrentSnackbar),
    ),
    backgroundColor: backgroundColor,
    duration: Duration(seconds: duration),
  );
}

/// show popup
void showPopUp({Widget? child}) {
  Get.dialog(
    child!,
    barrierDismissible: false,
    barrierColor: Colors.transparent,
  );
}
