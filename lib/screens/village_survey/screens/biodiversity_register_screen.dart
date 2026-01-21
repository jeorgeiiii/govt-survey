import 'package:flutter/material.dart';
import 'forest_map_screen.dart'; // Import the previous screen
import 'cooking_medium_screen.dart';

class BiodiversityRegisterScreen extends StatefulWidget {
  @override
  _BiodiversityRegisterScreenState createState() => _BiodiversityRegisterScreenState();
}

class _BiodiversityRegisterScreenState extends State<BiodiversityRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController detailsController = TextEditingController();
  final TextEditingController componentsController = TextEditingController();
  final TextEditingController knowledgeController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Data Saved'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Biodiversity Register data saved.'),
              SizedBox(height: 10),
              Text('Status: ${statusController.text}'),
              Text('Components documented: Yes'),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text('Edit')),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => CookingMediumScreen()));
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
    // Navigate back to ForestMapScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ForestMapScreen()),
    );
  }

  Widget _buildInputField(String label, TextEditingController controller, {bool required = true, int lines = 1}) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF800080))),
            SizedBox(height: 8),
            TextFormField(
              controller: controller,
              maxLines: lines,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter details...',
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
              validator: required ? (value) => value!.isEmpty ? 'Required' : null : null,
            ),
          ],
        ),
      ),
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
                              Icon(Icons.eco, color: Color(0xFF800080), size: 32),
                              SizedBox(width: 12),
                              Text('People\'s Biodiversity Register (PBR)', 
                                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF800080))),
                            ]),
                            SizedBox(height: 8),
                            Text('Step 32: Documentation of Biodiversity Register in village',
                              style: TextStyle(color: Colors.grey.shade600, fontSize: 15)),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Info Card
                    Card(
                      elevation: 3,
                      color: Colors.green.shade50,
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.info_outline, color: Colors.green.shade800),
                                SizedBox(width: 10),
                                Text(
                                  'About People\'s Biodiversity Register',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green.shade800,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'PBR is a comprehensive record of local biological resources, their medicinal or any other use, or any other traditional knowledge associated with them.',
                              style: TextStyle(color: Colors.green.shade700),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Input Fields
                    _buildInputField('PBR Status (Available/Not Available)', statusController, required: true, lines: 1),
                    SizedBox(height: 15),
                    _buildInputField('Documentation Details', detailsController, required: true, lines: 3),
                    SizedBox(height: 15),
                    _buildInputField('Biodiversity Components Documented', componentsController, required: true, lines: 3),
                    SizedBox(height: 15),
                    _buildInputField('Traditional Knowledge Recorded', knowledgeController, required: false, lines: 3),
                    
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
                              padding: EdgeInsets.symmetric(vertical: 16),
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
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Progress Indicator with Navigation Info
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
                              Icon(Icons.eco, color: Color(0xFF800080), size: 24),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'Step 32: Biodiversity Register documentation',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF800080),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.arrow_back, color: Colors.blue.shade800, size: 16),
                                  SizedBox(width: 8),
                                  Text(
                                    'Previous: Forest Map',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.blue.shade800,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Icon(Icons.navigate_next, color: Colors.green, size: 16),
                                  SizedBox(width: 8),
                                  Text(
                                    'Next: Cooking Medium',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green.shade800,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 15),
                    
                    // Completion Message
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Color(0xFF800080).withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.celebration, color: Color(0xFF800080), size: 32),
                          SizedBox(height: 10),
                          Text('Almost done! Last section remaining.', 
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF800080))),
                          SizedBox(height: 5),
                          Text('Only Cooking Medium data collection left to complete the survey.',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey.shade700)),
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
    statusController.dispose();
    detailsController.dispose();
    componentsController.dispose();
    knowledgeController.dispose();
    super.dispose();
  }
}