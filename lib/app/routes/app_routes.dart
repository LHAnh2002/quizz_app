import 'package:get/get.dart';
import 'package:quizz_app/app/modules/Testkit/controller/test_kill_controller.dart';
import 'package:quizz_app/app/modules/Testkit/controller/test_kill_question_controller.dart';
import 'package:quizz_app/app/modules/Testkit/view/test_kill_question.dart';
import 'package:quizz_app/app/modules/Testkit/view/test_kit_view.dart';
import 'package:quizz_app/app/modules/Testkit/widgets/done/answer_check_widget.dart';
import 'package:quizz_app/app/modules/Testkit/widgets/done/result_widget.dart';
import 'package:quizz_app/app/modules/Testkit/widgets/test_kill_answer_check_screen.dart';
import 'package:quizz_app/app/modules/Testkit/widgets/test_kill_overview.dart';
import 'package:quizz_app/app/modules/Testkit/widgets/test_kill_result_screen.dart';
import 'package:quizz_app/app/modules/Tips/controller/tips_controller.dart';
import 'package:quizz_app/app/modules/Tips/view/tips_view.dart';
import 'package:quizz_app/app/modules/allQuestions/controller/all_question_word_controller.dart';
import 'package:quizz_app/app/modules/allQuestions/view/all_questions_view.dart';
import 'package:quizz_app/app/modules/allQuestions/view/word/all_questions_word.dart';
import 'package:quizz_app/app/modules/allQuestions/widgets/TexOverviewScreen_word.dart';
import 'package:quizz_app/app/modules/auth/view/login_view.dart';
import 'package:quizz_app/app/modules/chatgpt/controller/chatgpt_controller.dart';
import 'package:quizz_app/app/modules/chatgpt/view/chat_gpt_view.dart';
import 'package:quizz_app/app/modules/home/controller/quesition_image_controller.dart';
import 'package:quizz_app/app/modules/home/controller/zoom_drawer_controller.dart';
import 'package:quizz_app/app/modules/home/view/home_view.dart';
import 'package:quizz_app/app/modules/home/view/text_overview_screen.dart';
import 'package:quizz_app/app/modules/review/controller/rank_controller.dart';
import 'package:quizz_app/app/modules/wrongSentence/widgets/all_question_wrong.dart';
import 'package:quizz_app/app/modules/wrongSentence/widgets/text_overview_wrong_screen.dart';
import 'package:quizz_app/app/modules/introduction/App_introduction_screen.dart';
import 'package:quizz_app/app/modules/randomTopic/controller/randomTopic_controller.dart';
import 'package:quizz_app/app/modules/randomTopic/view/random_topic_view.dart';
import 'package:quizz_app/app/modules/review/view/review_view.dart';
import 'package:quizz_app/app/modules/welcome/splash_view.dart';
import 'package:quizz_app/app/modules/widgets/answer_check_screen.dart';
import 'package:quizz_app/app/modules/widgets/result_screen.dart';
import 'package:quizz_app/app/modules/wrongSentence/controller/wrong_controller.dart';
import 'package:quizz_app/app/modules/wrongSentence/view/wrong_Sentence_view.dart';

class AppRoutes {
  static List<GetPage> routes() => [
        GetPage(
          name: "/",
          page: () => const SplashView(),
        ),
        GetPage(
          name: "/introduction",
          page: () => const AppIntroductionScreen(),
        ),
        GetPage(
          name: HomeView.home,
          page: () => const HomeView(),
          binding: BindingsBuilder(
            () {
              Get.put(QuestionImageController());
              Get.put(MyZoomDrawerController());
              Get.put<TestKillController>(TestKillController());
              // Get.put<TestKillQuestionController>(TestKillQuestionController());
            },
          ),
        ),
        GetPage(
          name: TestKitView.routesname,
          page: () => const TestKitView(),
          binding: BindingsBuilder(
            () {
              //     Get.put<TestKillController>(TestKillController());
              Get.put<TestKillQuestionController>(TestKillQuestionController());
            },
          ),
        ),
        GetPage(
          name: TestKillQuestion.routesname,
          page: () => const TestKillQuestion(),
        ),
        GetPage(
          name: RandomTopicView.routesname,
          page: () => const RandomTopicView(),
          binding: BindingsBuilder(
            () {
              Get.put<RandomTopicController>(RandomTopicController());
              // Get.lazyPut<RandomTopicController>(() => RandomTopicController());
            },
          ),
        ),
        GetPage(
          name: WrongSentenceView.routesname,
          page: () => const WrongSentenceView(),
          binding: BindingsBuilder(
            () {
              Get.put<WrongController>(WrongController());
            },
          ),
        ),
        GetPage(
          name: TestKillQuestion.routesname,
          page: () => const TestKillQuestion(),
          binding: BindingsBuilder(
            () {},
          ),
        ),
        GetPage(
          name: TextOverviewWrongScreen.routeName,
          page: () => const TextOverviewWrongScreen(),
        ),
        GetPage(
          name: ResultWidget.rountName,
          page: () => const ResultWidget(),
        ),
        GetPage(
          name: TestKillOverview.routeName,
          page: () => const TestKillOverview(),
        ),
        GetPage(
          name: TipsView.routeName,
          page: () => const TipsView(),
          binding: BindingsBuilder(
            () {
              Get.put<TipsController>(TipsController());
            },
          ),
        ),
        GetPage(
          name: ReviewView.routeName,
          page: () => const ReviewView(),
          binding: BindingsBuilder(
            () {
              Get.put<RankController>(RankController());
            },
          ),
        ),
        GetPage(
          name: LoginView.routeName,
          page: () => const LoginView(),
        ),
        GetPage(
          name: TextOverviewScreen.routeName,
          page: () => const TextOverviewScreen(),
        ),
        GetPage(
          name: TextOverviewWordScreen.routeName,
          page: () => const TextOverviewWordScreen(),
        ),
        GetPage(
          name: ResultScreen.rountName,
          page: () => const ResultScreen(),
        ),
        GetPage(
          name: TestKillResultScreen.rountName,
          page: () => const TestKillResultScreen(),
        ),
        GetPage(
          name: "/allquestions",
          page: () => const AllQuestionsView(),
          binding: BindingsBuilder(
            () {
              Get.put<AllQuestionWordController>(AllQuestionWordController());
            },
          ),
        ),
        GetPage(
          name: AllQuestionsWord.routesname,
          page: () => const AllQuestionsWord(),
          binding: BindingsBuilder(
            () {
              Get.put<AllQuestionWordController>(AllQuestionWordController());
            },
          ),
        ),
        GetPage(
          name: AllQuestionsWrong.routesname,
          page: () => const AllQuestionsWrong(),
          binding: BindingsBuilder(
            () {
              Get.put<WrongController>(WrongController());
            },
          ),
        ),
        GetPage(
          name: AnswerCheckScreen.routeName,
          page: () => const AnswerCheckScreen(),
        ),
        GetPage(
          name: TestKillAnswerCheckScreen.routeName,
          page: () => const TestKillAnswerCheckScreen(),
        ),
        GetPage(
          name: AnswerCheckWidget.routeName,
          page: () => const AnswerCheckWidget(),
        ),
        GetPage(
          name: ChatGptView.routeName,
          page: () => const ChatGptView(),
          binding: BindingsBuilder(
            () {
              Get.put<ChatgptController>(ChatgptController());
            },
          ),
        ),
      ];
}
