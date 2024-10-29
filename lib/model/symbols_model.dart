// To parse this JSON data, do
//
//     final symbolsModel = symbolsModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

List<SymbolsModel> symbolsModelFromJson(String str) => List<SymbolsModel>.from(
    json.decode(str).map((x) => SymbolsModel.fromJson(x)));

String symbolsModelToJson(List<SymbolsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SymbolsModel {
  String assets;
  String answer;
  RxString isCorrect;

  SymbolsModel({
    required this.assets,
    required this.answer,
    required this.isCorrect,
  });

  factory SymbolsModel.fromJson(Map<String, dynamic> json) => SymbolsModel(
        assets: json["assets"],
        answer: json["answer"],
        isCorrect: "".obs,
      );

  Map<String, dynamic> toJson() => {
        "assets": assets,
        "answer": answer,
        "isCorrect": isCorrect,
      };
}
