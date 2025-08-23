import '../../general_exports.dart';

class DoctorsController extends GetxController {
  TextEditingController filterDoctors = TextEditingController();
  bool showDoctors = false;

  // create request passed index and response but dont force patams
  int? passedIndex = 0;
}
