import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quizz_app/app/modules/chatgpt/constants/constants.dart';
import 'package:quizz_app/app/modules/chatgpt/models/models_model.dart';
import 'package:quizz_app/app/modules/chatgpt/widgets/text_widget.dart';

import '../providers/models_provider.dart';

class ModelsDrowDownWidget extends StatefulWidget {
  const ModelsDrowDownWidget({Key? key}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<ModelsDrowDownWidget> {
  String? currenTmodels;
  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    currenTmodels = modelsProvider.getCurrenTmodels;
    return FutureBuilder<List<ModelsModel>>(
        future: modelsProvider.getAllModels(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: TextWidget(label: snapshot.error.toString()),
            );
          }
          return snapshot.data == null || snapshot.data!.isEmpty
              ? const SizedBox.shrink()
              : DropdownButton(
                  dropdownColor: scaffoldBackgroundColor,
                  iconEnabledColor: Colors.black,
                  items: List<DropdownMenuItem<String>>.generate(
                      snapshot.data!.length,
                      (index) => DropdownMenuItem(
                          value: snapshot.data![index].id,
                          child: TextWidget(
                            label: snapshot.data![index].id,
                            fontSize: 14.sp,
                          ))),
                  value: currenTmodels,
                  onChanged: (value) {
                    setState(() {
                      currenTmodels = value.toString();
                    });
                    modelsProvider.setcurrenTmodels(value.toString());
                  });
        });
  }
}
