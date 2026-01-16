import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../l10n/app_localizations.dart';
import '../../providers/survey_provider.dart';
import 'widgets/progress_bar.dart';
import 'widgets/side_navigation.dart';
import 'widgets/survey_page.dart';

class SurveyScreen extends ConsumerStatefulWidget {
  const SurveyScreen({super.key});

  @override
  ConsumerState<SurveyScreen> createState() => _SurveyScreenState();
}

class _SurveyScreenState extends ConsumerState<SurveyScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final surveyState = ref.watch(surveyProvider);
    final surveyNotifier = ref.read(surveyProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          ),
        ],
      ),
      drawer: const SideNavigation(),
      body: Column(
        children: [
          // Progress Bar
          SurveyProgressBar(
            currentPage: surveyState.currentPage,
            totalPages: surveyState.totalPages,
          ),

          // Survey Pages
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: surveyState.totalPages,
              itemBuilder: (context, index) {
                return SurveyPage(
                  pageIndex: index,
                  onNext: () {
                    if (index < surveyState.totalPages - 1) {
                      // Validate constraints before proceeding
                      if (_validatePageConstraints(index)) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        surveyNotifier.nextPage();
                      } else {
                        _showConstraintError(index);
                      }
                    } else {
                      // Complete survey
                      _showCompletionDialog();
                    }
                  },
                  onPrevious: index > 0
                      ? () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                          surveyNotifier.previousPage();
                        }
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog() {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(l10n.surveyCompleted),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 48,
            ),
            const SizedBox(height: 16),
            Text('Thank you for completing the family survey!'),
            const SizedBox(height: 8),
            Text(
              'Your responses have been saved locally and will be synced when network is available.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate back to landing page
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Text('Return to Home'),
          ),
        ],
      ),
    );
  }

  bool _validatePageConstraints(int pageIndex) {
    final surveyData = ref.read(surveyProvider).surveyData;

    switch (pageIndex) {
      case 0: // Location - village name is required
        return surveyData['village_name']?.isNotEmpty ?? false;

      case 1: // Family Details - head of family name and age required
        return (surveyData['member_1_name']?.isNotEmpty ?? false) &&
               (surveyData['member_1_age']?.isNotEmpty ?? false);

      case 2: // Social Consciousness - at least one question answered
        return (surveyData['clothes_frequency']?.isNotEmpty ?? false) ||
               (surveyData['food_waste']?.isNotEmpty ?? false) ||
               (surveyData['waste_segregation']?.isNotEmpty ?? false);

      case 3: // Land Holding - at least one field should be filled
        return (surveyData['irrigated_area']?.isNotEmpty ?? false) ||
               (surveyData['cultivable_area']?.isNotEmpty ?? false);

      case 4: // Irrigation - at least one source selected
        return (surveyData['canal'] == true) ||
               (surveyData['tube_well'] == true) ||
               (surveyData['ponds'] == true) ||
               (surveyData['other_facilities'] == true);

      case 5: // Crop Productivity - at least one crop defined
        return surveyData['crop_1_name']?.isNotEmpty ?? false;

      case 6: // Fertilizer - at least one type selected
        return (surveyData['chemical_fertilizer'] == true) ||
               (surveyData['organic_fertilizer'] == true);

      case 7: // Animals - at least one animal if any livestock
        return surveyData['animal_1_type']?.isNotEmpty ?? true; // Optional

      case 8: // Equipment - at least one equipment selected
        return (surveyData['tractor'] == true) ||
               (surveyData['thresher'] == true) ||
               (surveyData['seed_drill'] == true) ||
               (surveyData['sprayer'] == true) ||
               (surveyData['duster'] == true) ||
               (surveyData['diesel_engine'] == true);

      case 9: // Entertainment - at least one facility
        return (surveyData['smart_mobile'] == true) ||
               (surveyData['analog_mobile'] == true) ||
               (surveyData['television'] == true) ||
               (surveyData['radio'] == true) ||
               (surveyData['games'] == true);

      case 10: // Transport - at least one facility
        return (surveyData['car_jeep'] == true) ||
               (surveyData['motorcycle_scooter'] == true) ||
               (surveyData['e_rickshaw'] == true) ||
               (surveyData['cycle'] == true) ||
               (surveyData['pickup_truck'] == true) ||
               (surveyData['bullock_cart'] == true);

      case 11: // Water Sources - at least one source
        return (surveyData['hand_pumps'] == true) ||
               (surveyData['well'] == true) ||
               (surveyData['tubewell'] == true) ||
               (surveyData['nal_jaal'] == true);

      case 12: // Medical - at least one treatment type
        return (surveyData['allopathic'] == true) ||
               (surveyData['ayurvedic'] == true) ||
               (surveyData['homeopathy'] == true) ||
               (surveyData['traditional'] == true) ||
               (surveyData['jhad_phook'] == true);

      case 13: // Disputes - optional
        return true;

      case 14: // House Conditions - at least one house type
        return (surveyData['katcha_house'] == true) ||
               (surveyData['pakka_house'] == true) ||
               (surveyData['katcha_pakka_house'] == true) ||
               (surveyData['hut_house'] == true);

      case 15: // Diseases - optional
        return true;

      case 16: // Government Schemes - at least Aadhaar checked
        return surveyData['aadhaar_have_card'] != null;

      case 17: // Children - basic info provided
        return surveyData['births_last_3_years'] != null ||
               surveyData['infant_deaths_last_3_years'] != null;

      case 18: // Migration - optional
        return true;

      case 19: // Training - optional
        return true;

      case 20: // Final page - always valid
        return true;

      default:
        return true;
    }
  }

  void _showConstraintError(int pageIndex) {
    final l10n = AppLocalizations.of(context)!;
    String errorMessage = 'Please complete the required fields before proceeding.';

    switch (pageIndex) {
      case 0:
        errorMessage = 'Please enter the village name to continue.';
        break;
      case 1:
        errorMessage = 'Please provide head of family details (name and age).';
        break;
      case 2:
        errorMessage = 'Please answer at least one social consciousness question.';
        break;
      case 3:
        errorMessage = 'Please provide land holding information.';
        break;
      case 4:
        errorMessage = 'Please select at least one irrigation facility.';
        break;
      case 5:
        errorMessage = 'Please provide crop productivity information.';
        break;
      case 6:
        errorMessage = 'Please select fertilizer usage type.';
        break;
      case 8:
        errorMessage = 'Please select agricultural equipment owned.';
        break;
      case 9:
        errorMessage = 'Please select entertainment facilities available.';
        break;
      case 10:
        errorMessage = 'Please select transport facilities available.';
        break;
      case 11:
        errorMessage = 'Please select drinking water sources.';
        break;
      case 12:
        errorMessage = 'Please select medical treatment options.';
        break;
      case 14:
        errorMessage = 'Please select house type.';
        break;
      case 16:
        errorMessage = 'Please check Aadhaar card status.';
        break;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(errorMessage),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
