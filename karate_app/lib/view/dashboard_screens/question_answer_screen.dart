import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/tab_bar/home_screen.dart';
import 'package:readmore/readmore.dart';



class QuestionAnswerScreen extends StatefulWidget {

  const QuestionAnswerScreen({super.key});
  @override
  State createState() => _QuestionAnswerScreen();
}

class _QuestionAnswerScreen extends State<QuestionAnswerScreen> {
  
void _showBottomSheet(BuildContext context, String question, String answer) {
    // Open bottom sheet with question and answer
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 13),
                Text(
                  answer,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    String question = "What is the first move you learn as a beginner?";
    String answer = "Kihon - Kihon means basic, so the Kihon kata consists of basic blocks and attacks.";

    return Scaffold(
      appBar:  AppBar(
        toolbarHeight: 180,
        flexibleSpace: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              child: Image.asset(
                'assets/knowledge_lab/question_screen.jpg',  // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
             Positioned(
              left: 10,
              top: 30,
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context){
                        return const HomeScreen();
                    })
                  );
                }, 
                icon: const Icon(Icons.navigate_before_outlined,color: Colors.white,)),
              ),
             
            //  Positioned(
            //   left: 70,
            //   top: 35,
            //   child: Text(
            //     'Question & Answer',
            //     style: GoogleFonts.poppins(
            //         fontSize: 20,
            //         fontWeight: FontWeight.w600,
            //         color:Colors.white
            //     )
            //   ),
            // ),
          ],
        ),
        automaticallyImplyLeading: false,  // Prevents default back button
      ),
      body: ListView.builder(
        itemCount: 10,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
              child: GestureDetector(
                onTap: (){
                  _showBottomSheet(context, question, answer);
                },
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
                          child: ClipRRect(borderRadius: BorderRadius.circular(15),child:  Image.asset('assets/knowledge_lab/Q&A_image.jpg',fit: BoxFit.cover,)),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: ReadMoreText(
                                            question,
                                            style: GoogleFonts.inter(
                                            fontSize: 14, 
                                            fontWeight: FontWeight.w600,
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
                                child: ReadMoreText(
                                            answer,
                                            style: GoogleFonts.inter(
                                            fontSize: 12, 
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            ),
                                            trimLines: 2,
                                            colorClickableText: Colors.blue,
                                            trimExpandedText: '...Read Less',
                                            trimCollapsedText: '...Read More',
                                            trimMode: TrimMode.Line,
                                        ),
                              ),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
              ),
            );
        },
         
      ),
        
      
     
    );
  }
}
