import 'package:flutter/material.dart';
import '../form_template.dart';
import 'farm_families_screen.dart';
import 'village_form_screen.dart'; // Import the previous screen

class PopulationFormScreen extends StatefulWidget {
  @override
  _PopulationFormScreenState createState() => _PopulationFormScreenState();
}

class _PopulationFormScreenState extends State<PopulationFormScreen> {
  // Population controllers
  final TextEditingController totalFamiliesController = TextEditingController();
  final TextEditingController menController = TextEditingController();
  final TextEditingController womenController = TextEditingController();
  final TextEditingController maleChildrenController = TextEditingController();
  final TextEditingController femaleChildrenController =
      TextEditingController();

  // Religion controllers
  final TextEditingController hindusController = TextEditingController();
  final TextEditingController muslimsController = TextEditingController();
  final TextEditingController christiansController = TextEditingController();
  final TextEditingController otherReligionsController =
      TextEditingController();

  // Caste controllers
  final TextEditingController scController = TextEditingController();
  final TextEditingController stController = TextEditingController();
  final TextEditingController obcController = TextEditingController();
  final TextEditingController generalController = TextEditingController();

  String population = '0';
  String totalMembers = '0';
  String totalReligiousPopulation = '0';
  String totalCastePopulation = '0';

  void _calculatePopulation() {
    int families = int.tryParse(totalFamiliesController.text) ?? 0;
    setState(() {
      population = (families * 4).toString();
    });
  }

  void _calculateTotalMembers() {
    int men = int.tryParse(menController.text) ?? 0;
    int women = int.tryParse(womenController.text) ?? 0;
    int maleChildren = int.tryParse(maleChildrenController.text) ?? 0;
    int femaleChildren = int.tryParse(femaleChildrenController.text) ?? 0;

    setState(() {
      totalMembers = (men + women + maleChildren + femaleChildren).toString();
    });
  }

  void _calculateReligiousPopulation() {
    int hindus = int.tryParse(hindusController.text) ?? 0;
    int muslims = int.tryParse(muslimsController.text) ?? 0;
    int christians = int.tryParse(christiansController.text) ?? 0;
    int others = int.tryParse(otherReligionsController.text) ?? 0;

    setState(() {
      totalReligiousPopulation = (hindus + muslims + christians + others)
          .toString();
    });
  }

