import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return WarmUpDetailScreen(warmUpModel: warmUpList[index],);
                  }));
                },
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
                                child: Text(
                                            warmUpList[index].title,
                                            style: GoogleFonts.inter(
                                            fontSize: 14, 
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                        ),
                              ),
                          
                              Container(
                                padding:const EdgeInsets.only(top: 3,bottom: 5),
                                child:Text(
                                  warmUpList[index].description,
                                  style: GoogleFonts.inter(
                                            fontSize: 12, 
                                            fontWeight: FontWeight.w300,
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

class WarmUpDetailScreen extends StatelessWidget {

  final WarmUpModel warmUpModel;
  const WarmUpDetailScreen({super.key,required this.warmUpModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          warmUpModel.title,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: Colors.white
          ),
        ),
        leading:GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.navigate_before_outlined,color: Colors.white,size: 30,)
        ),
        backgroundColor: const Color.fromARGB(255, 12, 54, 89),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Container(
            color:  const Color.fromARGB(255, 12, 54, 89),
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.network(
                    warmUpModel.imageUrl, // Replace with your image asset path
                    fit: BoxFit.cover,
                    width: 350,
                    height: 250, // Ensures the image is properly fitted
                  ),
                ),
                Text(
                  warmUpModel.title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          // Description Section
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: const[
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 15,
                    offset: Offset(0,3)
                  )
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                       "Description",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Text(
                      warmUpModel.description,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

