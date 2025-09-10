import '../../../general_exports.dart';

class QuestionModel {
  QuestionModel({
    required this.id,
    required this.questionText,
    required this.type,
    this.parentId,
    this.checkboxOptions,
    this.selectedAnswer,
    List<String>? selectedCheckboxAnswers,
  }) : selectedCheckboxAnswers = selectedCheckboxAnswers ?? <String>[];

  final String id;
  final String questionText;
  final String? parentId;
  final QuestionType type;
  final List<String>? checkboxOptions;

  String? selectedAnswer;
  List<String> selectedCheckboxAnswers;
}
