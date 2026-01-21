import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'social_consciousness_screen.dart'; // Import the previous screen
import 'survey_details_screen.dart';

class SocialMapScreen extends StatefulWidget {
  @override
  _SocialMapScreenState createState() => _SocialMapScreenState();
}

class _SocialMapScreenState extends State<SocialMapScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();

  final Map<String, XFile?> _mapImages = {
    'Topography & Hydrology': null,
    'Enterprise Map': null,
    'Village': null,
    'Venn Diagram': null,
    'Cadastral Map': null,
    'Transect Map': null,
  };

  Future<void> _pickImage(String component) async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      maxHeight: 1080,
      imageQuality: 85,
    );

    if (image != null) {
      setState(() => _mapImages[component] = image);
    }
  }

  void _removeImage(String component) {
    setState(() => _mapImages[component] = null);
  }

  void _submitForm() {
    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    int imagesUploaded = _mapImages.values
        .where((image) => image != null)
        .length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Color(0xFF800080)),
            SizedBox(width: 8),
            Text('Data Saved'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Continue to Survey Details?'),
            SizedBox(height: 10),
            Text(
              'Images: $imagesUploaded',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF800080),
              ),
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SurveyDetailsScreen()),
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
    // Navigate back to SocialConsciousnessScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SocialConsciousnessScreen()),
    );
  }

  Widget _buildImageUploader(String title, String component) {
    XFile? image = _mapImages[component];

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF800080),
            ),
          ),
          SizedBox(height: 6),

          if (image == null)
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: InkWell(
                onTap: () => _pickImage(component),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate,
                      size: 32,
                      color: Colors.grey.shade500,
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Upload image',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    image: DecorationImage(
                      image: FileImage(File(image.path)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: GestureDetector(
                    onTap: () => _removeImage(component),
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.close, color: Colors.white, size: 14),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(vertical: 12),
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  'Government of India',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF003366),
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Digital India',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFFF9933),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Power To Empower',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF138808),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  // Form Header
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.map, color: Color(0xFF800080)),
                              SizedBox(width: 8),
                              Text(
                                'Social Map',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF800080),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text('Step 27: Upload map images'),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 15),

                  // Image Uploaders
                  ..._mapImages.keys
                      .map(
                        (component) =>
                            _buildImageUploader(component, component),
                      )
                      .toList(),

                  SizedBox(height: 20),

                  // Buttons - Previous and Continue
                  Row(
                    children: [
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
                    ],
                  ),

                  SizedBox(height: 12),

                  // Navigation Info
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: Color(0xFF800080).withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Step 27: Social map images',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF800080),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.blue.shade800,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Previous: Social Consciousness',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.blue.shade800,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(
                              Icons.navigate_next,
                              color: Colors.green,
                              size: 14,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Next: Survey Details',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.green.shade800,
                              ),
                            ),
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
    );
  }
}