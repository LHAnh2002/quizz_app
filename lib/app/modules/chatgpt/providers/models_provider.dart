import 'package:flutter/widgets.dart';
import 'package:quizz_app/app/modules/chatgpt/models/models_model.dart';
import 'package:quizz_app/app/modules/chatgpt/services/api_service.dart';

class ModelsProvider with ChangeNotifier {
  String currenTmodels = "text-davinci-003";

  String get getCurrenTmodels {
    return currenTmodels;
  }

  void setcurrenTmodels(String newModel) {
    currenTmodels = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelsList = [];

  List<ModelsModel> get getModelsList {
    return modelsList;
  }

  Future<List<ModelsModel>> getAllModels() async {
    modelsList = await ApiService.getModels();
    return modelsList;
  }
}
