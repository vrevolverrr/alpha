bool isVowel(String char) =>
    ["A", "E", "I", "O", "U"].contains(char.toUpperCase());

String singularArticle(String subject, {bool capitalize = false}) {
  String article;

  if (isVowel(subject.substring(0, 1))) {
    article = "an";
  } else {
    article = "a";
  }

  if (capitalize) {
    article = article.substring(0, 1).toUpperCase() + article.substring(1);
  }

  return "$article $subject";
}
