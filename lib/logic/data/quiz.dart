enum Quiz {
  questionSet1(
      title: "Who's the prime minister of Malaysia?",
      optionA: "Najib",
      optionB: "Lee Kuan Yew",
      optionC: "Mahatir",
      optionD: "Bryan Soong",
      answer: 3),

  questionSet2(
      title: "Who's the prime minister of Singapore?",
      optionA: "Najib",
      optionB: "Lee Kuan Yew",
      optionC: "Mahatir",
      optionD: "Bryan Soong",
      answer: 1);

  final String title;
  final String optionA;
  final String optionB;
  final String optionC;
  final String optionD;
  final int answer;

  const Quiz(
      {required this.title,
      required this.optionA,
      required this.optionB,
      required this.optionC,
      required this.optionD,
      required this.answer});
}
