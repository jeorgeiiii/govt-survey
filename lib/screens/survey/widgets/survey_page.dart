import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/database_helper.dart';
import '../../../l10n/app_localizations.dart';
import '../../../providers/survey_provider.dart';

class SurveyPage extends ConsumerStatefulWidget {
  final int pageIndex;
  final VoidCallback onNext;
  final VoidCallback? onPrevious;

  const SurveyPage({
    super.key,
    required this.pageIndex,
    required this.onNext,
    this.onPrevious,
  });

  @override
  ConsumerState<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends ConsumerState<SurveyPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> _pageData = {};

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Page Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: FadeInUp(
                    child: _buildPageContent(widget.pageIndex, l10n),
                  ),
                ),
              ),

              // Navigation Buttons
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (widget.onPrevious != null)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: widget.onPrevious,
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            side: const BorderSide(color: Colors.green),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            l10n.previous,
                            style: const TextStyle(color: Colors.green),
                          ),
                        ),
                      ),

                    if (widget.onPrevious != null) const SizedBox(width: 16),

                    Expanded(
                      flex: widget.onPrevious != null ? 2 : 1,
                      child: ElevatedButton(
                        onPressed: _handleNext,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          widget.pageIndex == 19 ? l10n.submit : l10n.next,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(int pageIndex, AppLocalizations l10n) {
    switch (pageIndex) {
      case 0:
        return _buildLocationPage(l10n);
      case 1:
        return _buildFamilyDetailsPage(l10n);
      case 2:
        return _buildSocialConsciousnessPage(l10n);
      case 3:
        return _buildLandHoldingPage(l10n);
      case 4:
        return _buildIrrigationPage(l10n);
      case 5:
        return _buildCropProductivityPage(l10n);
      case 6:
        return _buildFertilizerPage(l10n);
      case 7:
        return _buildAnimalsPage(l10n);
      case 8:
        return _buildEquipmentPage(l10n);
      case 9:
        return _buildEntertainmentPage(l10n);
      case 10:
        return _buildTransportPage(l10n);
      case 11:
        return _buildWaterSourcesPage(l10n);
      case 12:
        return _buildMedicalPage(l10n);
      case 13:
        return _buildDisputesPage(l10n);
      case 14:
        return _buildHouseConditionsPage(l10n);
      case 15:
        return _buildDiseasesPage(l10n);
      case 16:
        return _buildGovernmentSchemesPage(l10n);
      case 17:
        return _buildChildrenPage(l10n);
      case 18:
        return _buildMigrationPage(l10n);
      case 19:
        return _buildTrainingPage(l10n);
      case 20:
        return _buildFinalPage(l10n);
      default:
        return const Center(child: Text('Page not found'));
    }
  }

  Widget _buildLocationPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Text(
            'Location Information',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
        const SizedBox(height: 24),

        FadeInLeft(
          duration: const Duration(milliseconds: 500),
          delay: const Duration(milliseconds: 100),
          child: TextFormField(
            decoration: InputDecoration(
              labelText: l10n.villageName,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter village name';
              }
              return null;
            },
            onSaved: (value) => _pageData['village_name'] = value,
          ),
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.panchayat,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['panchayat'] = value,
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.block,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSaved: (value) => _pageData['block'] = value,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: l10n.district,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onSaved: (value) => _pageData['district'] = value,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.postalAddress,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: 3,
          onSaved: (value) => _pageData['postal_address'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.pinCode,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['pin_code'] = value,
        ),
      ],
    );
  }

  Widget _buildFamilyDetailsPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.familyDetails,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please provide details for each family member',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        // Family Member 1 (Head of Family)
        _buildFamilyMemberCard(1, 'Head of Family', l10n, isRequired: true),

        const SizedBox(height: 24),

        // Add more family members
        ElevatedButton.icon(
          onPressed: () {
            // TODO: Add dynamic family member forms
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Dynamic family member addition coming soon')),
            );
          },
          icon: const Icon(Icons.add),
          label: Text(l10n.addMember),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Note about additional members
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.blue[200]!),
          ),
          child: Row(
            children: [
              Icon(Icons.info, color: Colors.blue[700]),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'You can add more family members in the next steps. For now, please provide details for the head of the family.',
                  style: TextStyle(color: Colors.blue[700]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSocialConsciousnessPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Social Consciousness Survey',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please answer questions about your social consciousness and habits',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        // Question 1: How often do family members buy new clothes
        Text(
          '1. How often do family members buy new clothes?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Weekly', 'clothes_frequency', 'weekly'),
        _buildRadioField('Monthly', 'clothes_frequency', 'monthly'),
        _buildRadioField('Yearly', 'clothes_frequency', 'yearly'),
        _buildRadioField('As per need', 'clothes_frequency', 'as_per_need'),
        _buildRadioField('Other (please specify)', 'clothes_frequency', 'other'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'If other, please specify',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['clothes_frequency_other'] = value,
        ),

        const SizedBox(height: 24),

        // Question 2: Food Waste
        Text(
          '2. Is there food waste in the home?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'food_waste', 'yes'),
        _buildRadioField('No', 'food_waste', 'no'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'If yes, how much?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['food_waste_amount'] = value,
        ),

        const SizedBox(height: 24),

        // Question 3: Waste Disposal
        Text(
          '3. How do you dispose of waste?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Throw anywhere', 'waste_disposal', 'throw_anywhere'),
        _buildRadioField('Put into village dustbins', 'waste_disposal', 'village_dustbins'),
        _buildRadioField('Collect and sell to kabadiwala', 'waste_disposal', 'kabadiwala'),
        _buildRadioField('Other (please specify)', 'waste_disposal', 'other'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'If other, please specify',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['waste_disposal_other'] = value,
        ),

        const SizedBox(height: 24),

        // Question 4: Waste Segregation
        Text(
          '4. Do you segregate waste?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'waste_segregation', 'yes'),
        _buildRadioField('No', 'waste_segregation', 'no'),

        const SizedBox(height: 24),

        // Question 5: Compost Pit
        Text(
          '5. Do you have a compost pit?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'compost_pit', 'yes'),
        _buildRadioField('No', 'compost_pit', 'no'),

        const SizedBox(height: 24),

        // Question 6: Recycle Items
        Text(
          '6. Do you recycle used items?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'recycle_items', 'yes'),
        _buildRadioField('No', 'recycle_items', 'no'),

        const SizedBox(height: 24),

        // Question 7: Toilet
        Text(
          '7. Do you have a toilet?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'have_toilet', 'yes'),
        _buildRadioField('No', 'have_toilet', 'no'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'If yes, is it in use?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['toilet_in_use'] = value,
        ),

        const SizedBox(height: 24),

        // Question 8: Soak Pit
        Text(
          '8. If yes, does it have a soak pit?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'soak_pit', 'yes'),
        _buildRadioField('No', 'soak_pit', 'no'),

        const SizedBox(height: 24),

        // Question 9: LED Lights
        Text(
          '9. Do you use LED lights?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'led_lights', 'yes'),
        _buildRadioField('No', 'led_lights', 'no'),

        const SizedBox(height: 24),

        // Question 10: Turn off devices
        Text(
          '10. Do you turn off electrical/electronic devices when not in use?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'turn_off_devices', 'yes'),
        _buildRadioField('No', 'turn_off_devices', 'no'),

        const SizedBox(height: 24),

        // Question 11: Fix leaking taps
        Text(
          '11. If you find water leaking from any tap/hand pump, do you try to fix it?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'fix_leaks', 'yes'),
        _buildRadioField('No', 'fix_leaks', 'no'),

        const SizedBox(height: 24),

        // Question 12: Avoid single-use plastics
        Text(
          '12. Do you avoid single-use plastics?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'avoid_plastics', 'yes'),
        _buildRadioField('No', 'avoid_plastics', 'no'),

        const SizedBox(height: 24),

        // Question 13: Family prayers
        Text(
          '13. Do all members of the family do Puja/Pray?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'family_prayers', 'yes'),
        _buildRadioField('No', 'family_prayers', 'no'),

        const SizedBox(height: 24),

        // Question 14: Meditation
        Text(
          '14. Do members of the family meditate?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'family_meditation', 'yes'),
        _buildRadioField('No', 'family_meditation', 'no'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'If yes, who?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['meditation_members'] = value,
        ),

        const SizedBox(height: 24),

        // Question 15: Yoga
        Text(
          '15. Do members of the family do Yoga?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'family_yoga', 'yes'),
        _buildRadioField('No', 'family_yoga', 'no'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'If yes, who?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['yoga_members'] = value,
        ),

        const SizedBox(height: 24),

        // Question 16: Community activities
        Text(
          '16. Do members of your family participate in community activities?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'community_activities', 'yes'),
        _buildRadioField('No', 'community_activities', 'no'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'If yes, which activities?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['community_activities_type'] = value,
        ),

        const SizedBox(height: 24),

        // Question 17: Shram Sadhana
        Text(
          '17. Do members of your family participate in Shram Sadhana?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'shram_sadhana', 'yes'),
        _buildRadioField('No', 'shram_sadhana', 'no'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'If yes, who?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['shram_sadhana_members'] = value,
        ),

        const SizedBox(height: 24),

        // Question 18: Spiritual discourses
        Text(
          '18. Do members of the family listen to spiritual/motivational discourses (kathas)?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'spiritual_discourses', 'yes'),
        _buildRadioField('No', 'spiritual_discourses', 'no'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'If yes, who?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['discourses_members'] = value,
        ),

        const SizedBox(height: 24),

        // Question 19: Happiness
        Text(
          '19. Are you happy?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'personal_happiness', 'yes'),
        _buildRadioField('No', 'personal_happiness', 'no'),

        const SizedBox(height: 24),

        // Question 20: Family happiness
        Text(
          '20. Are members of your family happy?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'family_happiness', 'yes'),
        _buildRadioField('No', 'family_happiness', 'no'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'If yes, who?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['happy_members'] = value,
        ),

        const SizedBox(height: 24),

        // Question 21: Bad habits
        Text(
          '21. Does any member of the family:',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildCheckboxField('Smoke', 'member_smokes'),
        _buildCheckboxField('Drink', 'member_drinks'),
        _buildCheckboxField('Eat Gudka', 'member_eats_gudka'),
        _buildCheckboxField('Gamble', 'member_gambles'),
        _buildCheckboxField('Chew Tobacco', 'member_chews_tobacco'),

        const SizedBox(height: 24),

        // Question 22: Savings
        Text(
          '22. Do you save?',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        _buildRadioField('Yes', 'family_saves', 'yes'),
        _buildRadioField('No', 'family_saves', 'no'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'If yes, what percentage of income?',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['savings_percentage'] = value,
        ),
      ],
    );
  }

  Widget _buildCheckboxField(String label, String key) {
    return CheckboxListTile(
      title: Text(label),
      value: _pageData[key] ?? false,
      onChanged: (value) {
        setState(() {
          _pageData[key] = value ?? false;
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildRadioField(String label, String groupKey, String value) {
    return RadioListTile<String>(
      title: Text(label),
      value: value,
      groupValue: _pageData[groupKey],
      onChanged: (newValue) {
        setState(() {
          _pageData[groupKey] = newValue;
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  Widget _buildCropCard(int cropNumber, AppLocalizations l10n) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Crop ${cropNumber}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              decoration: InputDecoration(
                labelText: l10n.cropName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.grass),
              ),
              onSaved: (value) => _pageData['crop_${cropNumber}_name'] = value,
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '${l10n.areaAcres} (Acres)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.straighten),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _pageData['crop_${cropNumber}_area'] = value,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '${l10n.productivity} (Qtl/Acre)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.trending_up),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _pageData['crop_${cropNumber}_productivity'] = value,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: l10n.totalProduction,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.inventory),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _pageData['crop_${cropNumber}_total_production'] = value,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: l10n.quantityConsumed,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.restaurant),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _pageData['crop_${cropNumber}_consumed'] = value,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: InputDecoration(
                labelText: l10n.quantitySold,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.sell),
              ),
              keyboardType: TextInputType.number,
              onSaved: (value) => _pageData['crop_${cropNumber}_sold'] = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimalCard(int animalNumber, AppLocalizations l10n) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Animal ${animalNumber}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              decoration: InputDecoration(
                labelText: l10n.animalType,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.pets),
              ),
              onSaved: (value) => _pageData['animal_${animalNumber}_type'] = value,
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: l10n.numberOfAnimals,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.format_list_numbered),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _pageData['animal_${animalNumber}_count'] = value,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: l10n.breed,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.category),
                    ),
                    onSaved: (value) => _pageData['animal_${animalNumber}_breed'] = value,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: InputDecoration(
                labelText: l10n.productionPerAnimal,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.production_quantity_limits),
              ),
              onSaved: (value) => _pageData['animal_${animalNumber}_production'] = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiseaseCard(int diseaseNumber, AppLocalizations l10n) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disease ${diseaseNumber}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              decoration: InputDecoration(
                labelText: l10n.diseaseName,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.medical_services),
              ),
              onSaved: (value) => _pageData['disease_${diseaseNumber}_name'] = value,
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: InputDecoration(
                labelText: l10n.sufferingSince,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.calendar_today),
              ),
              onSaved: (value) => _pageData['disease_${diseaseNumber}_since'] = value,
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: InputDecoration(
                labelText: l10n.treatmentFrom,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.local_hospital),
              ),
              onSaved: (value) => _pageData['disease_${diseaseNumber}_treatment'] = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchemeCard(String schemeName, String key) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              schemeName,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Have Card',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    items: [
                      DropdownMenuItem(value: 'yes', child: Text('Yes')),
                      DropdownMenuItem(value: 'no', child: Text('No')),
                      DropdownMenuItem(value: 'applied', child: Text('Applied')),
                    ],
                    onChanged: (value) {
                      // Handle change
                    },
                    onSaved: (value) => _pageData['${key}_have_card'] = value,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Card Number',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onSaved: (value) => _pageData['${key}_card_number'] = value,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            TextFormField(
              decoration: InputDecoration(
                labelText: 'Benefits Received',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              maxLines: 2,
              onSaved: (value) => _pageData['${key}_benefits'] = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChildMalnutritionCard(int childNumber, AppLocalizations l10n) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Child ${childNumber}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '${l10n.height} (feet)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.height),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _pageData['child_${childNumber}_height'] = value,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '${l10n.weight} (kg)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.monitor_weight),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _pageData['child_${childNumber}_weight'] = value,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: InputDecoration(
                labelText: l10n.causeDisease,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.medical_services),
              ),
              onSaved: (value) => _pageData['child_${childNumber}_cause'] = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFamilyMemberCard(int memberNumber, String relation, AppLocalizations l10n, {bool isRequired = false}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    memberNumber.toString(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '$relation ${isRequired ? '(Required)' : ''}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            TextFormField(
              decoration: InputDecoration(
                labelText: '${l10n.memberName} *',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
              validator: (value) {
                if (isRequired && (value?.isEmpty ?? true)) {
                  return 'Please enter member name';
                }
                return null;
              },
              onSaved: (value) => _pageData['member_${memberNumber}_name'] = value,
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: '${l10n.age} *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.calendar_today),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (isRequired && (value?.isEmpty ?? true)) {
                        return 'Please enter age';
                      }
                      final age = int.tryParse(value ?? '');
                      if (age != null && (age < 0 || age > 120)) {
                        return 'Please enter valid age';
                      }
                      return null;
                    },
                    onSaved: (value) => _pageData['member_${memberNumber}_age'] = value,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: '${l10n.sex} *',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: const Icon(Icons.wc),
                    ),
                    items: [
                      DropdownMenuItem(value: 'male', child: Text(l10n.male)),
                      DropdownMenuItem(value: 'female', child: Text(l10n.female)),
                      DropdownMenuItem(value: 'other', child: Text(l10n.other)),
                    ],
                    validator: (value) {
                      if (isRequired && value == null) {
                        return 'Please select gender';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      // Handle change
                    },
                    onSaved: (value) => _pageData['member_${memberNumber}_sex'] = value,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: InputDecoration(
                labelText: l10n.relation,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.family_restroom),
              ),
              onSaved: (value) => _pageData['member_${memberNumber}_relation'] = value,
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: InputDecoration(
                labelText: l10n.education,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.school),
              ),
              onSaved: (value) => _pageData['member_${memberNumber}_education'] = value,
            ),

            const SizedBox(height: 16),

            TextFormField(
              decoration: InputDecoration(
                labelText: l10n.occupation,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.work),
              ),
              onSaved: (value) => _pageData['member_${memberNumber}_occupation'] = value,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLandHoldingPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.landHolding,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please provide information about your land holdings',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        TextFormField(
          decoration: InputDecoration(
            labelText: '${l10n.irrigatedArea} (Acres)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.water),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['irrigated_area'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: '${l10n.cultivableArea} (Acres)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.agriculture),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['cultivable_area'] = value,
        ),

        const SizedBox(height: 24),

        Text(
          l10n.orchardPlants,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        _buildCheckboxField('Mango Trees', 'mango_trees'),
        _buildCheckboxField('Guava Trees', 'guava_trees'),
        _buildCheckboxField('Lemon Trees', 'lemon_trees'),
        _buildCheckboxField('Banana Plants', 'banana_plants'),
        _buildCheckboxField('Papaya Trees', 'papaya_trees'),
        _buildCheckboxField('Other Fruit Trees', 'other_fruit_trees'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Other Orchard Plants (specify)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['other_orchard_plants'] = value,
        ),
      ],
    );
  }

  Widget _buildIrrigationPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.irrigationFacilities,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please select the irrigation facilities available to you',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        _buildCheckboxField(l10n.canal, 'canal'),
        _buildCheckboxField(l10n.tubeWell, 'tube_well'),
        _buildCheckboxField(l10n.ponds, 'ponds'),
        _buildCheckboxField(l10n.otherFacilities, 'other_facilities'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Specify other irrigation facilities',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['other_irrigation_specify'] = value,
        ),

        const SizedBox(height: 24),

        Text(
          'Water Source Details',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Primary water source',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.water_drop),
          ),
          onSaved: (value) => _pageData['primary_water_source'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Distance from water source (${l10n.distance})',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.straighten),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['water_source_distance'] = value,
        ),
      ],
    );
  }
  Widget _buildCropProductivityPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.cropProductivity,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please provide details about your crop production',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        // Crop 1
        _buildCropCard(1, l10n),

        const SizedBox(height: 24),

        ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Multiple crop entries coming soon')),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Another Crop'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFertilizerPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.fertilizerUsage,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please select the type of fertilizers used',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        _buildCheckboxField(l10n.chemical, 'chemical_fertilizer'),
        _buildCheckboxField(l10n.organic, 'organic_fertilizer'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Fertilizer brands/types used',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: 2,
          onSaved: (value) => _pageData['fertilizer_types'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Annual fertilizer expenditure (₹)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.currency_rupee),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['fertilizer_expenditure'] = value,
        ),
      ],
    );
  }

  Widget _buildAnimalsPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.animals,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please provide details about your livestock',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        // Animal 1
        _buildAnimalCard(1, l10n),

        const SizedBox(height: 24),

        ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Multiple animal entries coming soon')),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Another Animal'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEquipmentPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.agriculturalEquipment,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please select the agricultural equipment you own',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        _buildCheckboxField(l10n.tractor, 'tractor'),
        _buildCheckboxField(l10n.thresher, 'thresher'),
        _buildCheckboxField(l10n.seedDrill, 'seed_drill'),
        _buildCheckboxField(l10n.sprayer, 'sprayer'),
        _buildCheckboxField(l10n.duster, 'duster'),
        _buildCheckboxField(l10n.dieselEngine, 'diesel_engine'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Other equipment (specify)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['other_equipment'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Equipment condition (Good/Average/Poor)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['equipment_condition'] = value,
        ),
      ],
    );
  }

  Widget _buildEntertainmentPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.entertainmentFacilities,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please select the entertainment facilities available',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        _buildCheckboxField(l10n.smartMobile, 'smart_mobile'),
        _buildCheckboxField(l10n.analogMobile, 'analog_mobile'),
        _buildCheckboxField(l10n.television, 'television'),
        _buildCheckboxField(l10n.radio, 'radio'),
        _buildCheckboxField(l10n.games, 'games'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Other entertainment facilities',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['other_entertainment'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Monthly expenditure on entertainment (₹)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.currency_rupee),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['entertainment_expenditure'] = value,
        ),
      ],
    );
  }

  Widget _buildTransportPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.transportFacilities,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please select the transport facilities available',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        _buildCheckboxField(l10n.carJeep, 'car_jeep'),
        _buildCheckboxField(l10n.motorcycleScooter, 'motorcycle_scooter'),
        _buildCheckboxField(l10n.eRickshaw, 'e_rickshaw'),
        _buildCheckboxField(l10n.cycle, 'cycle'),
        _buildCheckboxField(l10n.pickupTruck, 'pickup_truck'),
        _buildCheckboxField(l10n.bullockCart, 'bullock_cart'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Other transport facilities',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['other_transport'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Distance to nearest market (${l10n.distance})',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.straighten),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['market_distance'] = value,
        ),
      ],
    );
  }

  Widget _buildWaterSourcesPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.drinkingWaterSources,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please select the drinking water sources available',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        _buildCheckboxField(l10n.handPumps, 'hand_pumps'),
        _buildCheckboxField(l10n.well, 'well'),
        _buildCheckboxField(l10n.tubewell, 'tubewell'),
        _buildCheckboxField(l10n.nalJaal, 'nal_jaal'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Primary drinking water source',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.water_drop),
          ),
          onSaved: (value) => _pageData['primary_drinking_water'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Water quality (Good/Average/Poor)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['water_quality'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Monthly water expenditure (₹)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.currency_rupee),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['water_expenditure'] = value,
        ),
      ],
    );
  }

  Widget _buildMedicalPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.medicalTreatment,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please select the medical treatment options used',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        _buildCheckboxField(l10n.allopathic, 'allopathic'),
        _buildCheckboxField(l10n.ayurvedic, 'ayurvedic'),
        _buildCheckboxField(l10n.homeopathy, 'homeopathy'),
        _buildCheckboxField(l10n.traditional, 'traditional'),
        _buildCheckboxField(l10n.jhadPhook, 'jhad_phook'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Distance to nearest hospital (${l10n.distance})',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.straighten),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['hospital_distance'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Monthly medical expenditure (₹)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.currency_rupee),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['medical_expenditure'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Health insurance coverage (Yes/No/Details)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['health_insurance'] = value,
        ),
      ],
    );
  }

  Widget _buildDisputesPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.disputes,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please provide information about any disputes',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        _buildCheckboxField(l10n.familyDisputes, 'family_disputes'),
        _buildCheckboxField(l10n.revenueDisputes, 'revenue_disputes'),
        _buildCheckboxField(l10n.criminalDisputes, 'criminal_disputes'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.disputePeriod,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['dispute_period'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Dispute resolution method',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['dispute_resolution'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Current status of dispute',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['dispute_status'] = value,
        ),
      ],
    );
  }

  Widget _buildHouseConditionsPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.houseConditions,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please provide details about your house conditions',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        Text(
          'House Type:',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        _buildCheckboxField(l10n.katcha, 'katcha_house'),
        _buildCheckboxField(l10n.pakka, 'pakka_house'),
        _buildCheckboxField(l10n.katchaPakka, 'katcha_pakka_house'),
        _buildCheckboxField(l10n.hut, 'hut_house'),

        const SizedBox(height: 24),

        Text(
          l10n.houseFacilities,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        _buildCheckboxField(l10n.toilet, 'toilet'),
        _buildCheckboxField(l10n.drainage, 'drainage'),
        _buildCheckboxField(l10n.soakPit, 'soak_pit'),
        _buildCheckboxField(l10n.cattleShed, 'cattle_shed'),
        _buildCheckboxField(l10n.compostPit, 'compost_pit'),
        _buildCheckboxField(l10n.nadep, 'nadep'),
        _buildCheckboxField(l10n.lpgGas, 'lpg_gas'),
        _buildCheckboxField(l10n.biogas, 'biogas'),
        _buildCheckboxField(l10n.solarCooking, 'solar_cooking'),
        _buildCheckboxField(l10n.electricConnection, 'electric_connection'),
        _buildCheckboxField(l10n.nutritionalGarden, 'nutritional_garden'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Number of rooms',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['number_of_rooms'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'House ownership (Owned/Rented)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['house_ownership'] = value,
        ),
      ],
    );
  }

  Widget _buildDiseasesPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.seriousDiseases,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please provide information about serious diseases in the family',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        // Disease 1
        _buildDiseaseCard(1, l10n),

        const SizedBox(height: 24),

        ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Multiple disease entries coming soon')),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Another Disease'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),

        const SizedBox(height: 24),

        Text(
          l10n.tulsiPlants,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Number of Tulsi plants',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['tulsi_plants_count'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Tulsi plant benefits',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          maxLines: 2,
          onSaved: (value) => _pageData['tulsi_benefits'] = value,
        ),
      ],
    );
  }

  Widget _buildGovernmentSchemesPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.governmentSchemes,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please provide information about government scheme benefits',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        _buildSchemeCard(l10n.aadhaar, 'aadhaar'),
        _buildSchemeCard(l10n.ayushman, 'ayushman'),
        _buildSchemeCard(l10n.familyId, 'family_id'),
        _buildSchemeCard(l10n.rationCard, 'ration_card'),
        _buildSchemeCard(l10n.samagraId, 'samagra_id'),
        _buildSchemeCard(l10n.tribalCard, 'tribal_card'),
        _buildSchemeCard(l10n.handicappedAllowance, 'handicapped_allowance'),
        _buildSchemeCard(l10n.pensionAllowance, 'pension_allowance'),
        _buildSchemeCard(l10n.widowAllowance, 'widow_allowance'),
      ],
    );
  }

  Widget _buildChildrenPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.childrenData,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please provide information about children in the family',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.birthsLast3Years,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['births_last_3_years'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.infantDeathsLast3Years,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['infant_deaths_last_3_years'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.malnourishedChildren,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['malnourished_children'] = value,
        ),

        const SizedBox(height: 24),

        Text(
          l10n.malnutritionData,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Child 1 malnutrition data
        _buildChildMalnutritionCard(1, l10n),

        const SizedBox(height: 24),

        ElevatedButton.icon(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Multiple child entries coming soon')),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Add Another Child'),
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMigrationPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.migration,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please provide information about family migration',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        Text(
          l10n.migrationType,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        _buildCheckboxField(l10n.permanent, 'permanent_migration'),
        _buildCheckboxField(l10n.seasonal, 'seasonal_migration'),
        _buildCheckboxField(l10n.asNeeded, 'as_needed_migration'),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.jobDescription,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['migration_job_description'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Migration destination',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['migration_destination'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: 'Monthly remittance received (₹)',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIcon: const Icon(Icons.currency_rupee),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['monthly_remittance'] = value,
        ),
      ],
    );
  }

  Widget _buildTrainingPage(AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.training,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Please provide information about training and self-help groups',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.trainingType,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['training_type'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.institute,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['training_institute'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.yearOfPassing,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          keyboardType: TextInputType.number,
          onSaved: (value) => _pageData['year_of_passing'] = value,
        ),

        const SizedBox(height: 24),

        Text(
          l10n.selfHelpGroups,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.shgName,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['shg_name'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.purpose,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['shg_purpose'] = value,
        ),

        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.agency,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['shg_agency'] = value,
        ),

        const SizedBox(height: 24),

        Text(
          l10n.fpoMembership,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        TextFormField(
          decoration: InputDecoration(
            labelText: l10n.fpoName,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onSaved: (value) => _pageData['fpo_name'] = value,
        ),
      ],
    );
  }

  Widget _buildFinalPage(AppLocalizations l10n) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.check_circle,
          size: 80,
          color: Colors.green,
        ),
        const SizedBox(height: 24),
        Text(
          'Review Your Answers',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Please review all your answers before submitting the survey.',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPlaceholderPage(String title, AppLocalizations l10n) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.construction,
          size: 60,
          color: Colors.grey[400],
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'This section is under development',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Future<void> _handleNext() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      // Save to local database
      try {
        final db = DatabaseHelper();
        await db.saveSurveyData(_pageData);

        // Update provider
        ref.read(surveyProvider.notifier).updateSurveyDataMap(_pageData);

        // Navigate to next page
        widget.onNext();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error saving data: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
