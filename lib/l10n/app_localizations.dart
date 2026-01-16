import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Family Survey'**
  String get appTitle;

  /// No description provided for @startFamilyQuiz.
  ///
  /// In en, this message translates to:
  /// **'Start Family Quiz'**
  String get startFamilyQuiz;

  /// No description provided for @villageName.
  ///
  /// In en, this message translates to:
  /// **'Village Name'**
  String get villageName;

  /// No description provided for @panchayat.
  ///
  /// In en, this message translates to:
  /// **'Panchayat'**
  String get panchayat;

  /// No description provided for @block.
  ///
  /// In en, this message translates to:
  /// **'Block'**
  String get block;

  /// No description provided for @tehsil.
  ///
  /// In en, this message translates to:
  /// **'Tehsil'**
  String get tehsil;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @postalAddress.
  ///
  /// In en, this message translates to:
  /// **'Postal Address'**
  String get postalAddress;

  /// No description provided for @pinCode.
  ///
  /// In en, this message translates to:
  /// **'Pin Code'**
  String get pinCode;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'हिंदी'**
  String get hindi;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @enterPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number'**
  String get enterPhoneNumber;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @enterOtp.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP'**
  String get enterOtp;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @familyDetails.
  ///
  /// In en, this message translates to:
  /// **'Family Details'**
  String get familyDetails;

  /// No description provided for @memberName.
  ///
  /// In en, this message translates to:
  /// **'Member Name'**
  String get memberName;

  /// No description provided for @age.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// No description provided for @sex.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get sex;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @relation.
  ///
  /// In en, this message translates to:
  /// **'Relation'**
  String get relation;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @occupation.
  ///
  /// In en, this message translates to:
  /// **'Occupation'**
  String get occupation;

  /// No description provided for @addMember.
  ///
  /// In en, this message translates to:
  /// **'Add Member'**
  String get addMember;

  /// No description provided for @landHolding.
  ///
  /// In en, this message translates to:
  /// **'Land Holding'**
  String get landHolding;

  /// No description provided for @irrigatedArea.
  ///
  /// In en, this message translates to:
  /// **'Irrigated Area (Acres)'**
  String get irrigatedArea;

  /// No description provided for @cultivableArea.
  ///
  /// In en, this message translates to:
  /// **'Cultivable Area (Acres)'**
  String get cultivableArea;

  /// No description provided for @orchardPlants.
  ///
  /// In en, this message translates to:
  /// **'Orchard Plants'**
  String get orchardPlants;

  /// No description provided for @irrigationFacilities.
  ///
  /// In en, this message translates to:
  /// **'Irrigation Facilities'**
  String get irrigationFacilities;

  /// No description provided for @canal.
  ///
  /// In en, this message translates to:
  /// **'Canal'**
  String get canal;

  /// No description provided for @tubeWell.
  ///
  /// In en, this message translates to:
  /// **'Tube Well'**
  String get tubeWell;

  /// No description provided for @ponds.
  ///
  /// In en, this message translates to:
  /// **'Ponds'**
  String get ponds;

  /// No description provided for @otherFacilities.
  ///
  /// In en, this message translates to:
  /// **'Other Facilities'**
  String get otherFacilities;

  /// No description provided for @cropProductivity.
  ///
  /// In en, this message translates to:
  /// **'Crop Productivity'**
  String get cropProductivity;

  /// No description provided for @cropName.
  ///
  /// In en, this message translates to:
  /// **'Crop Name'**
  String get cropName;

  /// No description provided for @areaAcres.
  ///
  /// In en, this message translates to:
  /// **'Area (Acres)'**
  String get areaAcres;

  /// No description provided for @productivity.
  ///
  /// In en, this message translates to:
  /// **'Productivity (Quintal/Acre)'**
  String get productivity;

  /// No description provided for @totalProduction.
  ///
  /// In en, this message translates to:
  /// **'Total Production'**
  String get totalProduction;

  /// No description provided for @quantityConsumed.
  ///
  /// In en, this message translates to:
  /// **'Quantity Consumed'**
  String get quantityConsumed;

  /// No description provided for @quantitySold.
  ///
  /// In en, this message translates to:
  /// **'Quantity Sold'**
  String get quantitySold;

  /// No description provided for @fertilizerUsage.
  ///
  /// In en, this message translates to:
  /// **'Fertilizer Usage'**
  String get fertilizerUsage;

  /// No description provided for @chemical.
  ///
  /// In en, this message translates to:
  /// **'Chemical'**
  String get chemical;

  /// No description provided for @organic.
  ///
  /// In en, this message translates to:
  /// **'Organic'**
  String get organic;

  /// No description provided for @animals.
  ///
  /// In en, this message translates to:
  /// **'Animals'**
  String get animals;

  /// No description provided for @animalType.
  ///
  /// In en, this message translates to:
  /// **'Animal Type'**
  String get animalType;

  /// No description provided for @numberOfAnimals.
  ///
  /// In en, this message translates to:
  /// **'Number of Animals'**
  String get numberOfAnimals;

  /// No description provided for @breed.
  ///
  /// In en, this message translates to:
  /// **'Breed'**
  String get breed;

  /// No description provided for @productionPerAnimal.
  ///
  /// In en, this message translates to:
  /// **'Production per Animal'**
  String get productionPerAnimal;

  /// No description provided for @agriculturalEquipment.
  ///
  /// In en, this message translates to:
  /// **'Agricultural Equipment'**
  String get agriculturalEquipment;

  /// No description provided for @tractor.
  ///
  /// In en, this message translates to:
  /// **'Tractor'**
  String get tractor;

  /// No description provided for @thresher.
  ///
  /// In en, this message translates to:
  /// **'Thresher'**
  String get thresher;

  /// No description provided for @seedDrill.
  ///
  /// In en, this message translates to:
  /// **'Seed Drill'**
  String get seedDrill;

  /// No description provided for @sprayer.
  ///
  /// In en, this message translates to:
  /// **'Sprayer'**
  String get sprayer;

  /// No description provided for @duster.
  ///
  /// In en, this message translates to:
  /// **'Duster'**
  String get duster;

  /// No description provided for @dieselEngine.
  ///
  /// In en, this message translates to:
  /// **'Diesel Engine'**
  String get dieselEngine;

  /// No description provided for @entertainmentFacilities.
  ///
  /// In en, this message translates to:
  /// **'Entertainment Facilities'**
  String get entertainmentFacilities;

  /// No description provided for @smartMobile.
  ///
  /// In en, this message translates to:
  /// **'Smart Mobile'**
  String get smartMobile;

  /// No description provided for @analogMobile.
  ///
  /// In en, this message translates to:
  /// **'Analog Mobile'**
  String get analogMobile;

  /// No description provided for @television.
  ///
  /// In en, this message translates to:
  /// **'Television'**
  String get television;

  /// No description provided for @radio.
  ///
  /// In en, this message translates to:
  /// **'Radio'**
  String get radio;

  /// No description provided for @games.
  ///
  /// In en, this message translates to:
  /// **'Games'**
  String get games;

  /// No description provided for @transportFacilities.
  ///
  /// In en, this message translates to:
  /// **'Transport Facilities'**
  String get transportFacilities;

  /// No description provided for @carJeep.
  ///
  /// In en, this message translates to:
  /// **'Car/Jeep'**
  String get carJeep;

  /// No description provided for @motorcycleScooter.
  ///
  /// In en, this message translates to:
  /// **'Motorcycle/Scooter'**
  String get motorcycleScooter;

  /// No description provided for @eRickshaw.
  ///
  /// In en, this message translates to:
  /// **'E-Rickshaw'**
  String get eRickshaw;

  /// No description provided for @cycle.
  ///
  /// In en, this message translates to:
  /// **'Cycle'**
  String get cycle;

  /// No description provided for @pickupTruck.
  ///
  /// In en, this message translates to:
  /// **'Pickup Truck'**
  String get pickupTruck;

  /// No description provided for @bullockCart.
  ///
  /// In en, this message translates to:
  /// **'Bullock Cart'**
  String get bullockCart;

  /// No description provided for @drinkingWaterSources.
  ///
  /// In en, this message translates to:
  /// **'Drinking Water Sources'**
  String get drinkingWaterSources;

  /// No description provided for @handPumps.
  ///
  /// In en, this message translates to:
  /// **'Hand Pumps'**
  String get handPumps;

  /// No description provided for @well.
  ///
  /// In en, this message translates to:
  /// **'Well'**
  String get well;

  /// No description provided for @tubewell.
  ///
  /// In en, this message translates to:
  /// **'Tubewell'**
  String get tubewell;

  /// No description provided for @nalJaal.
  ///
  /// In en, this message translates to:
  /// **'Nal Jaal'**
  String get nalJaal;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance (km)'**
  String get distance;

  /// No description provided for @medicalTreatment.
  ///
  /// In en, this message translates to:
  /// **'Medical Treatment'**
  String get medicalTreatment;

  /// No description provided for @allopathic.
  ///
  /// In en, this message translates to:
  /// **'Allopathic'**
  String get allopathic;

  /// No description provided for @ayurvedic.
  ///
  /// In en, this message translates to:
  /// **'Ayurvedic'**
  String get ayurvedic;

  /// No description provided for @homeopathy.
  ///
  /// In en, this message translates to:
  /// **'Homeopathy'**
  String get homeopathy;

  /// No description provided for @traditional.
  ///
  /// In en, this message translates to:
  /// **'Traditional'**
  String get traditional;

  /// No description provided for @jhadPhook.
  ///
  /// In en, this message translates to:
  /// **'Jhad Phook'**
  String get jhadPhook;

  /// No description provided for @disputes.
  ///
  /// In en, this message translates to:
  /// **'Disputes'**
  String get disputes;

  /// No description provided for @familyDisputes.
  ///
  /// In en, this message translates to:
  /// **'Family Disputes'**
  String get familyDisputes;

  /// No description provided for @revenueDisputes.
  ///
  /// In en, this message translates to:
  /// **'Revenue Disputes'**
  String get revenueDisputes;

  /// No description provided for @criminalDisputes.
  ///
  /// In en, this message translates to:
  /// **'Criminal Disputes'**
  String get criminalDisputes;

  /// No description provided for @disputePeriod.
  ///
  /// In en, this message translates to:
  /// **'Dispute Period'**
  String get disputePeriod;

  /// No description provided for @houseConditions.
  ///
  /// In en, this message translates to:
  /// **'House Conditions'**
  String get houseConditions;

  /// No description provided for @katcha.
  ///
  /// In en, this message translates to:
  /// **'Katcha'**
  String get katcha;

  /// No description provided for @pakka.
  ///
  /// In en, this message translates to:
  /// **'Pakka'**
  String get pakka;

  /// No description provided for @katchaPakka.
  ///
  /// In en, this message translates to:
  /// **'Katcha-Pakka'**
  String get katchaPakka;

  /// No description provided for @hut.
  ///
  /// In en, this message translates to:
  /// **'Hut'**
  String get hut;

  /// No description provided for @houseFacilities.
  ///
  /// In en, this message translates to:
  /// **'House Facilities'**
  String get houseFacilities;

  /// No description provided for @toilet.
  ///
  /// In en, this message translates to:
  /// **'Toilet'**
  String get toilet;

  /// No description provided for @drainage.
  ///
  /// In en, this message translates to:
  /// **'Drainage'**
  String get drainage;

  /// No description provided for @soakPit.
  ///
  /// In en, this message translates to:
  /// **'Soak Pit'**
  String get soakPit;

  /// No description provided for @cattleShed.
  ///
  /// In en, this message translates to:
  /// **'Cattle Shed'**
  String get cattleShed;

  /// No description provided for @compostPit.
  ///
  /// In en, this message translates to:
  /// **'Compost Pit'**
  String get compostPit;

  /// No description provided for @nadep.
  ///
  /// In en, this message translates to:
  /// **'NADEP'**
  String get nadep;

  /// No description provided for @lpgGas.
  ///
  /// In en, this message translates to:
  /// **'LPG Gas'**
  String get lpgGas;

  /// No description provided for @biogas.
  ///
  /// In en, this message translates to:
  /// **'Biogas'**
  String get biogas;

  /// No description provided for @solarCooking.
  ///
  /// In en, this message translates to:
  /// **'Solar Cooking'**
  String get solarCooking;

  /// No description provided for @electricConnection.
  ///
  /// In en, this message translates to:
  /// **'Electric Connection'**
  String get electricConnection;

  /// No description provided for @nutritionalGarden.
  ///
  /// In en, this message translates to:
  /// **'Nutritional Kitchen Garden'**
  String get nutritionalGarden;

  /// No description provided for @seriousDiseases.
  ///
  /// In en, this message translates to:
  /// **'Serious Diseases'**
  String get seriousDiseases;

  /// No description provided for @diseaseName.
  ///
  /// In en, this message translates to:
  /// **'Disease Name'**
  String get diseaseName;

  /// No description provided for @sufferingSince.
  ///
  /// In en, this message translates to:
  /// **'Suffering Since'**
  String get sufferingSince;

  /// No description provided for @treatmentFrom.
  ///
  /// In en, this message translates to:
  /// **'Treatment From'**
  String get treatmentFrom;

  /// No description provided for @governmentSchemes.
  ///
  /// In en, this message translates to:
  /// **'Government Schemes'**
  String get governmentSchemes;

  /// No description provided for @haveCard.
  ///
  /// In en, this message translates to:
  /// **'Have Card'**
  String get haveCard;

  /// No description provided for @nameIncluded.
  ///
  /// In en, this message translates to:
  /// **'Name Included'**
  String get nameIncluded;

  /// No description provided for @detailsCorrect.
  ///
  /// In en, this message translates to:
  /// **'Details Correct'**
  String get detailsCorrect;

  /// No description provided for @eligible.
  ///
  /// In en, this message translates to:
  /// **'Eligible'**
  String get eligible;

  /// No description provided for @registered.
  ///
  /// In en, this message translates to:
  /// **'Registered'**
  String get registered;

  /// No description provided for @aadhaar.
  ///
  /// In en, this message translates to:
  /// **'Aadhaar'**
  String get aadhaar;

  /// No description provided for @ayushman.
  ///
  /// In en, this message translates to:
  /// **'Ayushman'**
  String get ayushman;

  /// No description provided for @familyId.
  ///
  /// In en, this message translates to:
  /// **'Family ID'**
  String get familyId;

  /// No description provided for @rationCard.
  ///
  /// In en, this message translates to:
  /// **'Ration Card'**
  String get rationCard;

  /// No description provided for @samagraId.
  ///
  /// In en, this message translates to:
  /// **'Samagra ID'**
  String get samagraId;

  /// No description provided for @tribalCard.
  ///
  /// In en, this message translates to:
  /// **'Tribal Card'**
  String get tribalCard;

  /// No description provided for @handicappedAllowance.
  ///
  /// In en, this message translates to:
  /// **'Handicapped Allowance'**
  String get handicappedAllowance;

  /// No description provided for @pensionAllowance.
  ///
  /// In en, this message translates to:
  /// **'Pension Allowance'**
  String get pensionAllowance;

  /// No description provided for @widowAllowance.
  ///
  /// In en, this message translates to:
  /// **'Widow Allowance'**
  String get widowAllowance;

  /// No description provided for @folkloreMedicine.
  ///
  /// In en, this message translates to:
  /// **'Folklore Medicine'**
  String get folkloreMedicine;

  /// No description provided for @plantLocalName.
  ///
  /// In en, this message translates to:
  /// **'Plant Local Name'**
  String get plantLocalName;

  /// No description provided for @plantBotanicalName.
  ///
  /// In en, this message translates to:
  /// **'Plant Botanical Name'**
  String get plantBotanicalName;

  /// No description provided for @plantUses.
  ///
  /// In en, this message translates to:
  /// **'Plant Uses'**
  String get plantUses;

  /// No description provided for @healthPrograms.
  ///
  /// In en, this message translates to:
  /// **'Health Programs'**
  String get healthPrograms;

  /// No description provided for @vaccination.
  ///
  /// In en, this message translates to:
  /// **'Vaccination'**
  String get vaccination;

  /// No description provided for @familyPlanning.
  ///
  /// In en, this message translates to:
  /// **'Family Planning'**
  String get familyPlanning;

  /// No description provided for @contraceptiveApplied.
  ///
  /// In en, this message translates to:
  /// **'Contraceptive Applied'**
  String get contraceptiveApplied;

  /// No description provided for @childrenData.
  ///
  /// In en, this message translates to:
  /// **'Children\'s Data'**
  String get childrenData;

  /// No description provided for @birthsLast3Years.
  ///
  /// In en, this message translates to:
  /// **'Births in Last 3 Years'**
  String get birthsLast3Years;

  /// No description provided for @infantDeathsLast3Years.
  ///
  /// In en, this message translates to:
  /// **'Infant Deaths in Last 3 Years'**
  String get infantDeathsLast3Years;

  /// No description provided for @malnourishedChildren.
  ///
  /// In en, this message translates to:
  /// **'Malnourished Children'**
  String get malnourishedChildren;

  /// No description provided for @malnutritionData.
  ///
  /// In en, this message translates to:
  /// **'Malnutrition Data'**
  String get malnutritionData;

  /// No description provided for @height.
  ///
  /// In en, this message translates to:
  /// **'Height (feet)'**
  String get height;

  /// No description provided for @weight.
  ///
  /// In en, this message translates to:
  /// **'Weight (kg)'**
  String get weight;

  /// No description provided for @causeDisease.
  ///
  /// In en, this message translates to:
  /// **'Cause/Disease'**
  String get causeDisease;

  /// No description provided for @tulsiPlants.
  ///
  /// In en, this message translates to:
  /// **'Tulsi Plants'**
  String get tulsiPlants;

  /// No description provided for @migration.
  ///
  /// In en, this message translates to:
  /// **'Migration'**
  String get migration;

  /// No description provided for @migrationType.
  ///
  /// In en, this message translates to:
  /// **'Migration Type'**
  String get migrationType;

  /// No description provided for @permanent.
  ///
  /// In en, this message translates to:
  /// **'Permanent'**
  String get permanent;

  /// No description provided for @seasonal.
  ///
  /// In en, this message translates to:
  /// **'Seasonal'**
  String get seasonal;

  /// No description provided for @asNeeded.
  ///
  /// In en, this message translates to:
  /// **'As Needed'**
  String get asNeeded;

  /// No description provided for @jobDescription.
  ///
  /// In en, this message translates to:
  /// **'Job Description'**
  String get jobDescription;

  /// No description provided for @training.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get training;

  /// No description provided for @trainingType.
  ///
  /// In en, this message translates to:
  /// **'Training Type'**
  String get trainingType;

  /// No description provided for @institute.
  ///
  /// In en, this message translates to:
  /// **'Institute'**
  String get institute;

  /// No description provided for @yearOfPassing.
  ///
  /// In en, this message translates to:
  /// **'Year of Passing'**
  String get yearOfPassing;

  /// No description provided for @selfHelpGroups.
  ///
  /// In en, this message translates to:
  /// **'Self Help Groups'**
  String get selfHelpGroups;

  /// No description provided for @shgName.
  ///
  /// In en, this message translates to:
  /// **'SHG Name'**
  String get shgName;

  /// No description provided for @purpose.
  ///
  /// In en, this message translates to:
  /// **'Purpose'**
  String get purpose;

  /// No description provided for @agency.
  ///
  /// In en, this message translates to:
  /// **'Agency'**
  String get agency;

  /// No description provided for @fpoMembership.
  ///
  /// In en, this message translates to:
  /// **'FPO Membership'**
  String get fpoMembership;

  /// No description provided for @fpoName.
  ///
  /// In en, this message translates to:
  /// **'FPO Name'**
  String get fpoName;

  /// No description provided for @beneficiaryPrograms.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary Programs'**
  String get beneficiaryPrograms;

  /// No description provided for @vbGram.
  ///
  /// In en, this message translates to:
  /// **'VB GRAM'**
  String get vbGram;

  /// No description provided for @pmKisanNidhi.
  ///
  /// In en, this message translates to:
  /// **'PM Kisan Nidhi'**
  String get pmKisanNidhi;

  /// No description provided for @pmKisanSamman.
  ///
  /// In en, this message translates to:
  /// **'PM Kisan Samman'**
  String get pmKisanSamman;

  /// No description provided for @kisanCreditCard.
  ///
  /// In en, this message translates to:
  /// **'Kisan Credit Card'**
  String get kisanCreditCard;

  /// No description provided for @swachhBharat.
  ///
  /// In en, this message translates to:
  /// **'Swachh Bharat'**
  String get swachhBharat;

  /// No description provided for @fasalBima.
  ///
  /// In en, this message translates to:
  /// **'Fasal Bima'**
  String get fasalBima;

  /// No description provided for @received.
  ///
  /// In en, this message translates to:
  /// **'Received'**
  String get received;

  /// No description provided for @daysWorked.
  ///
  /// In en, this message translates to:
  /// **'Days Worked'**
  String get daysWorked;

  /// No description provided for @bankAccounts.
  ///
  /// In en, this message translates to:
  /// **'Bank Accounts'**
  String get bankAccounts;

  /// No description provided for @hasAccount.
  ///
  /// In en, this message translates to:
  /// **'Has Account'**
  String get hasAccount;

  /// No description provided for @socialConsciousness.
  ///
  /// In en, this message translates to:
  /// **'Social Consciousness'**
  String get socialConsciousness;

  /// No description provided for @tribalQuestions.
  ///
  /// In en, this message translates to:
  /// **'Tribal Questions'**
  String get tribalQuestions;

  /// No description provided for @individualForestClaims.
  ///
  /// In en, this message translates to:
  /// **'Individual Forest Claims'**
  String get individualForestClaims;

  /// No description provided for @claimMap.
  ///
  /// In en, this message translates to:
  /// **'Claim Map'**
  String get claimMap;

  /// No description provided for @palashLeafCollector.
  ///
  /// In en, this message translates to:
  /// **'Palash Leaf Collector'**
  String get palashLeafCollector;

  /// No description provided for @collectionAreas.
  ///
  /// In en, this message translates to:
  /// **'Collection Areas'**
  String get collectionAreas;

  /// No description provided for @honeyGatherer.
  ///
  /// In en, this message translates to:
  /// **'Honey Gatherer'**
  String get honeyGatherer;

  /// No description provided for @honeyCollectionAreas.
  ///
  /// In en, this message translates to:
  /// **'Honey Collection Areas'**
  String get honeyCollectionAreas;

  /// No description provided for @ntfpIdentification.
  ///
  /// In en, this message translates to:
  /// **'NTFP Identification'**
  String get ntfpIdentification;

  /// No description provided for @stakeholderShgs.
  ///
  /// In en, this message translates to:
  /// **'Stakeholder SHGs'**
  String get stakeholderShgs;

  /// No description provided for @skillsIdentification.
  ///
  /// In en, this message translates to:
  /// **'Skills Identification'**
  String get skillsIdentification;

  /// No description provided for @surveyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Survey Completed Successfully!'**
  String get surveyCompleted;

  /// No description provided for @dataSavedLocally.
  ///
  /// In en, this message translates to:
  /// **'Data saved locally'**
  String get dataSavedLocally;

  /// No description provided for @syncPending.
  ///
  /// In en, this message translates to:
  /// **'Sync pending'**
  String get syncPending;

  /// No description provided for @syncCompleted.
  ///
  /// In en, this message translates to:
  /// **'Sync completed'**
  String get syncCompleted;

  /// No description provided for @errorSavingData.
  ///
  /// In en, this message translates to:
  /// **'Error saving data'**
  String get errorSavingData;

  /// No description provided for @pleaseFillRequiredFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get pleaseFillRequiredFields;

  /// No description provided for @invalidPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhoneNumber;

  /// No description provided for @invalidOtp.
  ///
  /// In en, this message translates to:
  /// **'Invalid OTP'**
  String get invalidOtp;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error'**
  String get networkError;

  /// No description provided for @syncError.
  ///
  /// In en, this message translates to:
  /// **'Sync error'**
  String get syncError;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
