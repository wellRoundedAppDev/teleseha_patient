import '../../general_exports.dart';

class More extends StatelessWidget {
  const More({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MoreController>(
      init: MoreController(),
      builder: (MoreController controller) {
        return Padding(
          padding: EdgeInsets.only(
            top: DEVICE_HEIGHT * 0.06,
            left: DEVICE_WIDTH * 0.04,
            right: DEVICE_WIDTH * 0.04,
          ),
          child: Column(
            children: <Widget>[
              ListView.builder(
                shrinkWrap: true,
                itemCount: controller.moreOptions!.length,
                itemBuilder: (BuildContext context, int index) {
                  final dynamic item = controller.moreOptions![index];
                  return GestureDetector(
                    onTap: () {
                      item[name].call();
                    },
                    child: Visibility(
                      visible:
                          !item[name] ||
                          Get.find<MyAppController>().userData != null,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  SizedBox(width: DEVICE_WIDTH * 0.03),
                                  Text(
                                    item[name],
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          fontFamily: getFont(),
                                          color: Color(item[name]),
                                          fontSize: 16,
                                        ),
                                  ),
                                ],
                              ),
                              if (index == 4)
                                Row(
                                  children: <Widget>[
                                    Text(
                                      Get.find<MyAppController>().appLocale ==
                                              'ar'
                                          ? 'العربية'
                                          : 'English',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontFamily: getFont(),
                                            color: Color(item[name]),
                                            fontSize: 16,
                                          ),
                                    ),
                                    SizedBox(width: DEVICE_WIDTH * 0.04),
                                  ],
                                ),
                            ],
                          ),
                          SizedBox(height: DEVICE_HEIGHT * 0.02),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
