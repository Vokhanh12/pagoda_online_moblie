import 'package:flutter/foundation.dart';


class ListenerProvider extends ChangeNotifier {
  bool? _isPickChickenInTable = false;
  bool? _isShowQuestion = false;

  int? _ramdomSelect;

  bool? get isPickChickenInTable => _isPickChickenInTable;

  bool? get isShowQuestion => _isShowQuestion;

  int? get ramdomSelect => _ramdomSelect;

  set isPickChickenInTable(bool? value) {
    _isPickChickenInTable = value;
    notifyListeners();
  }

  set isShowQuestion(bool? value){
    _isShowQuestion = value;
    notifyListeners();
  }

  set setRamomSelect(int? value){
    _ramdomSelect = value;
    notifyListeners();
  }

}