import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';



class NewsScreen extends StatefulWidget {

  const NewsScreen({super.key});
  @override
  State createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
              child: Container(
                  //height: 100,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(0,7),
                        blurRadius: 8,
                        spreadRadius: 0,
                        color: Color.fromARGB(255, 237, 193, 245),
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 110,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(borderRadius: BorderRadius.circular(15),child:  Image.asset('assets/news_image.jpg',fit: BoxFit.cover,)),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: ReadMoreText(
                                          'Triumphs and Thrills on Day Two of the Karate 1 Youth League in Venice',
                                          style: GoogleFonts.inter(
                                          fontSize: 14, 
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          ),
                                          trimLines: 2,
                                          colorClickableText: Colors.blue,
                                          trimExpandedText: '...Read Less',
                                          trimCollapsedText: '...Read More',
                                          trimMode: TrimMode.Line,
                                      ),
                            ),
                        
                            Container(
                              padding:const EdgeInsets.only(top: 3,bottom: 5),
                              child: Text(
                                'Loream Ipsum, dummy data ',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                ),
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
        
      
     
    );
  }
}
