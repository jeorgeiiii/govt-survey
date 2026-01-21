import 'package:flutter/material.dart';
import 'organic_manure_screen.dart'; // Import the previous screen
import 'agricultural_technology_screen.dart';

class SeedClubsScreen extends StatefulWidget {
  @override
  _SeedClubsScreenState createState() => _SeedClubsScreenState();
}

class _SeedClubsScreenState extends State<SeedClubsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _seedClubsController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    int seedClubs = int.tryParse(_seedClubsController.text) ?? 0;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(children: [
          Icon(Icons.check_circle, color: Color(0xFF800080)),
          SizedBox(width: 8),
          Text('Data Saved'),
        ]),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Continue to Agricultural Technology?'),
            SizedBox(height: 10),
            Text('Seed Clubs: ${_seedClubsController.text}',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF800080))
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Edit', style: TextStyle(color: Color(0xFF800080))),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(context,
                MaterialPageRoute(builder: (context) => AgriculturalTechnologyScreen())
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF800080)),
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _goToPreviousScreen() {
    // Navigate back to OrganicManureScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OrganicManureScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(children: [
        // Header
        Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          color: Colors.white,
          child: Column(children: [
            Text('Government of India', style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF003366)
            )),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Digital India', style: TextStyle(
                  fontSize: 16, color: Color(0xFFFF9933), fontWeight: FontWeight.w600
                )),
                SizedBox(width: 8),
                Text('Power To Empower', style: TextStyle(
                  fontSize: 14, color: Color(0xFF138808), fontStyle: FontStyle.italic
                )),
              ],
            ),
          ]),
        ),

        // Main Content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Form Header
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Icon(Icons.agriculture, color: Color(0xFF800080)),
                            SizedBox(width: 10),
                            Text('Seed Clubs', style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF800080)
                            )),
                          ]),
                          SizedBox(height: 5),
                          Text('Step 20: Number of seed clubs in village'),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Simple info note
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade800, size: 20),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text('Seed clubs: community groups for saving and exchanging traditional seeds',
                            style: TextStyle(fontSize: 13, color: Colors.blue.shade800)),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // Input Field
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
                        Text('Number of Seed Clubs', style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF800080)
                        )),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: _seedClubsController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Enter number (0 if none)',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                            prefixIcon: Icon(Icons.group, color: Color(0xFF800080)),
                          ),
                          validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),

                  // Buttons - Previous and Continue
                  Row(children: [
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
                    SizedBox(width: 10),
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
                  ]),

                  SizedBox(height: 15),

                  // Navigation Info
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Color(0xFF800080).withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.arrow_back, color: Colors.blue.shade800, size: 16),
                            SizedBox(width: 5),
                            Text('Previous: Organic Manure', 
                              style: TextStyle(fontSize: 12, color: Colors.blue.shade800)),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.navigate_next, color: Colors.green, size: 16),
                            SizedBox(width: 5),
                            Text('Next: Agricultural Technology', 
                              style: TextStyle(fontSize: 12, color: Colors.green.shade800)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  @override
  void dispose() {
    _seedClubsController.dispose();
    super.dispose();
  }
}