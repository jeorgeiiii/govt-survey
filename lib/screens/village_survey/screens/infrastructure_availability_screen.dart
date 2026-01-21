import 'package:flutter/material.dart';
import '../form_template.dart'; // Import the form template
import 'educational_facilities_screen.dart';
import 'infrastructure_screen.dart'; // Import the previous screen

class InfrastructureAvailabilityScreen extends StatefulWidget {
  @override
  _InfrastructureAvailabilityScreenState createState() => _InfrastructureAvailabilityScreenState();
}

class _InfrastructureAvailabilityScreenState extends State<InfrastructureAvailabilityScreen> {
  // Controllers
  final TextEditingController primarySchoolDistanceController = TextEditingController();
  final TextEditingController juniorSchoolDistanceController = TextEditingController();
  final TextEditingController highSchoolDistanceController = TextEditingController();
  final TextEditingController intermediateSchoolDistanceController = TextEditingController();
  final TextEditingController otherEducationalFacilityController = TextEditingController();
  final TextEditingController boysStudentsController = TextEditingController();
  final TextEditingController girlsStudentsController = TextEditingController();
  final TextEditingController playgroundRemarksController = TextEditingController();
  final TextEditingController panchayatRemarksController = TextEditingController();
  final TextEditingController shardaKendraDistanceController = TextEditingController();
  final TextEditingController postOfficeDistanceController = TextEditingController();
  final TextEditingController healthFacilityDistanceController = TextEditingController();
  final TextEditingController bankDistanceController = TextEditingController();
  final TextEditingController numWellsController = TextEditingController();
  final TextEditingController numPondsController = TextEditingController();
  final TextEditingController numHandPumpsController = TextEditingController();
  final TextEditingController numTubeWellsController = TextEditingController();
  final TextEditingController numTapWaterController = TextEditingController();

  // Boolean states
  bool _hasPrimarySchool = false;
  bool _hasJuniorSchool = false;
  bool _hasHighSchool = false;
  bool _hasIntermediateSchool = false;
  bool _hasPlayground = false;
  bool _hasPanchayatBhavan = false;
  bool _hasShardaKendra = false;
  bool _hasPostOffice = false;
  bool _hasHealthFacility = false;
  bool _hasPrimaryHealthCentre = false;
  bool _hasBank = false;
  bool _hasElectricalConnection = false;
  bool _hasDrinkingWaterSource = false;

  // Calculated values
  String _totalStudents = '0';

