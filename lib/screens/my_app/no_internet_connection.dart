import 'dart:ui';
import '../../general_exports.dart';

class NoInternetConnection extends StatelessWidget {
  const NoInternetConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              width: DEVICE_WIDTH * 0.9,
              padding: EdgeInsets.symmetric(
                horizontal: DEVICE_WIDTH * 0.04,
                vertical: DEVICE_HEIGHT * 0.02,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.shade200.withOpacity(0.5),
              ),
              child: Wrap(
                children: <Widget>[
                  SizedBox(width: DEVICE_WIDTH * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'no_internet_connection'.tr,
                        style: Theme.of(context).textTheme.headlineMedium!,
                      ),
                      Text(
                        'waiting_for_network'.tr,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color(AppColors.grey),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
