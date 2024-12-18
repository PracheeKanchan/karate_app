import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:karate_app/view/auth/splash_screen.dart';
import 'package:karate_app/view/session_data.dart';

void main() async{
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: const FirebaseOptions(
       apiKey: "AIzaSyBgGAYFgMp9dpxqe-Ox05Qn4_0QPqD7vko", 
       appId: "1:713498311290:android:845227e9a0bedd741719c3", 
       messagingSenderId: "713498311290", 
       projectId: "karate-app-537b3"
     )
  );
    await SessionData.getSessionData(); // Fetch the login state

  runApp( const MyApp());

  List<Map<String,dynamic>> questionAnwerList=[

	{
	   'imageUrl': 'https://cdn.midjourney.com/d20c9fab-f29b-4c78-834a-63426b966b53/0_2.png',
	   'question':'Who is known as the founder of Shotokan karate? He is also known as "The Father of Modern Karate".',
	   'answer': ' Gichin Funakoshi ,Funakoshi Sensei is credited as being the founder of the Shotokan style of karate although he himself was never in favor of classifying karate into "styles". Kenwa Mabuni was the founder of Shito-Ryu karate, Choki Motobu was the founder of Motobu-Ryu and Chojin Miyagi was the founder of Goju-Ryu karate.',
	},
	{
	   'imageUrl': 'https://contents.mediadecathlon.com/p1270060/k\$40c3a088e3d473fb6e6a1996b90a41b9/1800x0/2880pt1920/5120xcr3840/default.jpg?format=auto',
	   'question': 'Who was the founder of Shotokan karate?',
	   'answer': ' Funakoshi was an Okinawan school teacher who went to Japan to demonstrate karate to the Japanese. His pen name was Shoto.'},
	{
	   'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoaS9lBlS3fpeB2slh0gHRae8ZxRI5ErkGKyJxQLOBG_W3k2Ew606XeBp1F7E5uKzbmSg&usqp=CAU',
	   'question':'What is the first move you learn as a beginner?',
	   'answer': 'Kihon means basic, so the Kihon kata consists of basic blocks and attacks.',
	},
	{
	   'imageUrl': 'https://www.akademiekaratebrno.cz/wp-content/uploads/2022/11/paskyakb.jpg',
	   'question':'What does the word Japanese word "karate" mean in English?',
	   'answer': 'Empty hand The gentle way is the Japanese word for Judo. Karate is used mostly with arms, elbows, knees, and feet.',
	},	
  {
	   'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQfWMUA_nKH_IOjZ7qa2E_1xgxY90AXOHt6g&s',
	   'question':'A front kick if you are right handed is kicked with which foot?',
	   'answer': 'Right Although your kick will usually come from the back, with your left foot in front.',
	},
];

  // for(var element in questionAnwerList){
  //   await FirebaseFirestore.instance.collection("questionAnswers").add(element);
  // }

  List<Map<String,dynamic>> stanceList=[

	{
	   'imageUrl': 'assets/stance/stance1.jpg',
	   'title': 'Informal attention stance',
	   'subTitle':'Heisoku-dachi',
	},
	{
	   'imageUrl': 'assets/stance/stance2.jpg',
	   'title': 'Parallel stance',
	   'subTitle':'Heiko-dachi',
	},
	{
	   'imageUrl': 'assets/stance/stance3.jpg',
	   'title': 'Open Leg stance',
	   'subTitle':'Hachiji-dachi',
	},
	{
	   'imageUrl': 'assets/stance/stance4.jpg',
	   'title': 'Square stance',
	   'subTitle':'Shiko-dachi',
	},
	{
	   'imageUrl': 'assets/stance/stance5.jpg',
	   'title': 'Hour glass stance',
	   'subTitle':'Sanchin-dachi',
	},
];
    // for(var element in stanceList){
    //     await FirebaseFirestore.instance.collection('stanceCollection').add(element);
    // }

    List<Map<String,dynamic>> warmUpList=[

	{
	   'imageUrl': 'https://img.freepik.com/premium-photo/beach-portrait-exercise-happy-man-stretching-arm-outdoor-freedom-sports-workout-start-routine-blue-sky-natural-sea-water-indian-person-doing-relax-training-warm-up-nature-island_590464-219404.jpg',
	   'title': 'Arm Stretch',
	   'description':'Start by standing with your feet shoulder-width apart and your arms extended out in front of you.',
	},
	{
	   'imageUrl': 'https://hyperwear.com/cdn/shop/articles/weighted-jump-rope-benefits-why-you-should-add-it-to-your-workout-759655.jpg?v=1706024276&width=1024',
	   'title': 'Jump Rope',
	   'description':'Jump rope, also known as skipping, is a cardiovascular exercise that involves jumping over a rope as it swings beneath you',
	},
	{
	   'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQYEmxChSEJ9o0Lcnw9BTsuvbYvzEEUOk8pYw&s',
	   'title': 'Push Ups',
	   'description':'Push-ups are a bodyweight exercise that primarily target the chest, shoulders, and triceps. They involve lowering and raising the body while keeping the arms, back, and legs straight.',
	},
	{
	   'imageUrl': 'https://images.pexels.com/photos/16131142/pexels-photo-16131142.jpeg?cs=srgb&dl=pexels-lngdik23-16131142.jpg&fm=jpg',
	   'title': 'Leg Stretching',
	   'description':'Leg stretching involves a series of exercises designed to improve flexibility, mobility, and muscle elasticity in the legs.',
	},
	{
	   'imageUrl': 'https://st.depositphotos.com/2069237/4425/i/450/depositphotos_44256833-stock-photo-sit-ups-fitness-man-training.jpg',
	   'title': 'Sit Ups',
	   'description':'Sit-ups are a core exercise that target the abdominal muscles, helping to strengthen and tone the stomach area by lifting the upper body from a lying position.',
	},
];

    for(var element in warmUpList){
      await FirebaseFirestore.instance.collection('WarmUpCollection').add(element);
    }
}
class MyApp extends StatelessWidget{


  const MyApp({super.key,});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}