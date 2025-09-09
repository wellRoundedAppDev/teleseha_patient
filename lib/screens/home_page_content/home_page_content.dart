import '../../general_exports.dart';

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();

    return GetBuilder<HomePageContentController>(
      init: HomePageContentController(),
      builder: (HomePageContentController controller) {
        return Scaffold(
          backgroundColor: const Color(AppColors.colorLineAndText),
          body: Obx(
            () => change.goToComponentHeader.value == 'ProfileDoctor'
                ? Stack(
                    children: <Widget>[
                      Positioned(
                        top: 140,
                        right: -50,
                        child: Container(
                          width: 309,
                          height: 304,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[
                                Color(AppColors.colorcircleTop),
                                Color(AppColors.colorLineAndText),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 82,
                        right: 28,
                        child: Image.asset(
                          imageDoctorDetails,
                          width: 300,
                          height: 480,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          const SizedBox(height: 300, child: Header()),
                          SizedBox(height: DEVICE_HEIGHT * 0.03),
                          const ContentArea(),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      const Header(),
                      SizedBox(height: DEVICE_HEIGHT * 0.03),
                      const ContentArea(),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
