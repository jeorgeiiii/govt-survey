import 'package:flutter/material.dart';

class TemplateScreen extends StatefulWidget {
  final String title;
  final String stepNumber;
  final String nextScreenRoute;
  final Widget contentWidget;
  final String nextScreenName;
  final IconData icon;
  final String instructions;
  final VoidCallback? onBack; // ✅ NEW: Back button callback
  
  TemplateScreen({
    required this.title,
    required this.stepNumber,
    required this.nextScreenRoute,
    required this.contentWidget,
    required this.nextScreenName,
    required this.icon,
    this.instructions = '',
    this.onBack, // ✅ NEW: Back button callback
  });

  @override
  _TemplateScreenState createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _submitForm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Data Saved'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${widget.title} data saved.'),
            SizedBox(height: 10),
            Text('Continue to ${widget.nextScreenName}?'),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text('Edit')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, widget.nextScreenRoute);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Data saved!')),
              );
            },
            child: Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _goBack() {
    if (widget.onBack != null) {
      widget.onBack!();
    } else {
      Navigator.pop(context);
    }
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
                  Text('Government of India', 
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF003366))),
                  Text('Digital India', 
                    style: TextStyle(fontSize: 16, color: Colors.orange)),
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
                              Icon(widget.icon, color: Color(0xFF800080)),
                              SizedBox(width: 10),
                              Text(widget.title, 
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ]),
                            SizedBox(height: 8),
                            Text('${widget.stepNumber}: ${widget.title}'),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Instructions
                    if (widget.instructions.isNotEmpty)
                      Container(
                        padding: EdgeInsets.all(12),
                        color: Colors.blue.shade50,
                        child: Text(widget.instructions),
                      ),
                    
                    SizedBox(height: widget.instructions.isNotEmpty ? 20 : 0),
                    
                    // Content Widget
                    widget.contentWidget,
                    
                    SizedBox(height: 20),
                    
                    // Buttons - RESET replaced with BACK
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _goBack,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade700,
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            icon: Icon(Icons.arrow_back, size: 20),
                            label: Text('Back to Previous'),
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF800080),
                              padding: EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: Text('Save & Continue'),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 20),
                    
                    // Progress
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        children: [
                          Icon(widget.icon, color: Color(0xFF800080)),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${widget.stepNumber}: ${widget.title}'),
                              Text('Next: ${widget.nextScreenName}', 
                                style: TextStyle(color: Colors.green, fontSize: 12)),
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

// Helper widget for table rows
class TableRowWidget extends StatelessWidget {
  final String label;
  final Widget inputWidget;
  final String? helperText;
  
  TableRowWidget({
    required this.label,
    required this.inputWidget,
    this.helperText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(fontWeight: FontWeight.w500))),
          SizedBox(width: 10),
          Expanded(child: inputWidget),
          if (helperText != null) ...[
            SizedBox(width: 10),
            Icon(Icons.info_outline, size: 16, color: Colors.blue),
          ],
        ],
      ),
    );
  }
}