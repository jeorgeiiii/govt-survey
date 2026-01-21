import 'package:flutter/material.dart';
import '../form_template.dart'; // Import the form template
import 'housing_screen.dart';
import 'population_form_screen.dart'; // Import the previous screen

class FarmFamiliesScreen extends StatefulWidget {
  @override
  _FarmFamiliesScreenState createState() => _FarmFamiliesScreenState();
}

class _FarmFamiliesScreenState extends State<FarmFamiliesScreen> {
  // Farm families fields
  String _bigFarmers = '';
  String _smallFarmers = '';
  String _marginalFarmers = '';
  String _landlessFarmers = '';
  String _totalFarmFamilies = '';
  
  // Controllers for form fields
  final TextEditingController bigFarmersController = TextEditingController();
  final TextEditingController smallFarmersController = TextEditingController();
  final TextEditingController marginalFarmersController = TextEditingController();
  final TextEditingController landlessFarmersController = TextEditingController();

  // Auto-calculate total
  void _calculateTotal() {
    int big = int.tryParse(bigFarmersController.text) ?? 0;
    int small = int.tryParse(smallFarmersController.text) ?? 0;
    int marginal = int.tryParse(marginalFarmersController.text) ?? 0;
    int landless = int.tryParse(landlessFarmersController.text) ?? 0;
    
    int total = big + small + marginal + landless;
    
    setState(() {
      _totalFarmFamilies = total.toString();
      _bigFarmers = big.toString();
      _smallFarmers = small.toString();
      _marginalFarmers = marginal.toString();
      _landlessFarmers = landless.toString();
    });
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HousingScreen()),
    );
  }

  void _goToPreviousScreen() {
    // Navigate back to PopulationFormScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => PopulationFormScreen()),
    );
  }

  Widget _buildFarmContent() {
    return Column(
      children: [
        // Big Farmers (> 5 Hectare)
        QuestionCard(
          question: '🚜 Big Farmers (Landholding > 5 Hectare) *',
          description: 'Farmers with landholding more than 5 hectares',
          child: NumberInput(
            label: 'Enter number of big farmers',
            controller: bigFarmersController,
            prefixIcon: Icons.agriculture,
            onChanged: (value) => _calculateTotal(),
          ),
        ),
        
        SizedBox(height: 20),
        
        // Small Farmers (1-5 Hectare)
        QuestionCard(
          question: '🌾 Small Farmers (Landholding 1-5 Hectare) *',
          description: 'Farmers with landholding between 1 to 5 hectares',
          child: NumberInput(
            label: 'Enter number of small farmers',
            controller: smallFarmersController,
            prefixIcon: Icons.grass,
            onChanged: (value) => _calculateTotal(),
          ),
        ),
        
        SizedBox(height: 20),
        
        // Marginal Farmers (Upto 1 Hectare)
        QuestionCard(
          question: '🌱 Marginal Farmers (Upto 1 Hectare) *',
          description: 'Farmers with landholding up to 1 hectare',
          child: NumberInput(
            label: 'Enter number of marginal farmers',
            controller: marginalFarmersController,
            prefixIcon: Icons.spa,
            onChanged: (value) => _calculateTotal(),
          ),
        ),
        
        SizedBox(height: 20),
        
        // Landless Families
        QuestionCard(
          question: '👨‍🌾 Landless Families *',
          description: 'Families without agricultural land',
          child: NumberInput(
            label: 'Enter number of landless families',
            controller: landlessFarmersController,
            prefixIcon: Icons.person_outline,
            onChanged: (value) => _calculateTotal(),
          ),
        ),
        
        SizedBox(height: 25),
        
        // Total Farm Families Display
        CalculatedDisplay(
          label: 'Total Farm Families',
          value: _totalFarmFamilies.isNotEmpty ? _totalFarmFamilies : '0',
          description: 'Auto-calculated sum of all categories',
          icon: Icons.calculate,
        ),
        
        SizedBox(height: 20),
        
        // Category Breakdown
        if (_totalFarmFamilies != '0')
          Container(
            padding: EdgeInsets.all(15),
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              color: Color(0xFF800080).withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFF800080).withOpacity(0.3)),
            ),
            child: Column(
              children: [
                Text(
                  'Category Breakdown',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF800080),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCategoryCount('Big', bigFarmersController.text),
                    _buildCategoryCount('Small', smallFarmersController.text),
                    _buildCategoryCount('Marginal', marginalFarmersController.text),
                    _buildCategoryCount('Landless', landlessFarmersController.text),
                  ],
                ),
              ],
            ),
          ),
        
        // Summary Card
        if (_totalFarmFamilies != '0')
          SummaryCard(
            title: '📊 Farm Families Summary',
            items: [
              {'label': 'Big Farmers (> 5 Ha):', 'value': bigFarmersController.text.isNotEmpty ? bigFarmersController.text : '0'},
              {'label': 'Small Farmers (1-5 Ha):', 'value': smallFarmersController.text.isNotEmpty ? smallFarmersController.text : '0'},
              {'label': 'Marginal Farmers (≤ 1 Ha):', 'value': marginalFarmersController.text.isNotEmpty ? marginalFarmersController.text : '0'},
              {'label': 'Landless Families:', 'value': landlessFarmersController.text.isNotEmpty ? landlessFarmersController.text : '0'},
              {'label': 'Total Farm Families:', 'value': _totalFarmFamilies},
            ],
          ),
      ],
    );
  }

  Widget _buildCategoryCount(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Color(0xFF800080),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value.isEmpty ? '0' : value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Color(0xFF800080),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplateScreen(
      title: 'Farm Families Information',
      stepNumber: 'Step 3',
      nextScreenRoute: '/housing',
      nextScreenName: 'Housing Details',
      icon: Icons.agriculture,
      instructions: 'Enter farm families by landholding categories',
      contentWidget: _buildFarmContent(),
      onSubmit: _submitForm,
      onBack: _goToPreviousScreen, onReset: () {  },
    );
  }

  @override
  void dispose() {
    bigFarmersController.dispose();
    smallFarmersController.dispose();
    marginalFarmersController.dispose();
    landlessFarmersController.dispose();
    super.dispose();
  }
}