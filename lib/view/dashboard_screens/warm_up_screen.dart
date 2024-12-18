import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

class WarmUpModel{

  String imageUrl;
  String title;
  String description;

  WarmUpModel({
      required this.imageUrl,
      required this.title,  
      required this.description, 
  });
}


class WarmUpScreen extends StatefulWidget {

  const WarmUpScreen({super.key});
  @override
  State createState() => _WarmUpScreenScreenState();
}

class _WarmUpScreenScreenState extends State<WarmUpScreen> {
  
  List<WarmUpModel> warmUpList=[];

  @override
  void initState(){
    super.initState();
    getFirebaseData();
  }
void getFirebaseData()async{
  QuerySnapshot response=await FirebaseFirestore.instance.collection("WarmUpCollection").get();

  for(int i=0;i<response.docs.length;i++){
    warmUpList.add(
      WarmUpModel(
        imageUrl: response.docs[i]['imageUrl'], 
        title: response.docs[i]['title'], 
        description: response.docs[i]['description'],
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
                'assets/warm_up_screen/warm_up.jpg',  // Replace with your image
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
                icon: const Icon(Icons.navigate_before_outlined,color: Colors.black,size: 30,)),
              ),
            
          ],
        ),
        automaticallyImplyLeading: false,  // Prevents default back button
      ),
      body: ListView.builder(
        itemCount: warmUpList.length,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 110,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ClipRRect(borderRadius: BorderRadius.circular(15),child:  Image.network(warmUpList[index].imageUrl,fit: BoxFit.fill,)),
                      ),
                      const SizedBox(width: 10,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              child: ReadMoreText(
                                          warmUpList[index].title,
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
                              child: ReadMoreText(
                                warmUpList[index].description,
                                style: GoogleFonts.inter(
                                          fontSize: 12, 
                                          fontWeight: FontWeight.w300,
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
            );
        },
         
      ),
        
      
     
    );
  }
}
