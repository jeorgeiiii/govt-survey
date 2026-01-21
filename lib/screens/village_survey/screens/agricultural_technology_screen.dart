import 'package:flutter/material.dart';
import 'seed_clubs_screen.dart'; // Import the previous screen (changed from organic_manure)
import 'agricultural_implements_screen.dart';

class AgriculturalTechnologyScreen extends StatefulWidget {
  @override
  _AgriculturalTechnologyScreenState createState() => _AgriculturalTechnologyScreenState();
}

class _AgriculturalTechnologyScreenState extends State<AgriculturalTechnologyScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController traditionalController = TextEditingController();
  final TextEditingController improvedController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      int traditional = int.tryParse(traditionalController.text) ?? 0;
      int improved = int.tryParse(improvedController.text) ?? 0;
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Data Saved'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Traditional: $traditional families'),
              Text('Improved: $improved families'),
              Text('Total: ${traditional + improved} families'),
              if (improved > traditional) 
                Text('\nMore families using improved technology ✅', style: TextStyle(color: Colors.green)),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Edit')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => AgriculturalImplementsScreen()));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data saved!')));
              },
              child: Text('Continue'),
            ),
          ],
        ),
      );
    }
  }

  void _goToPreviousScreen() {
    // Navigate back to SeedClubsScreen (changed from OrganicManureScreen)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SeedClubsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header
            Container(
              height: 100,
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Government of India', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF003366))),
                  Text('Digital India', style: TextStyle(fontSize: 16, color: Colors.orange)),
                ],
              ),
            ),
            
            Container(
              padding: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Icon(Icons.engineering, color: Color(0xFF800080)),
                              SizedBox(width: 10),
                              Text('Agricultural Technology', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ]),
                            SizedBox(height: 8),
                            Text('Step 21: Families using agricultural technology'),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Traditional Input
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Traditional (ITK)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: traditionalController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Families using traditional methods',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) => value!.isEmpty ? 'Required' : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Improved Input
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Improved Technology', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: improvedController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'Families using improved technology',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) => value!.isEmpty ? 'Required' : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Buttons - Previous and Continue
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _goToPreviousScreen,
                            icon: Icon(Icons.arrow_back),
                            label: Text('Previous'),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              side: BorderSide(color: Color(0xFF800080)),
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _submitForm,
                            icon: Icon(Icons.arrow_forward),
                            label: Text('Save & Continue'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF800080),
                              padding: EdgeInsets.symmetric(vertical: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Navigation Progress
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.arrow_back, color: Colors.blue.shade800, size: 16),
                              SizedBox(width: 10),
                              Text('Previous: Seed Clubs', // Changed from Organic Manure
                                style: TextStyle(color: Colors.blue.shade800)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.navigate_next, color: Colors.green, size: 16),
                              SizedBox(width: 10),
                              Text('Next: Agricultural Implements', 
                                style: TextStyle(color: Colors.green)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    traditionalController.dispose();
    improvedController.dispose();
    super.dispose();
  }
}