  void _calculateCastePopulation() {
    int sc = int.tryParse(scController.text) ?? 0;
    int st = int.tryParse(stController.text) ?? 0;
    int obc = int.tryParse(obcController.text) ?? 0;
    int general = int.tryParse(generalController.text) ?? 0;

    setState(() {
      totalCastePopulation = (sc + st + obc + general).toString();
    });
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FarmFamiliesScreen()),
    );
  }

  void _goToPreviousScreen() {
    // Navigate back to VillageFormScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => VillageFormScreen()),
    );
  }

  void _resetForm() {
    setState(() {
      totalFamiliesController.clear();
      menController.clear();
      womenController.clear();
      maleChildrenController.clear();
      femaleChildrenController.clear();
      hindusController.clear();
      muslimsController.clear();
      christiansController.clear();
      otherReligionsController.clear();
      scController.clear();
      stController.clear();
      obcController.clear();
      generalController.clear();
      population = '0';
      totalMembers = '0';
      totalReligiousPopulation = '0';
      totalCastePopulation = '0';
    });
  }

  Widget _buildPopulationContent() {
    return Column(
      children: [
        // Total Families and Population
        QuestionCard(
          question: '🏠 Total Families *',
          description: 'Enter total number of families in village',
          child: Column(
            children: [
              NumberInput(
                label: 'Enter number of families',
                controller: totalFamiliesController,
                prefixIcon: Icons.family_restroom,
                onChanged: (value) => _calculatePopulation(),
              ),
              SizedBox(height: 15),
              CalculatedDisplay(
                label: 'Estimated Population',
                value: population,
                description: 'Auto-calculated (Families × 4)',
                icon: Icons.people_alt,
              ),
            ],
          ),
        ),

        // Gender Breakdown
        QuestionCard(
          question: '👥 Gender Breakdown *',
          description: 'Enter number of people in each category',
          child: Column(
            children: [
              NumberInput(
                label: '👨 Men (18+ years)',
                controller: menController,
                prefixIcon: Icons.man,
                onChanged: (value) => _calculateTotalMembers(),
              ),
              SizedBox(height: 15),
              NumberInput(
                label: '👩 Women (18+ years)',
                controller: womenController,
                prefixIcon: Icons.woman,
                onChanged: (value) => _calculateTotalMembers(),
              ),
              SizedBox(height: 15),
              NumberInput(
                label: '👦 Male Children (0-17 years)',
                controller: maleChildrenController,
                prefixIcon: Icons.boy,
                onChanged: (value) => _calculateTotalMembers(),
              ),
              SizedBox(height: 15),
              NumberInput(
                label: '👧 Female Children (0-17 years)',
                controller: femaleChildrenController,
                prefixIcon: Icons.girl,
                onChanged: (value) => _calculateTotalMembers(),
              ),
            ],
          ),
        ),

        // Total Members Display
        CalculatedDisplay(
          label: 'Total Members',
          value: totalMembers,
          description: 'Auto-calculated sum of all categories',
          icon: Icons.group,
        ),

        SizedBox(height: 20),

        // Religion Distribution
        QuestionCard(
          question: '🕌 Religion Distribution',
          description: 'Enter number of people by religion',
          child: Column(
            children: [
              NumberInput(
                label: 'Hindus',
                controller: hindusController,
                prefixIcon: Icons.temple_hindu,
                onChanged: (value) => _calculateReligiousPopulation(),
              ),
              SizedBox(height: 10),
              NumberInput(
                label: 'Muslims',
                controller: muslimsController,
                prefixIcon: Icons.mosque,
                onChanged: (value) => _calculateReligiousPopulation(),
              ),
              SizedBox(height: 10),
              NumberInput(
                label: 'Christians',
                controller: christiansController,
                prefixIcon: Icons.church,
                onChanged: (value) => _calculateReligiousPopulation(),
              ),
              SizedBox(height: 10),
              NumberInput(
                label: 'Others',
                controller: otherReligionsController,
                prefixIcon: Icons.diversity_3,
                onChanged: (value) => _calculateReligiousPopulation(),
              ),
              SizedBox(height: 15),
              CalculatedDisplay(
                label: 'Total Religious Population',
                value: totalReligiousPopulation,
                description: 'Auto-calculated sum',
                icon: Icons.calculate,
              ),
            ],
          ),
        ),

        SizedBox(height: 20),

        // Caste Distribution
        QuestionCard(
          question: '🏛️ Caste Distribution',
          description: 'Enter number of people by caste',
          child: Column(
            children: [
              NumberInput(
                label: 'Scheduled Caste (S.C.)',
                controller: scController,
                prefixIcon: Icons.assignment_ind,
                onChanged: (value) => _calculateCastePopulation(),
              ),
              SizedBox(height: 10),
              NumberInput(
                label: 'Scheduled Tribe (S.T.)',
                controller: stController,
                prefixIcon: Icons.forest,
                onChanged: (value) => _calculateCastePopulation(),
              ),
              SizedBox(height: 10),
              NumberInput(
                label: 'Other Backward Class (O.B.C.)',
                controller: obcController,
                prefixIcon: Icons.groups,
                onChanged: (value) => _calculateCastePopulation(),
              ),
              SizedBox(height: 10),
              NumberInput(
                label: 'General',
                controller: generalController,
                prefixIcon: Icons.person,
                onChanged: (value) => _calculateCastePopulation(),
              ),
              SizedBox(height: 15),
              CalculatedDisplay(
                label: 'Total Caste Population',
                value: totalCastePopulation,
                description: 'Auto-calculated sum',
                icon: Icons.calculate,
              ),
            ],
          ),
        ),

        // Summary
        if (totalMembers != '0' ||
            totalReligiousPopulation != '0' ||
            totalCastePopulation != '0')
          SummaryCard(
            title: '📊 Population Summary',
            items: [
              {
                'label': 'Total Families:',
                'value': totalFamiliesController.text.isNotEmpty
                    ? totalFamiliesController.text
                    : '0',
              },
              {'label': 'Estimated Population:', 'value': population},
              {'label': 'Total Members:', 'value': totalMembers},
              {
                'label': 'Total Religious Population:',
                'value': totalReligiousPopulation,
              },
              {
                'label': 'Total Caste Population:',
                'value': totalCastePopulation,
              },
              if (hindusController.text.isNotEmpty)
                {'label': 'Hindus:', 'value': hindusController.text},
              if (muslimsController.text.isNotEmpty)
                {'label': 'Muslims:', 'value': muslimsController.text},
              if (christiansController.text.isNotEmpty)
                {'label': 'Christians:', 'value': christiansController.text},
              if (otherReligionsController.text.isNotEmpty)
                {
                  'label': 'Other Religions:',
                  'value': otherReligionsController.text,
                },
              if (scController.text.isNotEmpty)
                {'label': 'S.C.:', 'value': scController.text},
              if (stController.text.isNotEmpty)
                {'label': 'S.T.:', 'value': stController.text},
              if (obcController.text.isNotEmpty)
                {'label': 'O.B.C.:', 'value': obcController.text},
              if (generalController.text.isNotEmpty)
                {'label': 'General:', 'value': generalController.text},
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplateScreen(
      title: 'Population Details',
      stepNumber: 'Step 2',
      nextScreenRoute: '/farm-families',
      nextScreenName: 'Farm Families',
      icon: Icons.people,
      instructions: 'Enter village population statistics',
      contentWidget: _buildPopulationContent(),
      onSubmit: _submitForm, onReset: () {  },
    );
  }

  @override
  void dispose() {
    totalFamiliesController.dispose();
    menController.dispose();
    womenController.dispose();
    maleChildrenController.dispose();
    femaleChildrenController.dispose();
    hindusController.dispose();
    muslimsController.dispose();
    christiansController.dispose();
    otherReligionsController.dispose();
    scController.dispose();
    stController.dispose();
    obcController.dispose();
    generalController.dispose();
    super.dispose();
  }
}
