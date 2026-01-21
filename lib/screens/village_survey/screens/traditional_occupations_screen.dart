import 'package:flutter/material.dart';
import '../form_template.dart'; // Import the form template
import 'children_not_in_school_screen.dart';
import 'bpl_families_screen.dart'; // Import the previous screen

class TraditionalOccupationsScreen extends StatefulWidget {
  @override
  _TraditionalOccupationsScreenState createState() => _TraditionalOccupationsScreenState();
}

class _TraditionalOccupationsScreenState extends State<TraditionalOccupationsScreen> {
  // Traditional occupations with their counts
  final Map<String, TextEditingController> occupations = {
    'Armourer': TextEditingController(),
    'Barber (Naai)': TextEditingController(),
    'Basket/Mat/Broom Maker/Coir Weaver': TextEditingController(),
    'Blacksmith (Lohar)': TextEditingController(),
    'Boat Maker': TextEditingController(),
    'Carpenter (Suthar/Badhai)': TextEditingController(),
    'Cobbler (Charmkar)/Shoesmith/Footwear artisan': TextEditingController(),
    'Doll & Toy Maker (Traditional)': TextEditingController(),
    'Fishing Net Maker': TextEditingController(),
    'Garland maker (Malakaar)': TextEditingController(),
    'Goldsmith (Sonar)': TextEditingController(),
    'Hammer and Tool Kit Maker': TextEditingController(),
    'Locksmith': TextEditingController(),
    'Mason (Rajmistri)': TextEditingController(),
    'Potter (Kumhaar)': TextEditingController(),
    'Sculptor (Moortikar, stone carver), Stone Breaker': TextEditingController(),
    'Tailor (Darzi)': TextEditingController(),
    'Washerman (Dhobi)': TextEditingController(),
    'Folklore Medicine (Traditional Medicine)': TextEditingController(),
  };

  // Calculated total
  String _totalOccupations = '0';

  // Calculate totals when values change
  void _calculateTotal() {
    int total = 0;
    occupations.forEach((occupation, controller) {
      int count = int.tryParse(controller.text) ?? 0;
      total += count;
    });
    
    setState(() {
      _totalOccupations = total.toString();
    });
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChildrenNotInSchoolScreen()),
    );
  }

  void _goToPreviousScreen() {
    // Navigate back to BPLFamiliesScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => BPLFamiliesScreen()),
    );
  }

  Widget _buildOccupationsContent() {
    return Column(
      children: [
        // Occupations Grid
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFF800080),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Traditional Occupation',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Count',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Occupations List
                ...occupations.entries.map((entry) {
                  int index = occupations.keys.toList().indexOf(entry.key);
                  return Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                      color: index % 2 == 0 ? Colors.white : Colors.grey.shade50,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            '${String.fromCharCode(97 + index)}) ${entry.key}',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: NumberInput(
                              label: '',
                              controller: entry.value,
                              prefixIcon: Icons.person,
                              isRequired: false,
                              onChanged: (value) => _calculateTotal(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ),
        
        SizedBox(height: 20),
        
        // Total Occupations Display
        CalculatedDisplay(
          label: 'Total Traditional Occupations',
          value: _totalOccupations,
          description: 'Sum of all traditional occupations',
          icon: Icons.handyman,
        ),
        
        SizedBox(height: 20),
        
        // Top Occupations Summary
        if (_totalOccupations != '0')
          SummaryCard(
            title: 'Top Traditional Occupations',
            items: _getTopOccupations(3).map((entry) => 
              {'label': '${entry.key}:', 'value': entry.value.toString()}
            ).toList(),
          ),
      ],
    );
  }

  List<MapEntry<String, int>> _getTopOccupations(int count) {
    List<MapEntry<String, int>> entries = [];
    occupations.forEach((occupation, controller) {
      int value = int.tryParse(controller.text) ?? 0;
      if (value > 0) {
        entries.add(MapEntry(occupation, value));
      }
    });
    
    entries.sort((a, b) => b.value.compareTo(a.value));
    return entries.take(count).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplateScreen(
      title: 'Traditional Occupations',
      stepNumber: 'Step 11',
      nextScreenRoute: '/children-not-in-school',
      nextScreenName: 'Children Not in School',
      icon: Icons.handyman,
      instructions: 'Number of traditional occupations in village',
      contentWidget: _buildOccupationsContent(),
      onSubmit: _submitForm,
      onBack: _goToPreviousScreen, onReset: () {  },
    );
  }

  @override
  void dispose() {
    occupations.forEach((_, controller) => controller.dispose());
    super.dispose();
  }
}