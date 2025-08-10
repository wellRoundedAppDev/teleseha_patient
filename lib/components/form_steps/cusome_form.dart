import '../../general_exports.dart';

class CusomeForm extends StatelessWidget {
  const CusomeForm({
    required super.key,
    required this.title,
    required this.hintText,
    required this.controller,
    required this.isVaild,
    required this.textIsVaild,
  });

  final String? title;
  final String? hintText;
  final TextEditingController? controller;
  final bool isVaild;
  final String? textIsVaild;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title ?? '',
          style: TextStyle(
            color: Color(AppColors.colorLabel),
            fontWeight: FontWeight.w400,
            fontFamily: 'Cairo',
            fontSize: 16,
          ),
        ),
        SizedBox(height: DEVICE_HEIGHT * 0.02),
        Container(
          width: DEVICE_WIDTH * 0.85,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Color(AppColors.colorWhite)),
          ),
          child: TextFormField(
            keyboardType: TextInputType.text,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              hintText: hintText ?? '',
              hintStyle: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(AppColors.colorHintText).withValues(alpha: 20),
              ),
            ),
          ),
        ),
        SizedBox(height: DEVICE_HEIGHT * 0.01),
        (isVaild ?? false)
            ? Text(
                textIsVaild!,
                style: TextStyle(
                  color: Color(AppColors.colorError),
                  fontSize: 16,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.w700,
                ),
              )
            : Text(''),
      ],
    );
  }
}
