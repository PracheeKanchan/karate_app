import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/session_data.dart';
import 'package:karate_app/view/tab_bar/home_screen.dart';


class PaymentScreen extends StatefulWidget {
  
  final String courseName;
  final int courseDuration;
  final String imageUrl;
  final String price;
  
  const PaymentScreen(
    {
      super.key,
      required this.courseName,
      required this.courseDuration,
      required this.imageUrl,
      required this.price,
      
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
Future<void> storeCourseDetails(String courseName, String imageUrl, String price, bool paymentSuccess,int courseDuration) async {
    try {
      await FirebaseFirestore.instance.collection('MyCoursesCollection').add({
        'courseName': courseName,
        'imageUrl': imageUrl,
        'price': price,
        'paymentSuccess': paymentSuccess,  // Store the payment success status
        'courseDuration': courseDuration,
      });
    } catch (e) {
      print('Error storing course details: $e');
    }
  }

  // Function to show the payment success dialog
  void _showPaymentSuccessDialog(BuildContext context) async{

    // Reset payment success status before processing a new payment
    //await SessionData.resetPaymentSuccessToFalse();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Payment Success',
             style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w600,
             ),
            ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               SvgPicture.asset(
              'assets/payment_success.svg', // Replace with your SVG file
              width: 150,
              height: 150,
            ),
              const SizedBox(height: 20),
              Text(
              'Congratulations,your payment has done successfully.',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                
              ),
            ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                
                //close dialog box
                Navigator.of(context).pop();
                //close payment screen
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                  return const HomeScreen();
                }));
              },
              child: Text(
              'Close',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Payment',
           style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w500,
           ),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Admission Details Section
            Text(
              'Admission Details',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              '  We allow only one-time payment.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 20,),
            // QR Code Image Section
            Container(
              color: Colors.white,
              //height: 250,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                'assets/QR_code.jpg',
                height: 250, // Replace with your QR code image
              ),
            ),
            const SizedBox(height: 40),

            // Container with Fields (Fees, UPI, Address)
            Container(
              padding:const EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: const[
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                    
                          ),
                        ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                             text:  'Course Name : ',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                             text:  widget.courseName,
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue[600],
                              ),
                            ),
                          
                        ]
                      )
                        
                      ),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                             text:  'Course Duration : ',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                             text:  "${widget.courseDuration} days",
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue[600],
                              ),
                            ),
                          
                        ]
                      )
                        
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          
                          TextSpan(
                             text:  'Fees : ',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                             text:  widget.price,
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue[600],
                              ),
                            ),
                        ]
                      )
                        
                      ),
                  ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                             text:  'Upi : ',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                             text:  'pracheekanchan-1@okicici',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue[600],
                              ),
                            ),
                        ]
                      )
                        
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                             text:  'Address : ',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                             text:  'Karate Academy, Pune',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                color: Colors.blue[600],
                              ),
                            ),
                        ]
                      )
                        
                      ),
                    ),
                ],
              ),
            ),
            const Spacer(),
            // Proceed Button
            GestureDetector(
              onTap: () {
                // Store course details in Firebase with payment success flag set to true
                storeCourseDetails(widget.courseName, widget.imageUrl, widget.price, true,widget.courseDuration);

                // Store payment success in SharedPreferences
                SessionData.setIsPurchased(true);
                _showPaymentSuccessDialog(context);
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.blue[600],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Text(
                      'Proceed',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
