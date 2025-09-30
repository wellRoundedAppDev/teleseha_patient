import '../../../general_exports.dart';

class MedicalHistoryController extends GetxController {
  int currentStep = 1;
  int get numberOfStep => 8;

  final List<QuestionModel> questions = <QuestionModel>[
    QuestionModel(
      id: 'chronic',
      questionText: 'هل لديك أمراض مزمنة سابقة أو حالية؟',
      type: QuestionType.radio,
    ),
    QuestionModel(
      id: 'heart',
      questionText: 'هل لديك أمراض قلب وأوعية دموية؟',
      parentId: 'chronic',
      type: QuestionType.radio,
    ),
    QuestionModel(
      id: 'heart_sub',
      questionText: 'حدد نوع المرض القلبي:',
      parentId: 'heart',
      type: QuestionType.checkboxList,
      checkboxOptions: <String>[
        'ارتفاع ضغط الدم',
        'انخفاض ضغط الدم',
        '  مرض الشريان التاجي',
        '  ذبحة صدرية',
        '  جلطة قلبية',
        '  عدم انتظام ضربات القلب',
        '  فشل القلب الاحتقاني',
        '  أمراض صمامات القلب',
        '  تضخم القلب',
        '  دوالي الساقين',
      ],
    ),
    QuestionModel(
      id: 'respiratory',
      questionText: 'هل لديك أمراض تنفسية؟',
      parentId: 'chronic',
      type: QuestionType.radio,
    ),
    QuestionModel(
      id: 'respiratory_sub',
      questionText: 'حدد نوع المرض التنفسي:',
      parentId: 'respiratory',
      type: QuestionType.checkboxList,
      checkboxOptions: <String>[
        'الربو',
        'الالتهاب الرئوي المزمن (COPD)',
        'التليف الرئوي',
        'انقطاع النفس النومي',
        'مرض السل',
        'الالتهاب الشعبي المزمن',
      ],
    ),

    QuestionModel(
      id: 'kidney',
      questionText: 'هل لديك أمراض الكلى؟',
      parentId: 'chronic',
      type: QuestionType.radio,
    ),
    QuestionModel(
      id: 'kidney_sub',
      questionText: 'حدد نوع مرض الكلى:',
      parentId: 'kidney',
      type: QuestionType.checkboxList,
      checkboxOptions: <String>[
        'الفشل الكلوي المزمن',
        'التهاب الكلى',
        'حصى الكلى',
        'المتلازمة الكلوية',
        'التهاب المسالك البولية المتكرر',
      ],
    ),
  ];

  void selectRadioAnswer(String questionId, String answer) {
    final int index = questions.indexWhere(
      (QuestionModel q) => q.id == questionId,
    );
    if (index != -1) {
      questions[index].selectedAnswer = answer;

      if (answer == 'no') {
        _clearChildrenAnswers(questionId);
      }

      update();
    }
  }

  void toggleCheckboxAnswer(String questionId, String option) {
    final int index = questions.indexWhere(
      (QuestionModel q) => q.id == questionId,
    );
    if (index != -1) {
      final QuestionModel q = questions[index];
      if (q.selectedCheckboxAnswers.contains(option)) {
        q.selectedCheckboxAnswers.remove(option);
      } else {
        q.selectedCheckboxAnswers.add(option);
      }
      update();
    }
  }

  void _clearChildrenAnswers(String parentId) {
    for (final QuestionModel q in questions) {
      if (q.parentId == parentId) {
        q.selectedAnswer = null;
        q.selectedCheckboxAnswers.clear();
        _clearChildrenAnswers(q.id);
      }
    }
  }

  List<QuestionModel> get visibleQuestions {
    return questions.where((QuestionModel q) {
      if (q.parentId == null) {
        return true;
      }
      final QuestionModel parent = questions.firstWhere(
        (QuestionModel p) => p.id == q.parentId,
      );
      return parent.selectedAnswer == 'yes';
    }).toList();
  }

  bool get hasAnyAnswer {
    return visibleQuestions.any((QuestionModel q) {
      if (q.type == QuestionType.radio) {
        return q.selectedAnswer?.isNotEmpty == true;
      } else if (q.type == QuestionType.checkboxList) {
        return q.selectedCheckboxAnswers.isNotEmpty;
      }
      return false;
    });
  }

  void goToNextStep() {
    currentStep++;
    update();
  }
}
