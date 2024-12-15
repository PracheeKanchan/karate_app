import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class Book {
  String imageUrl;
  String name;
  String author;

  Book({required this.imageUrl, required this.name, required this.author});
}

class BookScreen extends StatelessWidget {
  final List<Book> books = [
    Book(imageUrl: 'assets/book_images/book_image1.jpg', name: 'Analysis of Geninue karate', author: 'Hermann Bayer'),
    Book(imageUrl: 'assets/book_images/book_image2.jpg', name: 'Karate', author: 'Clint Sharp'),
    Book(imageUrl: 'assets/book_images/book_image3.jpg', name: 'Karate Basics', author: 'Thomas Nardi'),
    Book(imageUrl: 'assets/book_images/book_image4.jpg', name: 'Karate Essentials', author: 'Caleb Skinner'),
    Book(imageUrl: 'assets/book_images/book_image5.jpg', name: 'Adventure of Karate', author: 'Mckenna Slingerland'),
    Book(imageUrl: 'assets/book_images/book_image6.jpg', name: 'Black Belt karate', author: 'Hirokazu Kanazawa'),
  ];

  BookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Books',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.navigate_before_outlined, color: Colors.black, size: 30,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'All Books',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Show 2 books per row
                  crossAxisSpacing: 8.0, // Space between columns
                  mainAxisSpacing: 8.0, // Space between rows
                  childAspectRatio: 0.5, // Aspect ratio for each item
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4.0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Book Image
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          height: 250,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              books[index].imageUrl,
                              width: double.infinity,
                              fit: BoxFit.fill, // Adjust the image to cover the space
                            ),
                          ),
                        ),
                        // Book Name and Author
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ReadMoreText(
                                books[index].name,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                 trimLines: 2,
                                          colorClickableText: Colors.blue,
                                          trimExpandedText: '...Read Less',
                                          trimCollapsedText: '...Read More',
                                          trimMode: TrimMode.Line,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "By ${books[index].author}",
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                
                                )
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
