import '../../general_exports.dart';

class DetailsAboutYouComp extends StatelessWidget {
  DetailsAboutYouComp({
    super.key,
    this.title,
    this.myListCountry,
    this.value,
    this.onChanged,
    this.subTitle,
  });

  String? title;
  // ignore: always_specify_types
  final List<String>? myListCountry;
  String? value;
  void Function(String?)? onChanged;
  String? subTitle;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailsAboutYouController>(
      builder: (DetailsAboutYouController controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CustomText(
              text: title,
              type: CustomTextType.title,
              fontSize: 16,
              color: const Color(AppColors.colorLabel),
            ),
            SizedBox(height: DEVICE_HEIGHT * 0.021),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(AppColors.colorWhite),
                  width: 0.8,
                ),
                borderRadius: BorderRadius.circular(15),
                color: const Color(AppColors.colorWhiteSelectedType),
              ),
              child: DropdownButton<String>(
                value: (myListCountry != null && myListCountry!.contains(value))
                    ? value
                    : null,
                hint: Text(subTitle!),
                underline: const SizedBox(),
                isExpanded: true,
                padding: EdgeInsets.symmetric(
                  horizontal: DEVICE_WIDTH * 0.03,
                  vertical: DEVICE_HEIGHT * 0.011,
                ),
                style: const TextStyle(color: Colors.black, fontSize: 16),
                onChanged: onChanged,
                items: myListCountry
                    ?.map<DropdownMenuItem<String>>(
                      (String itemValue) => DropdownMenuItem<String>(
                        value: itemValue,
                        child: Text(itemValue),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
      },
    );
  }
}
