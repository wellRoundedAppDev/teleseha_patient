import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../general_exports.dart';

void startLoading() {
  SmartDialog.showLoading(
    builder: (BuildContext context) => Image.asset(
      iconBack,
      height: DEVICE_HEIGHT * 0.2,
      width: DEVICE_WIDTH * 0.2,
    ),
    clickMaskDismiss: true,
  );
}

void dismissLoading() {
  SmartDialog.dismiss();
}
