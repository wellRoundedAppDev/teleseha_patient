import '../../../general_exports.dart';

class ContentDoctors extends StatelessWidget {
  const ContentDoctors({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.045),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomText(
            text: 'general_specialty_doctors'.tr,
            type: CustomTextType.title,
            fontSize: 16,
            color: const Color(AppColors.colorTitle),
          ),
          SizedBox(height: DEVICE_HEIGHT * 0.027),
          SizedBox(
            height: DEVICE_HEIGHT * 0.47,
            child: ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: 10,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    Card(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: DEVICE_HEIGHT * 0.016,
                          horizontal: DEVICE_WIDTH * 0.04,
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadiusGeometry.circular(20),
                                      child: Image.asset(
                                        imageDoctor,
                                        width: DEVICE_WIDTH * 0.2,
                                        height: DEVICE_HEIGHT * 0.095,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: DEVICE_WIDTH * 0.017),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: DEVICE_HEIGHT * 0.01,
                                      ),
                                      child: Column(
                                        children: <Widget>[
                                          CustomText(
                                            text: 'name_doctor'.tr,
                                            type: CustomTextType.title,
                                            fontSize: 13,
                                            color: const Color(
                                              AppColors.colorTitle,
                                            ),
                                          ),
                                          const Text('test'),
                                          const Text('test'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const Text('test'),
                              ],
                            ),
                            // const Divider(
                            //   color: Colors.black,
                            //   thickness: 2,
                            //   indent: 20,
                            //   endIndent: 20,
                            // ),
                            // Row(
                            //   children: <Widget>[
                            //     Container(),
                            //     Row(
                            //       children: <Widget>[
                            //         const Text('data'),
                            //         SvgPicture.asset(
                            //           iconBack,
                            //           width: DEVICE_WIDTH * 0.04,
                            //           height: DEVICE_HEIGHT * 0.02,
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: DEVICE_HEIGHT * 0.027),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
