import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:quizz_app/app/modules/allQuestions/view/word/all_questions_word.dart';
import 'package:quizz_app/app/modules/allQuestions/widgets/all_custom_appbar.dart';
import 'package:quizz_app/app/modules/allQuestions/widgets/delete.dart';
import 'package:quizz_app/app/modules/randomTopic/widgets/background_decoration.dart';
import 'package:quizz_app/app/modules/wrongSentence/controller/wrong_controller.dart';
import 'package:quizz_app/app/modules/wrongSentence/view/wrong_Sentence_view.dart';
import 'package:quizz_app/app/modules/wrongSentence/widgets/all_question_wrong.dart';
import 'package:quizz_app/app/modules/wrongSentence/widgets/answer_widget_wrong.dart';
import 'package:quizz_app/app/modules/wrongSentence/widgets/question_number_card_wrong.dart';

class TextOverviewWrongScreen extends GetView<WrongController> {
  const TextOverviewWrongScreen({Key? key}) : super(key: key);

  static const String routeName = '/testoverviewwrong';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DeleteCustomAppbar(
        title: controller.completedTest,
        showActionIcon: true,
      ),
      body: BackgroundDecoration(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 226, 226),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Image.asset(
                        "assets/images/main_top.png",
                        width: 500.w * 0.3,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: Image.asset(
                        "assets/images/main_bottom.png",
                        width: 300.w * 0.3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                              left: 25, right: 25, top: 20, bottom: 20)
                          .r,
                      child: Column(
                        children: [
                          SizedBox(width: 0.0, height: 20.h),
                          Expanded(
                            child: GridView.builder(
                              itemCount: controller.questionsList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: Get.width ~/ 65,
                                childAspectRatio: 1,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemBuilder: (_, index) {
                                final _question =
                                    controller.questionsList[index];
                                AnswerStatusWrong _status =
                                    AnswerStatusWrong.wrong;
                                final _selectedAnswer =
                                    _question.selectedAnswer;
                                final _correctAnswer = _question.correctAnswer;
                                if (_selectedAnswer == _correctAnswer) {
                                  _status = AnswerStatusWrong.correct;
                                }
                                return QuestionNumberCardWrong(
                                  index: index + 1,
                                  status: _status,
                                  ontap: () {
                                    controller.jumpToQuestion(
                                      index,
                                      isGoBack: false,
                                    );
                                    Get.offNamed(WrongSentenceView.routesname);
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // ColoredBox(
            //   color: Theme.of(context).scaffoldBackgroundColor,
            //   child:
            // ),
          ],
        ),
      ),
    );
  }
}
