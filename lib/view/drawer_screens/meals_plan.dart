import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karate_app/view/tab_bar/home_screen.dart';

class MealsPlanScreen extends StatelessWidget {

   MealsPlanScreen({super.key});

  // Original meal plan for one day
  final Map<String, dynamic> dailyMealPlan = {
    'meals': {
      'Breakfast': {
        'title': 'Oatmeal with Fruits',
        'description': 'A healthy breakfast with oats, berries, and milk.',
      },
      'Snack': {
        'title': 'Yogurt with Nuts',
        'description': 'A light snack with yogurt and almonds.',
      },
      'Lunch': {
        'title': 'Grilled Chicken Salad',
        'description': 'A nutritious salad with grilled chicken, veggies, and dressing.',
      },
      'Dinner': {
        'title': 'Pasta with Veggies',
        'description': 'A hearty dinner with pasta and mixed vegetables.',
      },
    },
  };


  @override
  Widget build(BuildContext context) {
    // Repeat the daily meal plan 7 times (for each day of the week)
    final List<Map<String, dynamic>> mealPlan = List.generate(7, (index) {
      return {
        'day': 'Day ${index + 1}', // Day 1, Day 2, ..., Day 7
        'meals': dailyMealPlan['meals'], // Repeating the same meals for each day
      };
    });

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 180,
        flexibleSpace: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              child: Image.asset(
                'assets/Meals/meals_plan.jpg',  // Replace with your image
                fit: BoxFit.cover,
              ),
            ),
             Positioned(
              left: 10,
              top: 30,
              child: IconButton(
                onPressed: (){
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) {
                      return const HomeScreen();
                    }),
                  );
                }, 
                icon: const Icon(Icons.navigate_before_outlined,color: Colors.black,size: 30,)),
              ),
            
          ],
        ),
        automaticallyImplyLeading: false,  // Prevents default back button
      ),
      body: ListView.builder(
        itemCount: mealPlan.length,
        itemBuilder: (context, index) {
          final day = mealPlan[index];
          final meals = day['meals'];

          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Day Title
                    Text(
                      day['day'],
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),

                    // Meals for the day (Breakfast, Snack, Lunch, Dinner)
                    _buildMealSection('Breakfast', meals['Breakfast'],'assets/Meals/breakfast.jpg'),
                    const SizedBox(height: 10),
                    _buildMealSection('Snack', meals['Snack'],'assets/Meals/snack.jpg'),
                    const SizedBox(height: 10),
                    _buildMealSection('Lunch', meals['Lunch'],'assets/Meals/lunch.jpg'),
                    const SizedBox(height: 10),
                    _buildMealSection('Dinner', meals['Dinner'],'assets/Meals/dinner.jpg'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMealSection(String mealType, Map<String, String> mealDetails,String assetImage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipOval(child: Image.asset(assetImage,fit: BoxFit.cover,)),
            ),
            const SizedBox(width: 10,),
            Text(
              mealType,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            mealDetails['title']!,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            mealDetails['description']!,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ],
    );
  }
}
