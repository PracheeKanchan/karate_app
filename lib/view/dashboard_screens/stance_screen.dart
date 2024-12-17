import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class StanceModel{

  String imageUrl;
  String title;
  String subTitle;

  StanceModel({
      required this.imageUrl,
      required this.title,  
      required this.subTitle, 
      ///required this.email,  
  });
}


class StanceScreen extends StatefulWidget {

  const StanceScreen({super.key});
  @override
  State createState() => _StanceScreenState();
}

class _StanceScreenState extends State<StanceScreen> {
  
  List<StanceModel> stanceList=[];

  @override
  void initState(){
    super.initState();
    getFirebaseData();
  }
void getFirebaseData()async{
  QuerySnapshot response=await FirebaseFirestore.instance.collection("stanceCollection").get();

  for(int i=0;i<response.docs.length;i++){
    stanceList.add(
      StanceModel(
        imageUrl: response.docs[i]['imageUrl'], 
        title: response.docs[i]['title'], 
        subTitle: response.docs[i]['subTitle'],
      )
    );
  }
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
                'assets/stance/stance_page.png',  // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
             Positioned(
              left: 10,
              top: 30,
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pop();
                }, 
                icon: const Icon(Icons.navigate_before_outlined,color: Colors.white,)),
              ),
            
          ],
        ),
        automaticallyImplyLeading: false,  // Prevents default back button
      ),
      body: ListView.builder(
        itemCount:stanceList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
              child: Container(
                  //height: 100,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    
                    
                  ),
                  child: Row(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 110,
                        width: 170,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child:  Image.asset(stanceList[index].imageUrl,fit: BoxFit.fill,)),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: Text(
                                            stanceList[index].title,
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
                                            stanceList[index].subTitle,
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
            );
        },
         
      ),
        
      
     
    );
  }
}
