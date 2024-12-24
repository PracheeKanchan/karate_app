import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';

class Book {
  String imageUrl;
  String name;
  String author;
  String bookUrl;
  Book({required this.imageUrl, required this.name, required this.author,required this.bookUrl});
}

class BookScreen extends StatelessWidget {
  final List<Book> books = [
    Book(imageUrl: 'assets/book_images/book_image1.jpg', name: 'Analysis of Geninue karate', author: 'Hermann Bayer',bookUrl: 'https://www.amazon.in/dp/B08TT2RRG8?ref=KC_GS_GB_IN'),
    Book(imageUrl: 'assets/book_images/book_image2.jpg', name: 'Karate', author: 'Clint Sharp', bookUrl: 'https://www.amazon.in/Karate-Comprehensive-Techniques-Beginners-Wanting-ebook/dp/B0D6JQKMB3/ref=sr_1_4?dib=eyJ2IjoiMSJ9.yJcLNCQQL9pf2K1r0TqbuXb040w3_XmHh47wX0UnjQtgcOZH0zMunCG_cBWUmOp9WrQZxRI3wj5zcXrwsLcLf_ltTrvJasLEbd96l0zIWiYjhF7YzBGGj_L4_PXIx3YJb5HLlDIXkOEQCYBITJgJBpbseVx9L2WdacW_eksr2KiLsrcSTjL4AxDA8ZdXCDICuScHIIRU_HX45jyVldBkQhg9layIdGhO1MNomtTJoqM.qW3pwmU35xsbNeexfHPn-pg5OovZEqWfsLzdXnLxFcs&dib_tag=se&qid=1735060179&refinements=p_27%3AClint+Sharp&s=books&sr=1-4'),
    Book(imageUrl: 'assets/book_images/book_image3.jpg', name: 'Karate Basics', author: 'Thomas Nardi',bookUrl: 'https://www.amazon.in/Karate-Basics/dp/0135145481'),
    Book(imageUrl: 'assets/book_images/book_image4.jpg', name: 'Karate Essentials', author: 'Caleb Skinner', bookUrl: 'https://www.amazon.in/Karate-Essentials-Beginners-Principles-Practice-ebook/dp/B083S99YY6'),
    Book(imageUrl: 'assets/book_images/book_image5.jpg', name: 'Adventure of Karate', author: 'Mckenna Slingerland',bookUrl: 'https://www.amazon.in/Adventures-Karate-McKenna-Slingerland/dp/1535595167'),
    Book(imageUrl: 'assets/book_images/book_image6.jpg', name: 'Black Belt karate', author: 'Hirokazu Kanazawa',bookUrl: 'https://www.amazon.com/Black-Belt-Karate-Intensive-Course/dp/1568365039'),
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
                  return GestureDetector(
                    onTap: () {
                      // Navigate to the BookDetailScreen with the selected book
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailScreen(book: books[index]),
                        ),
                      );
                    },
                    child: Card(
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
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

class BookDetailScreen extends StatelessWidget {
  final Book book;

  const BookDetailScreen({super.key, required this.book});

  // Function to launch a URL
Future<void> _launchURL() async {
  // Construct the URL using Uri.parse
  Uri url = Uri.parse(book.bookUrl); // Replace with the actual PDF URL
  
  if (await canLaunchUrl(url)) {  // Check if the URL can be launched
    await launchUrl(url);  // Launch the URL
  } else {
    throw 'Could not launch $url';  // Handle error if the URL can't be launched
  }
}

// Function to show the dialog when the "Read Sample" button is clicked
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          book.name,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        surfaceTintColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.navigate_before_outlined, color: Colors.black, size: 30,
          ),
        ),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          // Book Image
          SizedBox(
            height: 250,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  book.imageUrl,
                  fit: BoxFit.fill,
                  
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Book Name and Author
          Text(
            book.name,
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "By ${book.author}",
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 30),
          // Download Button
          ElevatedButton(
            onPressed:() {
              showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Sample PDF'),
                      content: const Text('Sample PDF is currently not available'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Dismiss the dialog
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
            },  
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 65),
              child: Text(
                'Read Sample',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          // Download Button
          ElevatedButton(
            onPressed: _launchURL,  // Call the _launchURL function here
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 40.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Purchase from Amazon',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10,),
          const Text("...",
            style:TextStyle(
              fontSize:40,
            )
          ),
        ],
      ),
    );
  }
}
