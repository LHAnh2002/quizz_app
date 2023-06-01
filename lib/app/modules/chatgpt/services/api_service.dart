import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:quizz_app/app/modules/chatgpt/constants/api_consts.dart';
import 'package:quizz_app/app/modules/chatgpt/models/chat_model.dart';
import 'package:quizz_app/app/modules/chatgpt/models/models_model.dart';

class ApiService {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonReponse['error]: ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }
      // print("JsonReponse: $jsonResponse");
      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
        // log("Temp: ${value['id']}");
      }
      return ModelsModel.modelFromSnapshot(temp);
    } catch (error) {
      log("Error: $error");
      rethrow;
    }
  }

  String convertToUtf8(String input) {
    List<int> bytes = input.codeUnits;
    Utf8Decoder decoder = Utf8Decoder();
    String utf8String = decoder.convert(bytes);
    return utf8String;
  }

  static Future<List<ChatModel>> sendMessage(
      {required String message, required String modelID}) async {
    try {
      var response = await http.post(Uri.parse("$BASE_URL/completions"),
          headers: {
            'Authorization': 'Bearer $API_KEY',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "model": modelID,
            "prompt": message,
            "max_tokens": 1000,
          }));

      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        // print("jsonReponse['error]: ${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        for (int index = 0; index < jsonResponse['choices'].length; index++) {
          String text = jsonResponse['choices'][index]['text'];
          List<int> bytes = text.codeUnits;
          Utf8Decoder decoder = Utf8Decoder();
          String utf8String = decoder.convert(bytes);
          log(utf8String);
          chatList.add(
            ChatModel(
              msg: utf8String,
              chatIndex: 1,
            ),
          );
        }
      }
      return chatList;
    } catch (error) {
      log("Error: $error");
      rethrow;
    }
  }
}
