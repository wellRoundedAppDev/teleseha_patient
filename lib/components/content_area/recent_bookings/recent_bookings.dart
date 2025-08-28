import '../../../general_exports.dart';

class RecentBookings extends StatelessWidget {
  const RecentBookings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomText(
            text: 'Recent_bookings'.tr,
            fontSize: 18,
            type: CustomTextType.title,
            color: const Color(AppColors.colorLineAndText),
          ),
          SizedBox(
            height: 200,
            child: ListView(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: const Color(0xFFD8DADC).withValues(alpha: 0.4),
                        blurRadius: 6,
                        spreadRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                    color: const Color(AppColors.colorLastReception),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text('test'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
