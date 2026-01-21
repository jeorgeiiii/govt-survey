import 'package:flutter/material.dart';
import 'agricultural_implements_screen.dart'; // Import the previous screen
import 'unemployment_screen.dart';

class SignboardsScreen extends StatefulWidget {
  @override
  _SignboardsScreenState createState() => _SignboardsScreenState();
}

class _SignboardsScreenState extends State<SignboardsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _signboardsController = TextEditingController();
  final _infoBoardsController = TextEditingController();
  final _wallWritingController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    int signboards = int.tryParse(_signboardsController.text) ?? 0;
    int infoBoards = int.tryParse(_infoBoardsController.text) ?? 0;
    int wallWriting = int.tryParse(_wallWritingController.text) ?? 0;
    int total = signboards + infoBoards + wallWriting;

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
            Text('Continue to Unemployment?'),
            SizedBox(height: 10),
            _buildSummary('Signboards', signboards),
            _buildSummary('Info Boards', infoBoards),
            _buildSummary('Wall-writing', wallWriting),
            SizedBox(height: 8),
            Text('Total: $total', style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF800080)
            )),
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
                MaterialPageRoute(builder: (context) => UnemploymentScreen())
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF800080)),
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }

  Widget _buildSummary(String label, int value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text('$label:', style: TextStyle(fontWeight: FontWeight.w500))),
          Text(value.toString(), style: TextStyle(color: Color(0xFF800080), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  void _goToPreviousScreen() {
    // Navigate back to AgriculturalImplementsScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AgriculturalImplementsScreen()),
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
                            Icon(Icons.info, color: Color(0xFF800080)),
                            SizedBox(width: 10),
                            Text('Signboards & Information', style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF800080)
                            )),
                          ]),
                          SizedBox(height: 5),
                          Text('Step 23: Availability of signboards'),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Input Fields
                  _buildInputField(
                    label: 'Signboards',
                    controller: _signboardsController,
                    hint: 'Direction boards, name boards, etc.',
                    icon: Icons.signpost,
                  ),

                  SizedBox(height: 15),

                  _buildInputField(
                    label: 'Information Boards',
                    controller: _infoBoardsController,
                    hint: 'Government schemes, announcements, etc.',
                    icon: Icons.newspaper,
                  ),

                  SizedBox(height: 15),

                  _buildInputField(
                    label: 'Wall-writing',
                    controller: _wallWritingController,
                    hint: 'Paintings, slogans, messages on walls',
                    icon: Icons.draw,
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
                            Text('Previous: Agricultural Implements', 
                              style: TextStyle(fontSize: 12, color: Colors.blue.shade800)),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(Icons.navigate_next, color: Colors.green, size: 16),
                            SizedBox(width: 5),
                            Text('Next: Unemployment Data', 
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

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hint,
    required IconData icon,
  }) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              prefixIcon: Icon(icon, size: 20),
            ),
            validator: (value) => value == null || value.isEmpty ? 'Required (0 if none)' : null,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _signboardsController.dispose();
    _infoBoardsController.dispose();
    _wallWritingController.dispose();
    super.dispose();
  }
}