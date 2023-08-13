import 'dart:core';
import 'dart:ui';

class BookModel {
  String numpages;
  String authors;
  String average_rating;
  String bookID;
  String isbn;
  String isbn13;
  String language_code;
  String publication_date;
  String publisher;
  String ratings_count;
  String text_reviews_count;
  String title;
  String isAvailable;
  String issueDate;

  BookModel(
      this.numpages,
      this.authors,
      this.average_rating,
      this.bookID,
      this.isbn,
      this.isbn13,
      this.language_code,
      this.publication_date,
      this.publisher,
      this.ratings_count,
      this.text_reviews_count,
      this.title,
      this.isAvailable,
      this.issueDate);
}
