String validateInput(String title, String author, String genre, String rating) {
  String validationErrors = "";

  if (title == "") {
    validationErrors += "Title should not be empty!\n";
  }

  final RegExp regexText = RegExp(r'^[a-zA-Z\- ]+$');
  if (!regexText.hasMatch(author)) {
    validationErrors += "Author should be a text with letters or -!\n";
  }
  if (!regexText.hasMatch(genre)) {
    validationErrors += "Genre should be a text with letters or -!\n";
  }

  final RegExp regexNumber = RegExp(r'^(?:[1-9]|10)$');
  if (!regexNumber.hasMatch(rating)) {
    validationErrors += "Rating should be a number between 1 and 10!\n";
  }

  return validationErrors;
}
