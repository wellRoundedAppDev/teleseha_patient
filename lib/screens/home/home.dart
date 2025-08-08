import '../../general_exports.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Home"),
      // backgroundColor: const Color(AppColors.grey),
      // body: GetBuilder<HomeController>(
      //   init: HomeController(),
      //   builder: (HomeController controller) {
      //     return Text("test");
      //     return ListView.builder(
      //       itemCount: controller.homeData.length,
      //       itemBuilder: (context, index) {
      //         return Text(controller.homeData[index][keyName]);
      //       },
      //     );
      //   },
      // ),
    );
  }
}
