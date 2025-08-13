import '../../general_exports.dart';

class ContentArea extends StatelessWidget {
  const ContentArea({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return Container(
          width: DEVICE_WIDTH,
          color: Colors.white,
          child: const Text('ContentArea'),
        );
      },
    );
  }
}