  // Auto-calculate total students
  void _calculateTotalStudents() {
    int boys = int.tryParse(boysStudentsController.text) ?? 0;
    int girls = int.tryParse(girlsStudentsController.text) ?? 0;
    
    int total = boys + girls;
    
    setState(() {
      _totalStudents = total.toString();
    });
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EducationalFacilitiesScreen()),
    );
  }

  void _goToPreviousScreen() {
    // Navigate back to InfrastructureScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => InfrastructureScreen()),
    );
  }

  Widget _buildInfrastructureContent() {
    return Column(
      children: [
        // School Availability Section
        QuestionCard(
          question: ' School Availability',
          description: 'Availability of different types of schools',
          child: Column(
            children: [
              // Primary School
              _buildSchoolRadioField(
                label: '(i) Primary School (Upto 5th Standard)',
                hasSchool: _hasPrimarySchool,
                distanceController: primarySchoolDistanceController,
                onChanged: (value) {
                  setState(() {
                    _hasPrimarySchool = value == 'Yes';
                    if (!_hasPrimarySchool) primarySchoolDistanceController.clear();
                  });
                },
              ),
              
              SizedBox(height: 20),
              
              // Junior School
              _buildSchoolRadioField(
                label: '(ii) Junior School (6th to 8th Standard)',
                hasSchool: _hasJuniorSchool,
                distanceController: juniorSchoolDistanceController,
                onChanged: (value) {
                  setState(() {
                    _hasJuniorSchool = value == 'Yes';
                    if (!_hasJuniorSchool) juniorSchoolDistanceController.clear();
                  });
                },
              ),
              
              SizedBox(height: 20),
              
              // High School
              _buildSchoolRadioField(
                label: '(iii) High School (9th to 10th Standard)',
                hasSchool: _hasHighSchool,
                distanceController: highSchoolDistanceController,
                onChanged: (value) {
                  setState(() {
                    _hasHighSchool = value == 'Yes';
                    if (!_hasHighSchool) highSchoolDistanceController.clear();
                  });
                },
              ),
              
              SizedBox(height: 20),
              
              // Intermediate School
              _buildSchoolRadioField(
                label: '(iv) Intermediate School (10+2)',
                hasSchool: _hasIntermediateSchool,
                distanceController: intermediateSchoolDistanceController,
                onChanged: (value) {
                  setState(() {
                    _hasIntermediateSchool = value == 'Yes';
                    if (!_hasIntermediateSchool) intermediateSchoolDistanceController.clear();
                  });
                },
              ),
              
              SizedBox(height: 20),
              
              // Other Educational Facilities
              TextInput(
                label: '(v) Other (like Anganwadi, Shiksha Guarantee Scheme, etc.)',
                controller: otherEducationalFacilityController,
                prefixIcon: Icons.menu_book,
                isRequired: false,
              ),
            ],
          ),
        ),
        
        SizedBox(height: 25),
        
        // Number of Students Section
        QuestionCard(
          question: ' Number of Students',
          description: 'Total number of students in village',
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: NumberInput(
                      label: '(i) Boys',
                      controller: boysStudentsController,
                      prefixIcon: Icons.boy,
                      onChanged: (value) => _calculateTotalStudents(),
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: NumberInput(
                      label: '(ii) Girls',
                      controller: girlsStudentsController,
                      prefixIcon: Icons.girl,
                      onChanged: (value) => _calculateTotalStudents(),
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 15),
              
              // Total Students Display
              CalculatedDisplay(
                label: 'Total Students',
                value: _totalStudents,
                description: 'Sum of boys and girls',
                icon: Icons.school,
              ),
            ],
          ),
        ),
        
        SizedBox(height: 25),
        
        // Infrastructure Facilities Section
        QuestionCard(
          question: ' Other Infrastructure Facilities',
          description: 'Availability of various infrastructure facilities',
          child: Column(
            children: [
              // Playground
              _buildFacilityRadioField(
                label: 'c) Playground',
                hasFacility: _hasPlayground,
                remarksController: playgroundRemarksController,
                onChanged: (value) {
                  setState(() {
                    _hasPlayground = value == 'Yes';
                    if (!_hasPlayground) playgroundRemarksController.clear();
                  });
                },
              ),
              
              SizedBox(height: 15),
              
              // Panchayat Bhavan
              _buildFacilityRadioField(
                label: 'd) Panchayat Bhavan',
                hasFacility: _hasPanchayatBhavan,
                remarksController: panchayatRemarksController,
                onChanged: (value) {
                  setState(() {
                    _hasPanchayatBhavan = value == 'Yes';
                    if (!_hasPanchayatBhavan) panchayatRemarksController.clear();
                  });
                },
              ),
              
              SizedBox(height: 15),
              
              // Sharda Kendra
              _buildFacilityRadioDistanceField(
                label: 'e) Sharda Kendra (Place of Worship)',
                hasFacility: _hasShardaKendra,
                distanceController: shardaKendraDistanceController,
                onChanged: (value) {
                  setState(() {
                    _hasShardaKendra = value == 'Yes';
                    if (!_hasShardaKendra) shardaKendraDistanceController.clear();
                  });
                },
              ),
              
              SizedBox(height: 15),
              
              // Post Office
              _buildFacilityRadioDistanceField(
                label: 'f) Post Office',
                hasFacility: _hasPostOffice,
                distanceController: postOfficeDistanceController,
                onChanged: (value) {
                  setState(() {
                    _hasPostOffice = value == 'Yes';
                    if (!_hasPostOffice) postOfficeDistanceController.clear();
                  });
                },
              ),
              
              SizedBox(height: 15),
              
              // Health Facility
              _buildFacilityRadioDistanceField(
                label: 'g) Health Facility (General Practitioners)',
                hasFacility: _hasHealthFacility,
                distanceController: healthFacilityDistanceController,
                onChanged: (value) {
                  setState(() {
                    _hasHealthFacility = value == 'Yes';
                    if (!_hasHealthFacility) healthFacilityDistanceController.clear();
                  });
                },
              ),
              
              SizedBox(height: 15),
              
              // Primary Health Centre
              _buildSimpleRadioField(
                label: 'h) Primary Health Centre',
                hasFacility: _hasPrimaryHealthCentre,
                onChanged: (value) {
                  setState(() {
                    _hasPrimaryHealthCentre = value == 'Yes';
                  });
                },
              ),
              
              SizedBox(height: 15),
              
              // Bank
              _buildFacilityRadioDistanceField(
                label: 'i) Bank',
                hasFacility: _hasBank,
                distanceController: bankDistanceController,
                onChanged: (value) {
                  setState(() {
                    _hasBank = value == 'Yes';
                    if (!_hasBank) bankDistanceController.clear();
                  });
                },
              ),
              
              SizedBox(height: 15),
              
              // Electrical Connection
              _buildSimpleRadioField(
                label: 'j) Electrical Connection',
                hasFacility: _hasElectricalConnection,
                onChanged: (value) {
                  setState(() {
                    _hasElectricalConnection = value == 'Yes';
                  });
                },
              ),
              
              SizedBox(height: 15),
              
              // Water Source Section
              _buildWaterSourceSection(),
            ],
          ),
        ),
        
        SizedBox(height: 20),
        
        // Summary Card
        if (_hasPrimarySchool || _hasJuniorSchool || _hasHighSchool || _hasIntermediateSchool || 
            boysStudentsController.text.isNotEmpty || girlsStudentsController.text.isNotEmpty)
          SummaryCard(
            title: ' Infrastructure Summary',
            items: [
              if (_hasPrimarySchool) {'label': 'Primary School:', 'value': primarySchoolDistanceController.text.isEmpty ? 'Available' : '${primarySchoolDistanceController.text} km'},
              if (_hasJuniorSchool) {'label': 'Junior School:', 'value': juniorSchoolDistanceController.text.isEmpty ? 'Available' : '${juniorSchoolDistanceController.text} km'},
              if (_hasHighSchool) {'label': 'High School:', 'value': highSchoolDistanceController.text.isEmpty ? 'Available' : '${highSchoolDistanceController.text} km'},
              if (_hasIntermediateSchool) {'label': 'Intermediate School:', 'value': intermediateSchoolDistanceController.text.isEmpty ? 'Available' : '${intermediateSchoolDistanceController.text} km'},
              if (boysStudentsController.text.isNotEmpty) {'label': 'Boys Students:', 'value': boysStudentsController.text},
              if (girlsStudentsController.text.isNotEmpty) {'label': 'Girls Students:', 'value': girlsStudentsController.text},
              if (_totalStudents != '0') {'label': 'Total Students:', 'value': _totalStudents},
              if (_hasPlayground) {'label': 'Playground:', 'value': 'Available'},
              if (_hasPanchayatBhavan) {'label': 'Panchayat Bhavan:', 'value': 'Available'},
              if (_hasShardaKendra) {'label': 'Sharda Kendra:', 'value': shardaKendraDistanceController.text.isEmpty ? 'Available' : '${shardaKendraDistanceController.text} km'},
              if (_hasPostOffice) {'label': 'Post Office:', 'value': postOfficeDistanceController.text.isEmpty ? 'Available' : '${postOfficeDistanceController.text} km'},
              if (_hasHealthFacility) {'label': 'Health Facility:', 'value': healthFacilityDistanceController.text.isEmpty ? 'Available' : '${healthFacilityDistanceController.text} km'},
              if (_hasPrimaryHealthCentre) {'label': 'Primary Health Centre:', 'value': 'Available'},
              if (_hasBank) {'label': 'Bank:', 'value': bankDistanceController.text.isEmpty ? 'Available' : '${bankDistanceController.text} km'},
              if (_hasElectricalConnection) {'label': 'Electrical Connection:', 'value': 'Available'},
              if (_hasDrinkingWaterSource) {'label': 'Drinking Water Source:', 'value': 'Available'},
            ],
          ),
      ],
    );
  }

  // School Radio Field with Distance
  Widget _buildSchoolRadioField({
    required String label,
    required bool hasSchool,
    required TextEditingController distanceController,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8),
        RadioOptionGroup(
          label: '',
          options: ['Yes', 'No'],
          selectedValue: hasSchool ? 'Yes' : 'No',
          onChanged: onChanged,
        ),
        if (hasSchool)
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: NumberInput(
              label: 'Distance From Village (km)',
              controller: distanceController,
              prefixIcon: Icons.location_on,
            ),
          ),
      ],
    );
  }

  // Facility Radio Field with Remarks
  Widget _buildFacilityRadioField({
    required String label,
    required bool hasFacility,
    required TextEditingController remarksController,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8),
        RadioOptionGroup(
          label: '',
          options: ['Yes', 'No'],
          selectedValue: hasFacility ? 'Yes' : 'No',
          onChanged: onChanged,
        ),
        if (hasFacility)
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: TextInput(
              label: 'Remarks',
              controller: remarksController,
              prefixIcon: Icons.note,
              isRequired: false,
            ),
          ),
      ],
    );
  }

  // Facility Radio Field with Distance
  Widget _buildFacilityRadioDistanceField({
    required String label,
    required bool hasFacility,
    required TextEditingController distanceController,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8),
        RadioOptionGroup(
          label: '',
          options: ['Yes', 'No'],
          selectedValue: hasFacility ? 'Yes' : 'No',
          onChanged: onChanged,
        ),
        if (hasFacility)
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: NumberInput(
              label: 'Distance (km)',
              controller: distanceController,
              prefixIcon: Icons.location_on,
            ),
          ),
      ],
    );
  }

  // Simple Radio Field
  Widget _buildSimpleRadioField({
    required String label,
    required bool hasFacility,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8),
        RadioOptionGroup(
          label: '',
          options: ['Yes', 'No'],
          selectedValue: hasFacility ? 'Yes' : 'No',
          onChanged: onChanged,
        ),
      ],
    );
  }

  // Water Source Section
  Widget _buildWaterSourceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSimpleRadioField(
          label: 'k) Source of Drinking Water',
          hasFacility: _hasDrinkingWaterSource,
          onChanged: (value) {
            setState(() {
              _hasDrinkingWaterSource = value == 'Yes';
              if (!_hasDrinkingWaterSource) {
                numWellsController.clear();
                numPondsController.clear();
                numHandPumpsController.clear();
                numTubeWellsController.clear();
                numTapWaterController.clear();
              }
            });
          },
        ),
        
        if (_hasDrinkingWaterSource) ...[
          SizedBox(height: 15),
          Text(
            'Water Source Details:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          SizedBox(height: 10),
          
          Row(
            children: [
              Expanded(
                child: NumberInput(
                  label: '(i) No. of Wells',
                  controller: numWellsController,
                  prefixIcon: Icons.water,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: NumberInput(
                  label: '(ii) No. of Ponds',
                  controller: numPondsController,
                  prefixIcon: Icons.waves,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 15),
          
          Row(
            children: [
              Expanded(
                child: NumberInput(
                  label: '(iii) No. of Hand Pumps',
                  controller: numHandPumpsController,
                  prefixIcon: Icons.build,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: NumberInput(
                  label: '(iv) No. of Tube Wells',
                  controller: numTubeWellsController,
                  prefixIcon: Icons.opacity,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 15),
          
          NumberInput(
            label: '(v) No. of Tap Water connections (Nal Jaal)',
            controller: numTapWaterController,
            prefixIcon: Icons.water_damage,
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormTemplateScreen(
      title: 'Infrastructure Availability',
      stepNumber: 'Step 6',
      nextScreenRoute: '/educational-facilities',
      nextScreenName: 'Educational Facilities',
      icon: Icons.school,
      instructions: 'Availability of Infrastructure in Village',
      contentWidget: _buildInfrastructureContent(),
      onSubmit: _submitForm,
      onBack: _goToPreviousScreen, onReset: () {  },
    );
  }

  @override
  void dispose() {
    primarySchoolDistanceController.dispose();
    juniorSchoolDistanceController.dispose();
    highSchoolDistanceController.dispose();
    intermediateSchoolDistanceController.dispose();
    otherEducationalFacilityController.dispose();
    boysStudentsController.dispose();
    girlsStudentsController.dispose();
    playgroundRemarksController.dispose();
    panchayatRemarksController.dispose();
    shardaKendraDistanceController.dispose();
    postOfficeDistanceController.dispose();
    healthFacilityDistanceController.dispose();
    bankDistanceController.dispose();
    numWellsController.dispose();
    numPondsController.dispose();
    numHandPumpsController.dispose();
    numTubeWellsController.dispose();
    numTapWaterController.dispose();
    super.dispose();
  }
}