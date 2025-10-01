import '../../../general_exports.dart';

class DetailsAboutYouController extends GetxController {
  final TextEditingController jobTitle = TextEditingController();
  bool showjobTitleError = false;
  String jobTitleErrorMessage = '';

  final TextEditingController length = TextEditingController();
  bool showLengthError = false;
  String lengthErrorMessage = '';

  final TextEditingController weight = TextEditingController();
  bool showWeightError = false;
  String weightMessage = '';

  String selectedValue = 'اختر دولتك';
  final List<String> listCountry = <String>[
    'الأردن',
    'فلسطين',
    'مصر',
    'السعودية',
    'الإمارات',
    'قطر',
    'الكويت',
    'البحرين',
    'عُمان',
    'لبنان',
    'سوريا',
    'العراق',
    'اليمن',
    'ليبيا',
    'تونس',
    'الجزائر',
    'المغرب',
    'موريتانيا',
    'السودان',
  ];
  void updateSelectedCountry(String newValue) {
    selectedValue = newValue;
    update();
  }

  String selectedValueGovernorate = 'اختر محافظتك';
  final List<String> listGovernorate = <String>[
    'عمان',
    'نابلس',
    'القاهرة',
    'الرياض',
    'دبي',
    'الدوحة',
    'الكويت',
    'البحرين',
    'صلالة',
    'بيروت',
    'دمشق',
  ];
  void updateSelectedGovernorate(String newValue) {
    selectedValueGovernorate = newValue;
    update();
  }

  String selectedCity = 'اختر محافظتك';
  final List<String> listCity = <String>[
    'عمان',
    'رام الله',
    'القاهرة',
    'الرياض',
    'دبي',
    'الدوحة',
    'الكويت',
    'المنامة',
  ];
  void updateSelectedCity(String newValue) {
    selectedCity = newValue;
    update();
  }

  String maritalStatus = 'اختر محافظتك';
  final List<String> listsMaritalStatus = <String>['اعزب', 'متزوج'];
  void updateSelectedMaritalStatus(String newValue) {
    maritalStatus = newValue;
    update();
  }
}
