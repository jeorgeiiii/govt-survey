import 'package:flutter/material.dart';
import '../form_template.dart'; // Import the form template
import 'crop_productivity_screen.dart';
import 'educational_facilities_screen.dart'; // Import the previous screen

class DrainageWasteScreen extends StatefulWidget {
  @override
  _DrainageWasteScreenState createState() => _DrainageWasteScreenState();
}

class _DrainageWasteScreenState extends State<DrainageWasteScreen> {
  // Controllers
  final TextEditingController drainageRemarksController = TextEditingController();
  final TextEditingController wasteRemarksController = TextEditingController();
  
  // Dropdown value
  String? _selectedDrainageType;
  final List<String> _drainageOptions = [
    'Earthen Drain',
    'Masonry Drain',
    'No Drainage System',
  ];
  
  // Boolean states
  bool _hasWasteCollection = false;
  bool _hasWasteSegregated = false;
  bool _hasSoakPitsToilets = false;
  bool _hasSoakPitsDrains = false;

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CropProductivityScreen()),
    );
  }

  void _goToPreviousScreen() {
    // Navigate back to EducationalFacilitiesScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => EducationalFacilitiesScreen()),
    );
  }

  Widget _buildDrainageContent() {
    return Column(
      children: [
        // Drainage System Section
        QuestionCard(
          question: '8a) Type of drainage system',
          description: 'Select the type of drainage system in the village',
          child: Column(
            children: [
              DropdownInput(
                label: 'Drainage System Type',
                value: _selectedDrainageType,
                items: _drainageOptions,
                prefixIcon: Icons.water_damage,
                onChanged: (value) {
                  setState(() {
                    _selectedDrainageType = value;
                  });
                },
              ),
              SizedBox(height: 15),
              TextInput(
                label: 'Remarks about drainage system',
                controller: drainageRemarksController,
                prefixIcon: Icons.note,
                isRequired: false,
              ),
            ],
          ),
        ),
        
        SizedBox(height: 25),
        
        // Waste Disposal Section
        QuestionCard(
          question: '8b) Waste Disposal',
          description: 'Waste management practices in the village',
          child: Column(
            children: [
              RadioOptionGroup(
                label: 'Waste Collection',
                options: ['Yes', 'No'],
                selectedValue: _hasWasteCollection ? 'Yes' : 'No',
                onChanged: (value) {
                  setState(() {
                    _hasWasteCollection = value == 'Yes';
                  });
                },
              ),
              
              SizedBox(height: 15),
              
              RadioOptionGroup(
                label: 'Waste Segregated',
                options: ['Yes', 'No'],
                selectedValue: _hasWasteSegregated ? 'Yes' : 'No',
                onChanged: (value) {
                  setState(() {
                    _hasWasteSegregated = value == 'Yes';
                  });
                },
              ),
              
              SizedBox(height: 15),
              
              RadioOptionGroup(
                label: 'Soak Pits for Toilets',
                options: ['Yes', 'No'],
                selectedValue: _hasSoakPitsToilets ? 'Yes' : 'No',
                onChanged: (value) {
                  setState(() {
                    _hasSoakPitsToilets = value == 'Yes';
                  });
                },
              ),
              
              SizedBox(height: 15),
              
              RadioOptionGroup(
                label: 'Soak Pits for Drains',
                options: ['Yes', 'No'],
                selectedValue: _hasSoakPitsDrains ? 'Yes' : 'No',
                onChanged: (value) {
                  setState(() {
                    _hasSoakPitsDrains = value == 'Yes';
                  });
                },
              ),
              
              SizedBox(height: 15),
              
              TextInput(
                label: 'Remarks about waste management',
                controller: wasteRemarksController,
                prefixIcon: Icons.note,
                isRequired: false,
              ),
            ],
          ),
        ),
        
        SizedBox(height: 20),
        
        // Summary Card
        if (_selectedDrainageType != null || 
            drainageRemarksController.text.isNotEmpty ||
            _hasWasteCollection || 
            _hasWasteSegregated || 
            _hasSoakPitsToilets || 
            _hasSoakPitsDrains ||
            wasteRemarksController.text.isNotEmpty)
          SummaryCard(
            title: '🚰 Drainage & Waste Summary',
            items: [
              if (_selectedDrainageType != null) 
                {'label': 'Drainage System:', 'value': _selectedDrainageType!},
              if (drainageRemarksController.text.isNotEmpty) 
                {'label': 'Drainage Remarks:', 'value': drainageRemarksController.text},
              {'label': 'Waste Collection:', 'value': _hasWasteCollection ? 'Yes' : 'No'},
              {'label': 'Waste Segregated:', 'value': _hasWasteSegregated ? 'Yes' : 'No'},
              {'label': 'Soak Pits (Toilets):', 'value': _hasSoakPitsToilets ? 'Yes' : 'No'},
              {'label': 'Soak Pits (Drains):', 'value': _hasSoakPitsDrains ? 'Yes' : 'No'},
              if (wasteRemarksController.text.isNotEmpty) 
                {'label': 'Waste Remarks:', 'value': wasteRemarksController.text},
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplateScreen(
      title: 'Drainage & Waste Management',
      stepNumber: 'Step 8',
      nextScreenRoute: '/crop-productivity',
      nextScreenName: 'Crop Productivity',
      icon: Icons.water_damage,
      instructions: 'Drainage system and waste disposal practices',
      contentWidget: _buildDrainageContent(),
      onSubmit: _submitForm,
      onBack: _goToPreviousScreen, onReset: () {  },
    );
  }

  @override
  void dispose() {
    drainageRemarksController.dispose();
    wasteRemarksController.dispose();
    super.dispose();
  }
}