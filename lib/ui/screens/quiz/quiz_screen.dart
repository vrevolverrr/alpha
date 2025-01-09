import 'package:alpha/extensions.dart';
import 'package:alpha/logic/data/quiz.dart';
import 'package:alpha/services.dart';
import 'package:alpha/ui/common/alpha_button.dart';
import 'package:alpha/ui/common/alpha_scaffold.dart';
import 'package:alpha/ui/screens/dashboard/dashboard_screen.dart';
import 'package:alpha/ui/screens/quiz/widgets/quiz_card.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _selectedIndex = -1;

  late final Quiz quizChosen = gameManager.getQuizQuestion();

  Widget _buildOptionSelectionCard(String option, int index) {
    return GestureDetector(
      onTap: () => setState(() {
        _selectedIndex = index;
      }),
      child: Options(
        option: option,
        selected: _selectedIndex == index,
      ),
    );
  }

  void _handleNoOptionSelected(BuildContext context) {
    context.showSnackbar(message: "✋🏼 Please select an option to proceed");
  }

  void _checkAnswer(BuildContext context) {
    if (_selectedIndex == -1) {
      _handleNoOptionSelected(context);
      return;
    } else if (_selectedIndex == quizChosen.answer) {
      context.showSnackbar(message: "Answer is correct!");
    } else {
      context.showSnackbar(message: "Answer is wrong!");
    }

    Future.delayed(const Duration(seconds: 3), () {
      context.navigateTo(const DashboardScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlphaScaffold(
      backgroundColor: const Color(0xffFEA079),
      onTapBack: () => Navigator.of(context).pop(),
      title: "",
      next: Builder(
        builder: (BuildContext context) =>
            AlphaButton.next(onTap: () => _checkAnswer(context)),
      ),
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 700.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Questions(title: quizChosen.title),
                      const SizedBox(
                        height: 50.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildOptionSelectionCard(quizChosen.optionA, 0),
                          const SizedBox(width: 50),
                          _buildOptionSelectionCard(quizChosen.optionB, 1)
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildOptionSelectionCard(quizChosen.optionC, 2),
                          const SizedBox(width: 50),
                          _buildOptionSelectionCard(quizChosen.optionD, 3)
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
