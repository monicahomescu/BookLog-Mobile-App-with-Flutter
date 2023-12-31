class Book {
  int id;
  final String title;
  final String author;
  final String genre;
  final int rating;
  final String review;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.genre,
    required this.rating,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'author': author,
      'genre': genre,
      'rating': rating,
      'review': review,
    };
  }
}
