import 'package:flutter/material.dart';
import '../form_template.dart'; // Import the form template
import 'animals_fisheries_screen.dart';
import 'kitchen_gardens_screen.dart'; // Import the previous screen

class IrrigationFacilitiesScreen extends StatefulWidget {
  @override
  _IrrigationFacilitiesScreenState createState() => _IrrigationFacilitiesScreenState();
}

class _IrrigationFacilitiesScreenState extends State<IrrigationFacilitiesScreen> {
  // Checkbox states
  bool _hasCanal = false;
  bool _hasTubeWell = false;
  bool _hasPonds = false;
  bool _hasRiver = false;
  bool _hasWell = false;

  // Calculate total facilities
  int get _totalFacilities => 
      [_hasCanal, _hasTubeWell, _hasPonds, _hasRiver, _hasWell]
        .where((v) => v).length;

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AnimalsFisheriesScreen()),
    );
  }

  void _goToPreviousScreen() {
    // Navigate back to KitchenGardensScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => KitchenGardensScreen()),
    );
  }

  Widget _buildIrrigationContent() {
    return Column(
      children: [
        // Facilities List
        QuestionCard(
          question: 'Available irrigation facilities',
          description: 'Select all that apply',
          child: Column(
            children: [
              CheckboxList(
                label: '',
                items: {
                  'Canal': _hasCanal,
                  'Tube Well/Bore Well': _hasTubeWell,
                  'Ponds': _hasPonds,
                  'River': _hasRiver,
                  'Well': _hasWell,
                },
                onChanged: (items) {
                  setState(() {
                    _hasCanal = items['Canal'] ?? false;
                    _hasTubeWell = items['Tube Well/Bore Well'] ?? false;
                    _hasPonds = items['Ponds'] ?? false;
                    _hasRiver = items['River'] ?? false;
                    _hasWell = items['Well'] ?? false;
                  });
                },
              ),
            ],
          ),
        ),
        
        SizedBox(height: 20),
        
        // Total Facilities Display
        CalculatedDisplay(
          label: 'Total Irrigation Facilities',
          value: _totalFacilities.toString(),
          description: 'Selected facilities count',
          icon: Icons.water,
          color: Color(0xFF2196F3), // Blue color for water
        ),
        
        SizedBox(height: 20),
        
        // Summary Card
        if (_totalFacilities > 0)
          SummaryCard(
            title: 'Irrigation Facilities Summary',
            items: [
              if (_hasCanal) {'label': 'Canal:', 'value': 'Available'},
              if (_hasTubeWell) {'label': 'Tube Well/Bore Well:', 'value': 'Available'},
              if (_hasPonds) {'label': 'Ponds:', 'value': 'Available'},
              if (_hasRiver) {'label': 'River:', 'value': 'Available'},
              if (_hasWell) {'label': 'Well:', 'value': 'Available'},
              {'label': 'Total Facilities:', 'value': _totalFacilities.toString()},
            ],
          ),
        
        // Warning if no facilities
        if (_totalFacilities == 0)
          WarningAlert(
            message: 'No irrigation facilities selected',
            icon: Icons.warning,
            color: Colors.orange,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplateScreen(
      title: 'Irrigation Facilities',
      stepNumber: 'Step 15',
      nextScreenRoute: '/animals-fisheries',
      nextScreenName: 'Animals/Fisheries',
      icon: Icons.water,
      instructions: 'Available irrigation facilities',
      contentWidget: _buildIrrigationContent(),
      onSubmit: _submitForm,
      onBack: _goToPreviousScreen, onReset: () {  },
    );
  }
}