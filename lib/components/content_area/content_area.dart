import '../../general_exports.dart';

class ContentArea extends StatelessWidget {
  const ContentArea({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangeParamContentAndNextPage>(
      init: ChangeParamContentAndNextPage(),
      builder: (ChangeParamContentAndNextPage controller) {
        return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal:
                  controller.goToComponentHeader.value == 'ProfileDoctor' ||
                      controller.goToComponentHeader.value == 'drSchedule'
                  ? DEVICE_WIDTH * 0
                  : DEVICE_WIDTH * 0.045,
              vertical: controller.goToComponentHeader.value != 'Subspecialty'
                  ? DEVICE_HEIGHT * 0.028
                  : DEVICE_HEIGHT * 0.045,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(40),
              ),
              color: controller.goToComponentHeader.value != 'Symptoms'
                  ? const Color(AppColors.colorBackgroundScreen)
                  : const Color(AppColors.backgroundColorLine),
            ),
            width: DEVICE_WIDTH,
            child: Obx(() {
              return controller.goToComponentHeader.value == 'HomePage'
                  ? ContentHome()
                  : controller.goToComponentHeader.value == 'RecentBookings'
                  ? const RecentBookings()
                  : controller.goToComponentHeader.value == 'Symptoms'
                  ? const ContentSymptoms()
                  : controller.goToComponentHeader.value == 'Doctors'
                  ? const ContentDoctors()
                  : controller.goToComponentHeader.value == 'Reception'
                  ? const ContentReception()
                  : controller.goToComponentHeader.value == 'enterSymptoms'
                  ? SuccessReception(
                      receptionTextStatus: false,
                      textBtn: 'enterSymptoms'.tr,
                      titleSpecializationSelected: 'thanks_booked_success'.tr,
                      onPressed: () {
                        controller.goToComponentHeader.value = 'Symptoms';
                        controller.knowNextPage.value =
                            'comping from success is complete going to doctor and success';
                        controller.update();
                      },
                    )
                  : controller.goToComponentHeader.value == 'successReception'
                  ? SuccessReception(
                      textBtn: 'buy'.tr,
                      titleSpecializationSelected: 'specialization_selected'.tr,
                      textSpecializationSelected:
                          'please_pay_to_show_your_case_specialty'.tr,
                      onPressed: () {
                        controller.goToComponentHeader.value =
                            'KnowledgeOfSpecialty';
                        controller.update();
                      },
                    )
                  : controller.goToComponentHeader.value ==
                        'successSendToDoctor'
                  ? SuccessReception(
                      receptionTextStatus: false,
                      textBtn: 'home_page'.tr,
                      titleSpecializationSelected: 'thanks_booked_success'.tr,
                      textSpecializationSelected: 'please_arrive_on_time'.tr,
                      onPressed: () {
                        // ignore: non_constant_identifier_names
                        final HomePageContentController HomePage = Get.find();
                        final BottomNavController bottomNav = Get.find();

                        // HomePage.checkReservations = true;
                        controller.goToComponentHeader.value = 'HomePage';
                        bottomNav.selectedIndexBottomNav.value = 2;

                        HomePage.update();
                        controller.update();
                      },
                    )
                  : controller.goToComponentHeader.value ==
                        'KnowledgeOfSpecialty'
                  ? const KnowledgeOfSpecialty()
                  : controller.goToComponentHeader.value == 'Subspecialty'
                  ? ContentSubSpecialties()
                  : controller.goToComponentHeader.value == 'drSchedule'
                  ? const DrSchedule()
                  : controller.goToComponentHeader.value == 'waitingForYourTurn'
                  ? WaitingForYourTurn()
                  : controller.goToComponentHeader.value == 'ProfileDoctor'
                  ? const ContentProfileDoctor()
                  : controller.goToComponentHeader.value == 'DoctorEvaluation'
                  ? ContentDoctorEvaluation()
                  : const ContentPrescription();
            }),
          ),
        );
      },
    );
  }
}
