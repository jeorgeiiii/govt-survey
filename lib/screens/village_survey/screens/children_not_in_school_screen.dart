import 'package:flutter/material.dart';
import '../form_template.dart';
import 'orchards_plants_screen.dart';
import 'traditional_occupations_screen.dart'; // Import the previous screen

class ChildrenNotInSchoolScreen extends StatefulWidget {
  @override
  _ChildrenNotInSchoolScreenState createState() => _ChildrenNotInSchoolScreenState();
}

class _ChildrenNotInSchoolScreenState extends State<ChildrenNotInSchoolScreen> {
  final TextEditingController boysController = TextEditingController();
  final TextEditingController girlsController = TextEditingController();
  
  int get totalBoys => int.tryParse(boysController.text) ?? 0;
  int get totalGirls => int.tryParse(girlsController.text) ?? 0;
  int get total => totalBoys + totalGirls;

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrchardsPlantsScreen()),
    );
  }

  void _goToPreviousScreen() {
    // Navigate back to TraditionalOccupationsScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TraditionalOccupationsScreen()),
    );
  }

  Widget _buildChildrenContent() {
    return Column(
      children: [
        GenderBreakdownInput(
          label: 'Children Not in School (5-14 years)',
          description: 'Number of boys and girls who do not go to school',
          boysController: boysController,
          girlsController: girlsController,
          onTotalChanged: () => setState(() {}),
        ),
        
        // Total Display Card
        if (total > 0)
          CalculatedDisplay(
            label: 'Total Children Not in School',
            value: total.toString(),
            description: 'Boys: $totalBoys | Girls: $totalGirls',
            icon: Icons.school,
            color: total > 50 ? Colors.red : Color(0xFF800080),
          ),
        
        // Summary Card
        if (total > 0)
          SummaryCard(
            title: 'Children Not in School Summary',
            items: [
              {'label': 'Boys (5-14 years):', 'value': totalBoys.toString()},
              {'label': 'Girls (5-14 years):', 'value': totalGirls.toString()},
              {'label': 'Total Children:', 'value': total.toString()},
            ],
          ),
        
        // Additional Warnings
        if (total > 0)
          Column(
            children: [
              if (totalGirls > totalBoys)
                WarningAlert(
                  message: 'More girls than boys not in school',
                  icon: Icons.warning,
                  color: Colors.orange,
                ),
              
              if (total > 50)
                WarningAlert(
                  message: 'High number of children not in school',
                  icon: Icons.error,
                  color: Colors.red,
                ),
            ],
          ),
          
        // Success Message
        if (total == 0 && (boysController.text.isNotEmpty || girlsController.text.isNotEmpty))
          SuccessAlert(
            message: 'All children in school - Great!',
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplateScreen(
      title: 'Children Not in School',
      stepNumber: 'Step 12',
      nextScreenRoute: '/orchards-plants',
      nextScreenName: 'Orchards/Plants',
      icon: Icons.school,
      instructions: 'Number of boys and girls (5 to 14 years) who do not go to school',
      contentWidget: _buildChildrenContent(),
      onSubmit: _submitForm,
      onBack: _goToPreviousScreen, onReset: () {  },
    );
  }

  @override
  void dispose() {
    boysController.dispose();
    girlsController.dispose();
    super.dispose();
  }
}