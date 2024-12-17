import 'package:flutter/material.dart';


class VerticalStepperWithHorizontalStepper extends StatefulWidget {
  const VerticalStepperWithHorizontalStepper({super.key});

  @override
  _VerticalStepperWithHorizontalStepperState createState() =>
      _VerticalStepperWithHorizontalStepperState();
}

class _VerticalStepperWithHorizontalStepperState
    extends State<VerticalStepperWithHorizontalStepper> {
  int _currentWeek = 0;
  int _currentDay = 0;

  // Define a method for creating steps for each week.
  List<Step> _getWeekSteps() {
    return [
      Step(
        title: const Row(
          children: [
            Icon(Icons.calendar_today),
            SizedBox(width: 10),
            Text('Week 1'),
          ],
        ),
        content: const Text("Week 1"),
        isActive: _currentWeek == 0,
        state: _currentWeek > 0 ? StepState.complete : StepState.indexed,
      ),
      // You can add more weeks in the same way, e.g., Week 2, Week 3...
      Step(
        title: const Row(
          children: [
            Icon(Icons.calendar_today),
            SizedBox(width: 10),
            Text('Week 2'),
          ],
        ),
        content: Container(
          height: 100,
          color: Colors.grey[300],
          child: const Center(child: Text('No content for Week 2')),
        ),
        isActive: _currentWeek >= 1,
        state: _currentWeek > 1 ? StepState.complete : StepState.indexed,
      ),
      // Repeat the above pattern for other weeks.
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Courses'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stepper(
          type: StepperType.vertical,
          steps: _getWeekSteps(),
          currentStep: _currentWeek,
          onStepTapped: (step) => setState(() {
            _currentWeek = step;
            _currentDay = 0; // Reset day when switching weeks
          }),
          onStepContinue: () {
            if (_currentWeek < 1) {
              setState(() {
                _currentWeek++;
                _currentDay = 0; // Reset day when switching weeks
              });
            }
          },
          onStepCancel: () {
            if (_currentWeek > 0) {
              setState(() {
                _currentWeek--;
                _currentDay = 0; // Reset day when switching weeks
              });
            }
          },
        ),
      ),
    );
  }
}

