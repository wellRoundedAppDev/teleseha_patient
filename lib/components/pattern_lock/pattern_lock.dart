import 'package:flutter/gestures.dart';
import 'package:pattern_dots/pattern_dots.dart';

import '../../general_exports.dart';

class PatternLock extends StatelessWidget {
  const PatternLock({super.key});

  // ============================
  // 1️⃣ Publid Size Pattern
  // ============================
  Widget _buildPatternArea({
    required PatternState state,
    required List<int> pattern,
    required VoidCallback onStart,
    required Function(List<int>) onUpdate,
    required Function(List<int>) onEnd,
  }) {
    return PatternStyle(
      data: PatternStyleData(
        tapRange: 24,
        linePaint: (PatternState state) => Paint()
          ..strokeWidth = 2
          ..color = _getLineColor(state)
          ..style = PaintingStyle.stroke,
        dotBuilder: (PatternState state) => _buildDot(state),
        dotPainter: (_, __, ___) {},
      ),
      child: SizedBox(
        width: DEVICE_WIDTH * 0.67,
        height: DEVICE_HEIGHT * 0.24,
        child: PatternView(
          state: state,
          value: pattern,
          onStart: onStart,
          onUpdate: onUpdate,
          onEnd: onEnd,
        ),
      ),
    );
  }

  // ============================
  // 2️⃣ Pulid Step (SignUp)
  // ============================
  Widget _buildStepsPattern(StartStepsController stepsController) {
    return Center(
      child: _buildPatternArea(
        state: stepsController.state,
        pattern: stepsController.inputPattern,
        onStart: stepsController.startPattern,
        onUpdate: stepsController.updatePattern,
        onEnd: (List<int> pattern) {
          stepsController.inputPattern = pattern;
          stepsController.update();
        },
      ),
    );
  }

  // ============================
  // 3️⃣ Get Colors Pointer
  // ============================
  Color _getLineColor(PatternState state) {
    switch (state) {
      case PatternState.normal:
        return const Color(AppColors.colorPointer);
      case PatternState.active:
        return Colors.blue;
      case PatternState.success:
        return const Color(AppColors.colorSuccessLine);
      case PatternState.error:
        return Colors.red;
    }
  }

  Widget _buildDot(PatternState state) {
    Color color;
    switch (state) {
      case PatternState.normal:
        color = const Color(AppColors.colorPointer);
        break;
      case PatternState.active:
        color = Colors.blue;
        break;
      case PatternState.success:
        color = Colors.green;
        break;
      case PatternState.error:
        color = Colors.red;
        break;
    }

    return Container(
      width: DEVICE_WIDTH * 0.04,
      height: DEVICE_HEIGHT * 0.04,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  // ============================
  // 4️⃣ Home build
  // ============================
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (LoginController controller) {
        final bool isSignUp = controller.page == 'signUp';
        final StartStepsController? stepsController = isSignUp
            ? Get.find<StartStepsController>()
            : null;

        return Directionality(
          textDirection: TextDirection.ltr,
          child: controller.page != 'signUp'
              ? _buildSignInOrUpdate(controller)
              : _buildSignUp(stepsController, controller),
        );
      },
    );
  }

  // ============================
  // 5️⃣  signIn or Update
  // ============================
  Widget _buildSignInOrUpdate(LoginController controller) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: DEVICE_HEIGHT * 0.035,
            horizontal: DEVICE_HEIGHT * 0.03,
          ),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: DEVICE_HEIGHT * 0.038,
                  horizontal: DEVICE_HEIGHT * 0.03,
                ),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Logo(),
                ),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.13),
              CustomText(
                text: _getTitleText(controller.page),
                fontSize: 24,
                type: CustomTextType.title,
                color: const Color(AppColors.colorTextBlue),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.13),
              if (controller.isLoading)
                const CircularProgressIndicator()
              else
                _buildPatternArea(
                  state: controller.state,
                  pattern: controller.inputPattern,
                  onStart: controller.startPattern,
                  onUpdate: controller.updatePattern,
                  onEnd: (List<int> pattern) {
                    controller.inputPattern = pattern;
                    if (controller.page == 'signIn') {
                      controller.validatePattern();
                    }
                  },
                ),
              if (controller.page == 'signIn' &&
                  controller.showForgetPatter &&
                  !controller.isLoading)
                _buildForgetPatternText(controller),
              SizedBox(height: DEVICE_HEIGHT * 0.05),
              if (controller.page == 'update' ||
                  controller.page == 'verifyPattern')
                _buildUpdateButtons(controller),
            ],
          ),
        ),
      ),
    );
  }

  String _getTitleText(String? page) {
    if (page == 'signIn') {
      return 'create_input_pattern'.tr;
    }
    if (page == 'update' || page == 'verifyPattern') {
      return 'create_pattern'.tr;
    }
    return '';
  }

  Widget _buildForgetPatternText(LoginController controller) {
    return Text.rich(
      TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: '${'are_you_forget_pass'.tr} ',
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(AppColors.colorInputConfirm),
            ),
          ),
          TextSpan(
            text: 'create_new_pattern'.tr,
            style: const TextStyle(
              fontFamily: 'Cairo',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: Color(AppColors.colorLineAndText),
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                controller.showForgetPatter = false;
                // ignore: always_specify_types
                Future.delayed(const Duration(seconds: 2), () {
                  Get.toNamed(routeLogin);
                  controller.showPage = 'forgetPassword';
                  controller.update();
                });
              },
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateButtons(LoginController controller) {
    return Column(
      children: <Widget>[
        Btn(
          onPressed: () {
            controller.state = PatternState.active;
            controller.createVerificationForExistingUser();
            controller.update();
          },
          text: controller.page == 'update' ? 'next'.tr : 'save'.tr,
        ),
        SizedBox(height: DEVICE_HEIGHT * 0.03),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: const Color(AppColors.colorLineAndText),
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Btn(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(AppColors.colorWhiteSelectedType),
              padding: EdgeInsets.symmetric(vertical: DEVICE_HEIGHT * 0.02),
            ),
            colorText: const Color(AppColors.colorLineAndText),
            onPressed: () {
              controller.inputPattern = <int>[];
              controller.state = PatternState.normal;
              controller.update();
            },
            text: 'again'.tr,
          ),
        ),
      ],
    );
  }

  // ============================
  // 6️⃣ signup
  // ============================
  Widget _buildSignUp(
    StartStepsController? stepsController,
    LoginController controller,
  ) {
    if (controller.isLoading) return const SizedBox.shrink();
    return Column(
      children: <Widget>[
        CustomText(
          text: 'create_pattern'.tr,
          fontSize: 24,
          type: CustomTextType.title,
          color: const Color(AppColors.colorTextBlue),
        ),
        SizedBox(height: DEVICE_HEIGHT * 0.16),
        if (stepsController != null) _buildStepsPattern(stepsController),
      ],
    );
  }
}