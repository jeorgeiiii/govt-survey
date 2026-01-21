import 'package:flutter/material.dart';
import '../table_template.dart'; // This template now has onBack
import 'transportation_screen.dart';
import 'irrigation_facilities_screen.dart'; // Import the previous screen

class AnimalsFisheriesScreen extends StatefulWidget {
  @override
  _AnimalsFisheriesScreenState createState() => _AnimalsFisheriesScreenState();
}

class _AnimalsFisheriesScreenState extends State<AnimalsFisheriesScreen> {
  final Map<String, Map<String, TextEditingController>> animalsData = {
    'Cattle': {'num': TextEditingController(), 'breed': TextEditingController()},
    'Buffalo': {'num': TextEditingController(), 'breed': TextEditingController()},
    'Goat': {'num': TextEditingController(), 'breed': TextEditingController()},
    'Sheep': {'num': TextEditingController(), 'breed': TextEditingController()},
    'Pig': {'num': TextEditingController(), 'breed': TextEditingController()},
    'Poultry': {'num': TextEditingController(), 'breed': TextEditingController()},
    'Bullocks': {'num': TextEditingController(), 'breed': TextEditingController()},
    'Fisheries': {'num': TextEditingController(), 'breed': TextEditingController()},
    'Other': {'num': TextEditingController(), 'breed': TextEditingController()},
  };

  void _goToPreviousScreen() {
    // Navigate back to IrrigationFacilitiesScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => IrrigationFacilitiesScreen()),
    );
  }

  Widget _buildAnimalsContent() {
    // Calculate total animals
    int totalAnimals = 0;
    animalsData.forEach((animal, controllers) {
      if (animal != 'Fisheries' && animal != 'Other') {
        totalAnimals += int.tryParse(controllers['num']!.text) ?? 0;
      }
    });

    return Column(
      children: [
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Table Header
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
                        flex: 2,
                        child: Text(
                          'Animal',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Number',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Breed',
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
                
                // Table Rows
                ...animalsData.entries.map((entry) => Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(entry.key),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: TextFormField(
                            controller: entry.value['num'],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '0',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: TextFormField(
                            controller: entry.value['breed'],
                            decoration: InputDecoration(
                              hintText: 'Breed',
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
        ),
        
        SizedBox(height: 20),
        
        // Total Animals Display
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xFF800080),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.pets, color: Colors.white, size: 28),
              SizedBox(width: 15),
              Expanded(
                child: Text(
                  'Total Animals',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                totalAnimals.toString(),
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        
        SizedBox(height: 20),
        
        // Note
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber.shade800, size: 20),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Enter 0 if none. For "Other", specify breed type.',
                  style: TextStyle(
                    color: Colors.amber.shade800,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return TemplateScreen(
      title: 'Animals and Fisheries',
      stepNumber: 'Step 16',
      nextScreenRoute: '/transportation',
      nextScreenName: 'Transportation',
      icon: Icons.pets,
      contentWidget: _buildAnimalsContent(),
      onBack: _goToPreviousScreen, // ✅ This will work now
    );
  }

  @override
  void dispose() {
    animalsData.forEach((_, c) {
      c['num']!.dispose();
      c['breed']!.dispose();
    });
    super.dispose();
  }
}