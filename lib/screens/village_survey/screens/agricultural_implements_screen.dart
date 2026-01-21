import 'package:flutter/material.dart';
import 'agricultural_technology_screen.dart'; // Import the previous screen
import 'signboards_screen.dart';

class AgriculturalImplementsScreen extends StatefulWidget {
  @override
  _AgriculturalImplementsScreenState createState() => _AgriculturalImplementsScreenState();
}

class _AgriculturalImplementsScreenState extends State<AgriculturalImplementsScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final Map<String, bool> implements = {
    'Tractor': false,
    'Duster': false,
    'Sprayer': false,
    'Thresher': false,
    'Seed Drill': false,
    'Diesel pump': false,
  };

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      int availableCount = implements.values.where((v) => v).length;
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF800080)),
              SizedBox(width: 10),
              Text('Data Saved'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$availableCount of 6 implements selected'),
              SizedBox(height: 15),
              if (availableCount > 0)
                Column(
                  children: implements.entries
                      .where((e) => e.value)
                      .map((e) => ListTile(
                        leading: Icon(Icons.check, color: Colors.green),
                        title: Text(e.key),
                      ))
                      .toList(),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Edit'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignboardsScreen()));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Data saved! Moving to Signboards')),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF800080)),
              child: Text('Continue'),
            ),
          ],
        ),
      );
    }
  }

  void _goToPreviousScreen() {
    // Navigate back to AgriculturalTechnologyScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AgriculturalTechnologyScreen()),
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
                  Text('Digital India - Power To Empower', style: TextStyle(fontSize: 16, color: Colors.orange)),
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
                    // Title Card
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.build, color: Color(0xFF800080)),
                                SizedBox(width: 10),
                                Text('Agricultural Implements', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF800080))),
                              ],
                            ),
                            SizedBox(height: 8),
                            Text('Step 22: Availability of agricultural implements'),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Implements List
                    Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Select available implements:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                            SizedBox(height: 10),
                            ...implements.entries.map((entry) => CheckboxListTile(
                              title: Text(entry.key),
                              value: entry.value,
                              onChanged: (val) => setState(() => implements[entry.key] = val ?? false),
                              activeColor: Color(0xFF800080),
                            )).toList(),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Summary
                    Card(
                      color: Colors.green.shade50,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Selected: ${implements.values.where((v) => v).length} of 6'),
                            SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: implements.entries
                                  .where((e) => e.value)
                                  .map((e) => Chip(label: Text(e.key)))
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 30),
                    
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
                              Text('Previous: Agricultural Technology', 
                                style: TextStyle(color: Colors.blue.shade800)),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.navigate_next, color: Colors.green, size: 16),
                              SizedBox(width: 10),
                              Text('Next: Signboards', 
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
}