# BookLog-Mobile-App-with-Flutter

### Short description

`BookLog` is a mobile application designed to help you keep track of your reading history. It allows you to log the books you've read, rate them, and write detailed reviews. It is especially useful when you want to recommend books to others, serving as a convenient reference. Additionally, it's excellent for preserving and revisiting your thoughts on books you've read in the past, building a detailed record of your reading preferences.

### Domain details

Each `Book` entity has the following fields:
- `Title`: the title of the read book;
- `Author`: the author of the book;
- `Genre`: the genre to which the book belongs;
- `Rating`: a user-assigned rating (between 1 and 10) reflecting how much they enjoyed the book;
- `Review`: a text for users to save their personal review of the book.

### CRUD

- `Create`: Users can add a new book to their list by providing details like title, author, genre, rating, and a review.
- `Read`: Users can view a list of all the books they've added, including details like title, author, genre, rating, and their reviews.
- `Update`: Users can edit and update the information for a previously added book, making changes to fields like title, author, genre, rating, or the review.
- `Delete`: Users can remove a book from their list, permanently deleting it from their records.

### Persistence details

The data is retrieved from the `local database` using `SQLite`.

<img src="/demos/demo1.PNG">
<img src="/demos/demo1.PNG">
<img src="/demos/demo1.PNG">
<img src="/demos/demo1.PNG">
