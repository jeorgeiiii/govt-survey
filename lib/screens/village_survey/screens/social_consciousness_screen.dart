import 'package:flutter/material.dart';
import '../table_template.dart';
import 'social_map_screen.dart';
import 'disputes_screen.dart'; // Import the previous screen

class SocialConsciousnessScreen extends StatefulWidget {
  @override
  _SocialConsciousnessScreenState createState() => _SocialConsciousnessScreenState();
}

class _SocialConsciousnessScreenState extends State<SocialConsciousnessScreen> {
  final List<Map<String, TextEditingController>> indicators = List.generate(9, (index) {
    return {
      'indicator': TextEditingController(),
      'instances': TextEditingController(),
      'details': TextEditingController(),
    };
  });

  // Function to navigate back to DisputesScreen
  void _goToPreviousScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DisputesScreen()),
    );
  }

  Widget _buildSocialContent() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Instructions
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue.shade100),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue.shade800, size: 20),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Record social consciousness indicators in the village (e.g., child marriage, dowry, discrimination, etc.)',
                      style: TextStyle(fontSize: 13, color: Colors.blue.shade800),
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 20),
            
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
                    child: Text('Indicator', 
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  Expanded(
                    child: Text('Instances', 
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                  Expanded(
                    child: Text('Details', 
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ],
              ),
            ),
            
            // Table Rows
            ...indicators.asMap().entries.map((entry) => Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: entry.value['indicator'],
                      decoration: InputDecoration(
                        hintText: 'Social indicator',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: entry.value['instances'],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'No. of instances',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                      validator: (value) => value!.isEmpty ? 'Required' : null,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      controller: entry.value['details'],
                      decoration: InputDecoration(
                        hintText: 'Additional details',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            )),
            
            SizedBox(height: 20),
            
            // Navigation Info
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Color(0xFF800080).withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.blue.shade800, size: 16),
                      SizedBox(width: 5),
                      Text('Previous: Village Disputes', 
                        style: TextStyle(fontSize: 12, color: Colors.blue.shade800)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.navigate_next, color: Colors.green, size: 16),
                      SizedBox(width: 5),
                      Text('Next: Social Map', 
                        style: TextStyle(fontSize: 12, color: Colors.green.shade800)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TemplateScreen(
      title: 'Social Consciousness',
      stepNumber: 'Step 26',
      nextScreenRoute: '/social-map',
      nextScreenName: 'Social Map',
      icon: Icons.psychology,
      instructions: 'Record social consciousness indicators in the village (e.g., child marriage, dowry, discrimination, etc.)',
      contentWidget: _buildSocialContent(),
      onBack: _goToPreviousScreen, // ✅ Pass the back navigation function
    );
  }

  @override
  void dispose() {
    for (var indicator in indicators) {
      indicator['indicator']!.dispose();
      indicator['instances']!.dispose();
      indicator['details']!.dispose();
    }
    super.dispose();
  }
}