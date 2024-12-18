import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/tab_bar/home_screen.dart';

class QuestionAnwserModel{

  String imageUrl;
  String question;
  String answer;

  QuestionAnwserModel({
      required this.imageUrl,
      required this.question,  
      required this.answer, 
      ///required this.email,  
  });
}

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

  List<QuestionAnwserModel> questionAnwerList=[];

  @override
  void initState(){
    super.initState();
    getFirebaseData();
  }
void getFirebaseData()async{
  QuerySnapshot response=await FirebaseFirestore.instance.collection("questionAnswers").get();

  for(int i=0;i<response.docs.length;i++){
    questionAnwerList.add(
      QuestionAnwserModel(
        imageUrl: response.docs[i]['imageUrl'], 
        question: response.docs[i]['question'], 
        answer: response.docs[i]['answer'],
      )
    );
  }
  print(questionAnwerList);
  setState(() {});
}
  @override
  Widget build(BuildContext context) {


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
             
            
          ],
        ),
        automaticallyImplyLeading: false,  // Prevents default back button
      ),
      body: ListView.builder(
        itemCount: questionAnwerList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,top: 15),
              child: GestureDetector(
                onTap: (){
                  _showBottomSheet(context, questionAnwerList[index].question,questionAnwerList[index].answer);
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
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child:  Image.network(questionAnwerList[index].imageUrl,fit: BoxFit.cover,)),
                        ),
                        const SizedBox(width: 20,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                            questionAnwerList[index].question,
                                            style: GoogleFonts.inter(
                                            fontSize: 14, 
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black,
                                            ),
                                            maxLines: 3,
                                            overflow:TextOverflow.ellipsis,
                                        ),
                              ),
                          
                              Container(
                                padding:const EdgeInsets.only(top: 3,bottom: 5),
                                child: Text(
                                            questionAnwerList[index].answer,
                                            style: GoogleFonts.inter(
                                            fontSize: 12, 
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
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
