import '../../general_exports.dart';

class Doctors extends StatelessWidget {
  const Doctors({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePageContentController>(
      init: HomePageContentController(),
      builder: (HomePageContentController controller) {
        return const Scaffold(
          body: Column(children: <Widget>[Text('test')]),
        );
      },
    );
  }
}
