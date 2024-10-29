import 'dart:developer';

import 'package:get/get.dart';
import 'package:psykitz/model/symbols_model.dart';

import '../dialogs/activity_arrange_sysmbols_dialog.dart';

class ActivityArrangeSymbolsController extends GetxController {
  RxList<SymbolsModel> symbolsList = <SymbolsModel>[].obs;
  RxString percentage = ''.obs;
  RxDouble percentDouble = 0.0.obs;

  checkAnswer() async {
    int countCorrectAnswer = 0;
    if (symbolsList[0].answer == "Start") {
      countCorrectAnswer = countCorrectAnswer + 1;
      symbolsList[0].isCorrect.value = "Correct";
    } else {
      symbolsList[0].isCorrect.value = "Wrong";
    }
    if (symbolsList[1].answer == "Arrow") {
      countCorrectAnswer = countCorrectAnswer + 1;
      symbolsList[1].isCorrect.value = "Correct";
    } else {
      symbolsList[1].isCorrect.value = "Wrong";
    }
    if (symbolsList[2].answer == "Decision") {
      countCorrectAnswer = countCorrectAnswer + 1;
      symbolsList[2].isCorrect.value = "Correct";
    } else {
      symbolsList[2].isCorrect.value = "Wrong";
    }
    if (symbolsList[3].answer == "Arrow") {
      countCorrectAnswer = countCorrectAnswer + 1;
      symbolsList[3].isCorrect.value = "Correct";
    } else {
      symbolsList[3].isCorrect.value = "Wrong";
    }
    if (symbolsList[4].answer == "Process") {
      countCorrectAnswer = countCorrectAnswer + 1;
      symbolsList[4].isCorrect.value = "Correct";
    } else {
      symbolsList[4].isCorrect.value = "Wrong";
    }
    if (symbolsList[5].answer == "Arrow") {
      countCorrectAnswer = countCorrectAnswer + 1;
      symbolsList[5].isCorrect.value = "Correct";
    } else {
      symbolsList[5].isCorrect.value = "Wrong";
    }
    if (symbolsList[6].answer == "Data") {
      countCorrectAnswer = countCorrectAnswer + 1;
      symbolsList[6].isCorrect.value = "Correct";
    } else {
      symbolsList[6].isCorrect.value = "Wrong";
    }
    if (symbolsList[7].answer == "Arrow") {
      countCorrectAnswer = countCorrectAnswer + 1;
      symbolsList[7].isCorrect.value = "Correct";
    } else {
      symbolsList[7].isCorrect.value = "Wrong";
    }
    if (symbolsList[8].answer == "Start") {
      countCorrectAnswer = countCorrectAnswer + 1;
      symbolsList[8].isCorrect.value = "Correct";
    } else {
      symbolsList[8].isCorrect.value = "Wrong";
    }

    double percentageDouble = (countCorrectAnswer / 9) * 100;
    percentage.value = percentageDouble.toStringAsFixed(0);
    percentDouble.value = percentageDouble;

    log(countCorrectAnswer.toString());
    log("${percentage.value}%");
    ActivityArrangeSymbolsWidget.showResult();
  }

  resetGame() {
    symbolsList.clear();
    percentage.value = '';
    percentDouble.value = 0.0;
  }
}
