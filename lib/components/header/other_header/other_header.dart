import 'package:flutter_svg/flutter_svg.dart';

import '../../../general_exports.dart';

class OtherHeader extends StatelessWidget {
  const OtherHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangeParamContentAndNextPage change = Get.find();
    return Container(
      width: DEVICE_WIDTH,
      padding: EdgeInsets.symmetric(horizontal: DEVICE_WIDTH * 0.07),
      margin: EdgeInsets.only(top: DEVICE_HEIGHT * 0.09),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              switch (change.goToComponentHeader.value) {
                case 'waitingForYourTurn':
                  change.goToComponentHeader.value = 'RecentBookings';
                  break;
                case 'drSchedule':
                  change.goToComponentHeader.value = 'Doctors';
                  break;
                case 'DoctorEvaluation':
                  change.goToComponentHeader.value = 'waitingForYourTurn';
                  break;
                case 'ContentPrescription':
                  change.goToComponentHeader.value = 'DoctorEvaluation';
                  break;
                case 'Subspecialty':
                  final HomePageContentController homePage = Get.find();
                  homePage.specialityRequest();
                  change.goToComponentHeader.value = 'HomePage';
                  break;
                case 'successReception':
                  change.goToComponentHeader.value = 'Symptoms';
                  break;
                default:
                  change.goToComponentHeader.value = 'HomePage';
              }

              change.update();
            },
            child: Row(
              children: <Widget>[
                SvgPicture.asset(
                  iconBack,
                  width: DEVICE_WIDTH * 0.034,
                  height: DEVICE_HEIGHT * 0.034,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: DEVICE_WIDTH * 0.22),
                const LogoHome(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
