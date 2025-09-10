import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class ContentSymptoms extends StatelessWidget {
  const ContentSymptoms({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContentSymptomsController>(
      builder: (ContentSymptomsController controller) {
        final ChangeParamContentAndNextPage change = Get.find();
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: DEVICE_HEIGHT * 0.018),
              Stack(
                children: <Widget>[
                  TextField(
                    textInputAction: TextInputAction.done,
                    controller: controller.filter,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'search_about_symptoms'.tr,
                      hintStyle: const TextStyle(
                        color: Color(AppColors.colorHintText),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: DEVICE_WIDTH * 0.06,
                        vertical: DEVICE_HEIGHT * 0.025,
                      ),
                      filled: true,
                      fillColor: const Color(AppColors.colorWhiteSelectedType),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  // create post request when add symptoms
                  Positioned(
                    left: DEVICE_WIDTH * 0.07,
                    top: 22,
                    child: SvgPicture.asset(
                      iconSearch,
                      width: DEVICE_WIDTH * 0.025,
                      height: DEVICE_HEIGHT * 0.025,
                    ),
                  ),
                ],
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.033),
              CustomText(
                text: 'symptoms'.tr,
                fontSize: 18,
                type: CustomTextType.title,
                color: const Color(AppColors.colorSpecialties),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.023),
              SizedBox(
                height: DEVICE_HEIGHT * 0.33,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.items.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        final bool currentValue =
                            controller.items[index]['isSelected'];
                        controller.changeValueCheck(index, !currentValue);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: DEVICE_HEIGHT * 0.03),
                        padding: EdgeInsets.symmetric(
                          horizontal: DEVICE_WIDTH * 0.03,
                          vertical: DEVICE_HEIGHT * 0.017,
                        ),
                        decoration: BoxDecoration(
                          border: BoxBorder.all(
                            color: const Color(AppColors.colorSymptomsBorder),
                          ),
                          color: const Color(AppColors.colorWhiteSelectedType),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: const Color(
                                0xFFD8DADC,
                              ).withValues(alpha: 0.4),
                              blurRadius: 6,
                              spreadRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: CustomText(
                                text: controller.items[index]['title'],
                                fontSize: 13,
                                type: CustomTextType.title,
                                color: const Color(AppColors.colorSpecialties),
                              ),
                            ),
                            SizedBox(
                              width: DEVICE_WIDTH * 0.05,
                              height: DEVICE_HEIGHT * 0.021,
                              child: Checkbox(
                                value: controller.items[index]['isSelected'],
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    controller.changeValueCheck(index, value);
                                  }
                                },
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                activeColor: const Color(
                                  AppColors.colorLineAndText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: DEVICE_HEIGHT * 0.02),
              Btn(
                onPressed: () {
                  controller.changeParamNextPage();
                },
                style: !controller.isSelectedSymptoms
                    ? ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(83, 0, 123, 189),
                        padding: EdgeInsets.symmetric(
                          vertical: DEVICE_HEIGHT * 0.02,
                        ),
                      )
                    : null,
                text:
                    change.knowNextPage.value ==
                        'comping from success is complete going to doctor and success'
                    ? 'send_about_doctor'.tr
                    : 'selected_specialty'.tr,
              ),
            ],
          ),
        );
      },
    );
  }
}
