import 'package:flutter/material.dart';
import '../form_template.dart'; // Import the form template
import 'drainage_waste_screen.dart';
import 'infrastructure_availability_screen.dart'; // Import the previous screen

class EducationalFacilitiesScreen extends StatefulWidget {
  @override
  _EducationalFacilitiesScreenState createState() => _EducationalFacilitiesScreenState();
}

class _EducationalFacilitiesScreenState extends State<EducationalFacilitiesScreen> {
  // Controllers
  final TextEditingController numAnganwadiController = TextEditingController();
  final TextEditingController numShikshaGuaranteeController = TextEditingController();
  final TextEditingController otherFacilityNameController = TextEditingController();
  final TextEditingController otherFacilityCountController = TextEditingController();

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DrainageWasteScreen()),
    );
  }

  void _goToPreviousScreen() {
    // Navigate back to InfrastructureAvailabilityScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => InfrastructureAvailabilityScreen()),
    );
  }

  Widget _buildEducationalContent() {
    return Column(
      children: [
        // Anganwadi Section
        QuestionCard(
          question: 'a) No. of Anganwadi',
          description: 'Number of Anganwadi centers in village',
          child: NumberInput(
            label: 'Enter number of Anganwadi',
            controller: numAnganwadiController,
            prefixIcon: Icons.child_care,
          ),
        ),
        
        SizedBox(height: 25),
        
        // Shiksha Guarantee Section
        QuestionCard(
          question: 'b) No. of Shiksha Guarantee Beneficiaries',
          description: 'Number of beneficiaries under Shiksha Guarantee Scheme',
          child: NumberInput(
            label: 'Enter number of beneficiaries',
            controller: numShikshaGuaranteeController,
            prefixIcon: Icons.school,
          ),
        ),
        
        SizedBox(height: 25),
        
        // Other Facilities Section
        QuestionCard(
          question: '📚 Other Educational Facilities',
          description: 'Other educational facilities in village',
          child: Column(
            children: [
              TextInput(
                label: 'Facility Name (e.g., Coaching Center, Library, etc.)',
                controller: otherFacilityNameController,
                prefixIcon: Icons.menu_book,
                isRequired: false,
              ),
              
              SizedBox(height: 15),
              
              NumberInput(
                label: 'Number of such facilities',
                controller: otherFacilityCountController,
                prefixIcon: Icons.numbers,
              ),
            ],
          ),
        ),
        
        SizedBox(height: 25),
        
        // Progress Indicator
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xFFE6E6FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFF800080).withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.flag, color: Color(0xFF800080), size: 24),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Step 7 of 9: Educational Facilities',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF800080),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Next: Drainage & Waste Management',
                style: TextStyle(
                  color: Color(0xFF800080).withOpacity(0.8),
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 4,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF800080).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  widthFactor: 7/9,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF800080),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildProgressStep(1, true),
                  _buildProgressStep(2, true),
                  _buildProgressStep(3, true),
                  _buildProgressStep(4, true),
                  _buildProgressStep(5, true),
                  _buildProgressStep(6, true),
                  _buildProgressStep(7, true),
                  _buildProgressStep(8, false),
                  _buildProgressStep(9, false),
                ],
              ),
            ],
          ),
        ),
        
        SizedBox(height: 20),
        
        // Summary Card
        if (numAnganwadiController.text.isNotEmpty || 
            numShikshaGuaranteeController.text.isNotEmpty || 
            otherFacilityCountController.text.isNotEmpty)
          SummaryCard(
            title: '🎓 Educational Facilities Summary',
            items: [
              if (numAnganwadiController.text.isNotEmpty) 
                {'label': 'Anganwadi Centers:', 'value': numAnganwadiController.text},
              if (numShikshaGuaranteeController.text.isNotEmpty) 
                {'label': 'Shiksha Guarantee Beneficiaries:', 'value': numShikshaGuaranteeController.text},
              if (otherFacilityNameController.text.isNotEmpty && otherFacilityCountController.text.isNotEmpty)
                {'label': '${otherFacilityNameController.text}:', 'value': otherFacilityCountController.text},
            ],
          ),
      ],
    );
  }

  Widget _buildProgressStep(int step, bool completed) {
    return Column(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: completed ? Color(0xFF800080) : Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontSize: 10,
                color: completed ? Colors.white : Colors.grey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 5),
        Text(
          'S$step',
          style: TextStyle(
            fontSize: 9,
            color: completed ? Color(0xFF800080) : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplateScreen(
      title: 'Educational Facilities',
      stepNumber: 'Step 7',
      nextScreenRoute: '/drainage-waste',
      nextScreenName: 'Drainage & Waste Management',
      icon: Icons.school,
      instructions: 'Other educational facilities and type',
      contentWidget: _buildEducationalContent(),
      onSubmit: _submitForm,
      onBack: _goToPreviousScreen, onReset: () {  },
    );
  }

  @override
  void dispose() {
    numAnganwadiController.dispose();
    numShikshaGuaranteeController.dispose();
    otherFacilityNameController.dispose();
    otherFacilityCountController.dispose();
    super.dispose();
  }
}