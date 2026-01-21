import 'package:flutter/material.dart';
import '../form_template.dart';
import 'panchavati_trees_screen.dart';
import 'animals_fisheries_screen.dart'; // Import the previous screen

class TransportationScreen extends StatefulWidget {
  @override
  _TransportationScreenState createState() => _TransportationScreenState();
}

class _TransportationScreenState extends State<TransportationScreen> {
  final Map<String, TextEditingController> vehicles = {
    'Tractor': TextEditingController(),
    'Car/Jeep': TextEditingController(),
    'Motorcycle/Scooter': TextEditingController(),
    'Cycle': TextEditingController(),
    'E-rickshaw': TextEditingController(),
    'Pick-up/Truck': TextEditingController(),
  };

  // Calculate total vehicles
  String _totalVehicles = '0';

  void _calculateTotal() {
    int total = 0;
    vehicles.forEach((_, controller) {
      total += int.tryParse(controller.text) ?? 0;
    });
    
    setState(() {
      _totalVehicles = total.toString();
    });
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PanchavatiTreesScreen()),
    );
  }

  void _goToPreviousScreen() {
    // Navigate back to AnimalsFisheriesScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => AnimalsFisheriesScreen()),
    );
  }

  Widget _buildTransportationContent() {
    return Column(
      children: [
        // Vehicles Table
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
                          'Vehicle Type',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Count',
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
                
                // Vehicle Rows
                ...vehicles.entries.map((entry) => Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          entry.key,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: NumberInput(
                            label: '',
                            controller: entry.value,
                            prefixIcon: _getVehicleIcon(entry.key),
                            isRequired: false,
                            onChanged: (value) => _calculateTotal(),
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
        
        // Total Vehicles Display
        CalculatedDisplay(
          label: 'Total Vehicles',
          value: _totalVehicles,
          description: 'Sum of all vehicles',
          icon: Icons.directions_car,
        ),
        
        SizedBox(height: 20),
        
        // Summary Card
        if (_totalVehicles != '0')
          SummaryCard(
            title: 'Transportation Summary',
            items: vehicles.entries
                .where((entry) => (int.tryParse(entry.value.text) ?? 0) > 0)
                .map((entry) => {
                  'label': '${entry.key}:',
                  'value': entry.value.text
                })
                .toList(),
          ),
      ],
    );
  }

  // Get appropriate icon for each vehicle type
  IconData _getVehicleIcon(String vehicleType) {
    switch (vehicleType) {
      case 'Tractor':
        return Icons.agriculture;
      case 'Car/Jeep':
        return Icons.directions_car;
      case 'Motorcycle/Scooter':
        return Icons.motorcycle;
      case 'Cycle':
        return Icons.pedal_bike;
      case 'E-rickshaw':
        return Icons.electric_rickshaw;
      case 'Pick-up/Truck':
        return Icons.local_shipping;
      default:
        return Icons.directions_car;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplateScreen(
      title: 'Transportation Facilities',
      stepNumber: 'Step 17',
      nextScreenRoute: '/panchavati-trees',
      nextScreenName: 'Panchavati Trees',
      icon: Icons.directions_car,
      instructions: 'Enter number of vehicles available in the village',
      contentWidget: _buildTransportationContent(),
      onSubmit: _submitForm,
      onBack: _goToPreviousScreen, onReset: () {  },
    );
  }

  @override
  void dispose() {
    vehicles.forEach((_, controller) => controller.dispose());
    super.dispose();
  }
}