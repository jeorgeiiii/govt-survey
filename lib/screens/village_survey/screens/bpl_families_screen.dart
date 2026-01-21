import 'package:flutter/material.dart';
import '../form_template.dart'; // Import the form template
import 'traditional_occupations_screen.dart';
import 'crop_productivity_screen.dart'; // Import the previous screen

class BPLFamiliesScreen extends StatefulWidget {
  @override
  _BPLFamiliesScreenState createState() => _BPLFamiliesScreenState();
}

class _BPLFamiliesScreenState extends State<BPLFamiliesScreen> {
  // Controllers
  final TextEditingController totalFamiliesController = TextEditingController();
  final TextEditingController bplFamiliesController = TextEditingController();
  final TextEditingController averageIncomeController = TextEditingController();

  // Calculated values
  String _bplPercentage = '0%';
  String _warningMessage = '';

  // Calculate BPL percentage
  void _calculatePercentage() {
    int total = int.tryParse(totalFamiliesController.text) ?? 0;
    int bpl = int.tryParse(bplFamiliesController.text) ?? 0;
    
    if (total > 0) {
      double percentage = (bpl / total) * 100;
      setState(() {
        _bplPercentage = '${percentage.toStringAsFixed(1)}%';
        
        // Set warning message
        if (bpl > total) {
          _warningMessage = 'BPL families cannot exceed total families';
        } else if (percentage > 50) {
          _warningMessage = 'High poverty rate (>50%)';
        } else {
          _warningMessage = '';
        }
      });
    } else {
      setState(() {
        _bplPercentage = '0%';
        _warningMessage = '';
      });
    }
  }

  // Validate income
  bool _validateIncome() {
    double income = double.tryParse(averageIncomeController.text) ?? 0;
    return income < 27000;
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TraditionalOccupationsScreen()),
    );
  }

  void _goToPreviousScreen() {
    // Navigate back to CropProductivityScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => CropProductivityScreen()),
    );
  }

  Widget _buildBPLContent() {
    return Column(
      children: [
        // Total Families
        QuestionCard(
          question: 'Total Number of Families',
          description: 'Enter total families in village',
          child: NumberInput(
            label: 'Total families in village',
            controller: totalFamiliesController,
            prefixIcon: Icons.family_restroom,
            onChanged: (value) => _calculatePercentage(),
          ),
        ),
        
        SizedBox(height: 20),
        
        // BPL Families
        QuestionCard(
          question: 'BPL Families (Below Poverty Line)',
          description: 'Annual income less than ₹27,000',
          child: NumberInput(
            label: 'Number of BPL families',
            controller: bplFamiliesController,
            prefixIcon: Icons.money_off,
            onChanged: (value) => _calculatePercentage(),
          ),
        ),
        
        SizedBox(height: 20),
        
        // Average Annual Income
        QuestionCard(
          question: 'Average Annual Income of BPL Families',
          description: 'Average income must be less than ₹27,000',
          child: TextInput(
            label: 'Average income (must be < ₹27,000)',
            controller: averageIncomeController,
            prefixIcon: Icons.currency_rupee,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                double income = double.tryParse(value) ?? 0;
                if (income >= 27000) {
                  return 'Income must be less than ₹27,000';
                }
              }
              return null;
            },
          ),
        ),
        
        SizedBox(height: 20),
        
        // Calculation Display
        if (totalFamiliesController.text.isNotEmpty || bplFamiliesController.text.isNotEmpty)
          CalculatedDisplay(
            label: 'BPL Percentage',
            value: _bplPercentage,
            description: 'Percentage of BPL families',
            icon: Icons.calculate,
            color: _warningMessage.contains('High') ? Colors.orange : Color(0xFF800080),
          ),
        
        // Warning Messages
        if (_warningMessage.isNotEmpty)
          WarningAlert(
            message: _warningMessage,
            icon: _warningMessage.contains('cannot exceed') ? Icons.error : Icons.warning,
            color: _warningMessage.contains('cannot exceed') ? Colors.red : Colors.orange,
          ),
        
        SizedBox(height: 20),
        
        // Summary Card
        if (totalFamiliesController.text.isNotEmpty || 
            bplFamiliesController.text.isNotEmpty || 
            averageIncomeController.text.isNotEmpty)
          SummaryCard(
            title: '📊 BPL Families Summary',
            items: [
              if (totalFamiliesController.text.isNotEmpty) 
                {'label': 'Total Families:', 'value': totalFamiliesController.text},
              if (bplFamiliesController.text.isNotEmpty) 
                {'label': 'BPL Families:', 'value': bplFamiliesController.text},
              {'label': 'Percentage:', 'value': _bplPercentage},
              if (averageIncomeController.text.isNotEmpty) 
                {'label': 'Avg. Annual Income:', 'value': '₹${averageIncomeController.text}'},
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplateScreen(
      title: 'BPL Families',
      stepNumber: 'Step 10',
      nextScreenRoute: '/traditional-occupations',
      nextScreenName: 'Traditional Occupations',
      icon: Icons.people,
      instructions: 'Below Poverty Line families (Income < ₹27,000 per annum)',
      contentWidget: _buildBPLContent(),
      onSubmit: _submitForm,
      onBack: _goToPreviousScreen, onReset: () {  },
    );
  }

  @override
  void dispose() {
    totalFamiliesController.dispose();
    bplFamiliesController.dispose();
    averageIncomeController.dispose();
    super.dispose();
  }
}