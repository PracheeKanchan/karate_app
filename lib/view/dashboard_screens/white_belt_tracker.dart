import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrainingProgressTracker extends StatelessWidget {
  final int totalDays = 56;
  final int completedDays;
  final int totalWeeks = 8;

  const TrainingProgressTracker({
    super.key,
    required this.completedDays,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daily Progress',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Display remaining days
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Text(
                    '${totalDays - completedDays} Days left',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // List of weeks progress
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: totalWeeks,
                itemBuilder: (context, weekIndex) {
                  return WeekProgress(
                    weekNumber: weekIndex + 1,
                    isCompleted: completedDays >= (weekIndex + 1) * 7,
                    currentDay: completedDays,
                  );
                },
              ),
            ),
            // GO Button
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'GO!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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

class WeekProgress extends StatelessWidget {
  final int weekNumber;
  final bool isCompleted;
  final int currentDay;

  const WeekProgress({
    super.key,
    required this.weekNumber,
    required this.isCompleted,
    required this.currentDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Text(
              'Week $weekNumber',
              style: TextStyle(
                color: Colors.grey[800],
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Week progress bar
          WeekProgressBar(
            weekNumber: weekNumber,
            isCompleted: isCompleted,
            currentDay: currentDay,
          ),
        ],
      ),
    );
  }
}

class WeekProgressBar extends StatelessWidget {
  final int weekNumber;
  final bool isCompleted;
  final int currentDay;

  const WeekProgressBar({
    super.key,
    required this.weekNumber,
    required this.isCompleted,
    required this.currentDay,
  });

  @override
  Widget build(BuildContext context) {
    final int startDayOfWeek = (weekNumber - 1) * 7 + 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(7, (index) {
        final dayNumber = startDayOfWeek + index;
        bool isDayCompleted = currentDay >= dayNumber;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Icon(
            isDayCompleted ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isDayCompleted ? Colors.green : Colors.grey,
          ),
        );
      }),
    );
  }
}
