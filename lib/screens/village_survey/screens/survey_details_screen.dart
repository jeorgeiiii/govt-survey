import 'package:flutter/material.dart';
import 'social_map_screen.dart'; // Import the previous screen
import 'detailed_map_screen.dart';

class SurveyDetailsScreen extends StatefulWidget {
  @override
  _SurveyDetailsScreenState createState() => _SurveyDetailsScreenState();
}

class _SurveyDetailsScreenState extends State<SurveyDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Reduced list of main categories
  final Map<String, TextEditingController> surveyDetails = {
    'Forest': TextEditingController(),
    'Wasteland': TextEditingController(),
    'Garden/Orchard': TextEditingController(),
    'Burial Ground': TextEditingController(),
    'Crop Plants': TextEditingController(),
    'Vegetables': TextEditingController(),
    'Fruit Trees': TextEditingController(),
    'Animals': TextEditingController(),
    'Birds': TextEditingController(),
    'Local Biodiversity': TextEditingController(),
    'Traditional Knowledge': TextEditingController(),
    'Special Features': TextEditingController(),
  };

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    int detailsWithData = surveyDetails.values
        .where((controller) => controller.text.isNotEmpty).length;
    
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
            Text('Continue to Detailed Map?'),
            SizedBox(height: 10),
            Text('Categories documented: $detailsWithData',
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
                MaterialPageRoute(builder: (context) => DetailedMapScreen())
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
    // Navigate back to SocialMapScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SocialMapScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(children: [
        // Header
        Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          color: Colors.white,
          child: Column(children: [
            Text('Government of India', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF003366)
            )),
            SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Digital India', style: TextStyle(
                  fontSize: 14, color: Color(0xFFFF9933), fontWeight: FontWeight.w600
                )),
                SizedBox(width: 6),
                Text('Power To Empower', style: TextStyle(
                  fontSize: 12, color: Color(0xFF138808), fontStyle: FontStyle.italic
                )),
              ],
            ),
          ]),
        ),

        // Main Content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Form Header
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Icon(Icons.assignment, color: Color(0xFF800080), size: 24),
                            SizedBox(width: 8),
                            Text('Survey Details', style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF800080)
                            )),
                          ]),
                          SizedBox(height: 4),
                          Text('Step 28: Survey information'),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Instructions
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.blue.shade100),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.blue.shade800, size: 16),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Document survey details for each category. Enter "None" or leave blank if not applicable.',
                            style: TextStyle(fontSize: 11, color: Colors.blue.shade800),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 10),

                  // Survey Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 6,
                      mainAxisSpacing: 6,
                      childAspectRatio: 1.8, // Reduced aspect ratio
                    ),
                    itemCount: surveyDetails.length,
                    itemBuilder: (context, index) {
                      String category = surveyDetails.keys.elementAt(index);
                      TextEditingController controller = surveyDetails[category]!;
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                        padding: EdgeInsets.all(6), // Reduced padding
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              category,
                              style: TextStyle(
                                fontSize: 11, // Smaller font
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 3), // Reduced spacing
                            Expanded(
                              child: TextFormField(
                                controller: controller,
                                decoration: InputDecoration(
                                  hintText: 'Details',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 8, 
                                    vertical: 6
                                  ),
                                  isDense: true,
                                ),
                                style: TextStyle(fontSize: 11), // Smaller font
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  SizedBox(height: 20),

                  // Buttons - Previous and Continue
                  Row(children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _goToPreviousScreen,
                        icon: Icon(Icons.arrow_back, size: 16),
                        label: Text('Previous'),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          side: BorderSide(color: Color(0xFF800080)),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _submitForm,
                        icon: Icon(Icons.arrow_forward, size: 16),
                        label: Text('Save & Continue'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF800080),
                          padding: EdgeInsets.symmetric(vertical: 12),
                        ),
                      ),
                    ),
                  ]),

                  SizedBox(height: 12),

                  // Navigation Info
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Color(0xFF800080).withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Step 28: Survey information',
                          style: TextStyle(fontSize: 12, color: Color(0xFF800080), fontWeight: FontWeight.w600)),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.arrow_back, color: Colors.blue.shade800, size: 14),
                            SizedBox(width: 4),
                            Text('Previous: Social Map', 
                              style: TextStyle(fontSize: 11, color: Colors.blue.shade800)),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(Icons.navigate_next, color: Colors.green, size: 14),
                            SizedBox(width: 4),
                            Text('Next: Detailed Map', 
                              style: TextStyle(fontSize: 11, color: Colors.green.shade800)),
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
    surveyDetails.forEach((_, controller) => controller.dispose());
    super.dispose();
  }
}