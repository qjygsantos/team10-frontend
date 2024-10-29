import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityIdentifySymbolsController extends GetxController {
  TextEditingController controllerSymbol1 = TextEditingController();
  TextEditingController controllerSymbol2 = TextEditingController();
  TextEditingController controllerSymbol3 = TextEditingController();
  TextEditingController controllerSymbol4 = TextEditingController();
  TextEditingController controllerSymbol5 = TextEditingController();

  String correctAnswerPart1 = 'Start';
  String correctAnswerPart2 = 'End';
  String correctAnswerPart3 = 'Start/End';
  String correctAnswerPart4 = 'Start or End';

  String correctAnswer2 = 'Decision';
  String correctAnswer3 = 'Arrow';
  String correctAnswer4 = 'Process';
  String correctAnswer5 = 'Data';

  RxString totalCorrectAnswer = ''.obs;
  RxBool isChecked = false.obs;

  RxString isCorrect1 = ''.obs;
  RxString isCorrect2 = ''.obs;
  RxString isCorrect3 = ''.obs;
  RxString isCorrect4 = ''.obs;
  RxString isCorrect5 = ''.obs;

  checkAnswer() async {
    isChecked.value = false;
    totalCorrectAnswer.value = '';
    isCorrect1.value = '';
    isCorrect2.value = '';
    isCorrect3.value = '';
    isCorrect4.value = '';
    isCorrect5.value = '';

    int correctAnswerCount = 0;
    if (correctAnswerPart1.toLowerCase().toString().trim() ==
            controllerSymbol1.text.toLowerCase().toString().trim() ||
        correctAnswerPart2.toLowerCase().toString().trim() ==
            controllerSymbol1.text.toLowerCase().toString().trim() ||
        correctAnswerPart3.toLowerCase().toString().trim() ==
            controllerSymbol1.text.toLowerCase().toString().trim() ||
        correctAnswerPart4.toLowerCase().toString().trim() ==
            controllerSymbol1.text.toLowerCase().toString().trim()) {
      correctAnswerCount = correctAnswerCount + 1;
      isCorrect1.value = 'Correct';
    } else {
      isCorrect1.value = 'Wrong';
    }
    if (correctAnswer2.toLowerCase().toString().trim() ==
        controllerSymbol2.text.toLowerCase().toString().trim()) {
      correctAnswerCount = correctAnswerCount + 1;
      isCorrect2.value = 'Correct';
    } else {
      isCorrect2.value = 'Wrong';
    }
    if (correctAnswer3.toLowerCase().toString().trim() ==
        controllerSymbol3.text.toLowerCase().toString().trim()) {
      correctAnswerCount = correctAnswerCount + 1;
      isCorrect3.value = 'Correct';
    } else {
      isCorrect3.value = 'Wrong';
    }
    if (correctAnswer4.toLowerCase().toString().trim() ==
        controllerSymbol4.text.toLowerCase().toString().trim()) {
      correctAnswerCount = correctAnswerCount + 1;
      isCorrect4.value = 'Correct';
    } else {
      isCorrect4.value = 'Wrong';
    }
    if (correctAnswer5.toLowerCase().toString().trim() ==
        controllerSymbol5.text.toLowerCase().toString().trim()) {
      correctAnswerCount = correctAnswerCount + 1;
      isCorrect5.value = 'Correct';
    } else {
      isCorrect5.value = 'Wrong';
    }
    totalCorrectAnswer.value = correctAnswerCount.toString();
    isChecked.value = true;
  }

  reset() {
    isChecked.value = false;
    totalCorrectAnswer.value = '';
    isCorrect1.value = '';
    isCorrect2.value = '';
    isCorrect3.value = '';
    isCorrect4.value = '';
    isCorrect5.value = '';
    controllerSymbol1.clear();
    controllerSymbol2.clear();
    controllerSymbol3.clear();
    controllerSymbol4.clear();
    controllerSymbol5.clear();
  }
}
