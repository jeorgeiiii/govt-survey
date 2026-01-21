import 'package:flutter/material.dart';
import '../form_template.dart';
import 'infrastructure_screen.dart';
import 'farm_families_screen.dart'; // Import the previous screen

class HousingScreen extends StatefulWidget {
  @override
  _HousingScreenState createState() => _HousingScreenState();
}

class _HousingScreenState extends State<HousingScreen> {
  // Housing controllers
  final TextEditingController hutsController = TextEditingController();
  final TextEditingController kachaController = TextEditingController();
  final TextEditingController pakkaController = TextEditingController();
  final TextEditingController kachaPakkaController = TextEditingController();
  final TextEditingController pmAwasController = TextEditingController();
  final TextEditingController solarLightController = TextEditingController();
  
  String totalHouses = '0';

  void _calculateTotalHouses() {
    int huts = int.tryParse(hutsController.text) ?? 0;
    int kacha = int.tryParse(kachaController.text) ?? 0;
    int pakka = int.tryParse(pakkaController.text) ?? 0;
    int kachaPakka = int.tryParse(kachaPakkaController.text) ?? 0;
    
    setState(() {
      totalHouses = (huts + kacha + pakka + kachaPakka).toString();
    });
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InfrastructureScreen()),
    );
  }

  void _goToPreviousScreen() {
    // Navigate back to FarmFamiliesScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => FarmFamiliesScreen()),
    );
  }

  Widget _buildHousingContent() {
    return Column(
      children: [
        // Housing Types Section
        QuestionCard(
          question: '🏠 Types of Houses *',
          description: 'Enter number of families for each housing type',
          child: Column(
            children: [
              NumberInput(
                label: 'Huts',
                controller: hutsController,
                prefixIcon: Icons.house_siding,
                onChanged: (value) => _calculateTotalHouses(),
              ),
              SizedBox(height: 15),
              NumberInput(
                label: 'Kacha (Earthen House)',
                controller: kachaController,
                prefixIcon: Icons.landscape,
                onChanged: (value) => _calculateTotalHouses(),
              ),
              SizedBox(height: 15),
              NumberInput(
                label: 'Pakka (Brick House)',
                controller: pakkaController,
                prefixIcon: Icons.domain,
                onChanged: (value) => _calculateTotalHouses(),
              ),
              SizedBox(height: 15),
              NumberInput(
                label: 'Kacha/Pakka (Mixed)',
                controller: kachaPakkaController,
                prefixIcon: Icons.home_work,
                onChanged: (value) => _calculateTotalHouses(),
              ),
            ],
          ),
        ),
        
        // Total Houses Display
        CalculatedDisplay(
          label: 'Total Houses',
          value: totalHouses,
          description: 'Sum of all housing types',
          icon: Icons.home,
        ),
        
        SizedBox(height: 20),
        
        // Government Schemes
        QuestionCard(
          question: '🏛️ Government Schemes',
          description: 'Number of families benefiting from government schemes',
          child: Column(
            children: [
              NumberInput(
                label: 'PM Awas Yojana',
                controller: pmAwasController,
                prefixIcon: Icons.verified_user,
                isRequired: false,
              ),
              SizedBox(height: 15),
              NumberInput(
                label: 'Solar Light',
                controller: solarLightController,
                prefixIcon: Icons.lightbulb,
                isRequired: false,
              ),
            ],
          ),
        ),
        
        // Summary Card
        if (totalHouses != '0')
          SummaryCard(
            title: '📊 Housing Summary',
            items: [
              {'label': 'Huts:', 'value': hutsController.text.isNotEmpty ? hutsController.text : '0'},
              {'label': 'Kacha Houses:', 'value': kachaController.text.isNotEmpty ? kachaController.text : '0'},
              {'label': 'Pakka Houses:', 'value': pakkaController.text.isNotEmpty ? pakkaController.text : '0'},
              {'label': 'Kacha/Pakka:', 'value': kachaPakkaController.text.isNotEmpty ? kachaPakkaController.text : '0'},
              if (pmAwasController.text.isNotEmpty) 
                {'label': 'PM Awas Yojana:', 'value': pmAwasController.text},
              if (solarLightController.text.isNotEmpty) 
                {'label': 'Solar Light:', 'value': solarLightController.text},
              {'label': 'Total Houses:', 'value': totalHouses},
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplateScreen(
      title: 'Housing Information',
      stepNumber: 'Step 4',
      nextScreenRoute: '/infrastructure',
      nextScreenName: 'Infrastructure',
      icon: Icons.house,
      instructions: 'No. of Families Possessing Different Types of Houses',
      contentWidget: _buildHousingContent(),
      onSubmit: _submitForm,
      onBack: _goToPreviousScreen, onReset: () {  }, // Add back button callback
    );
  }

  @override
  void dispose() {
    hutsController.dispose();
    kachaController.dispose();
    pakkaController.dispose();
    kachaPakkaController.dispose();
    pmAwasController.dispose();
    solarLightController.dispose();
    super.dispose();
  }
}