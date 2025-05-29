// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Homepage`
  String get homescreenTitle {
    return Intl.message(
      'Homepage',
      name: 'homescreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message('Settings', name: 'settingsTitle', desc: '', args: []);
  }

  /// `Welcome`
  String get helloScreen {
    return Intl.message('Welcome', name: 'helloScreen', desc: '', args: []);
  }

  /// `Dashboard`
  String get dashboard {
    return Intl.message('Dashboard', name: 'dashboard', desc: '', args: []);
  }

  /// `Basic Health Measurements`
  String get basicHealthMeasurements {
    return Intl.message(
      'Basic Health Measurements',
      name: 'basicHealthMeasurements',
      desc: '',
      args: [],
    );
  }

  /// `Risk`
  String get risk {
    return Intl.message('Risk', name: 'risk', desc: '', args: []);
  }

  /// `General Health Profile`
  String get generalProfile {
    return Intl.message(
      'General Health Profile',
      name: 'generalProfile',
      desc: '',
      args: [],
    );
  }

  /// `Your health is in your hands! You can make a big difference with small steps.`
  String get healthText {
    return Intl.message(
      'Your health is in your hands! You can make a big difference with small steps.',
      name: 'healthText',
      desc: '',
      args: [],
    );
  }

  /// `• Excellent (80-100)\n• Good (60-79)\n• Average (40-59)\n• Not Good (20-39)\n• Poor (0-19)`
  String get skorInfo {
    return Intl.message(
      '• Excellent (80-100)\n• Good (60-79)\n• Average (40-59)\n• Not Good (20-39)\n• Poor (0-19)',
      name: 'skorInfo',
      desc: '',
      args: [],
    );
  }

  /// `Your Health\nis Our Top Priority.`
  String get motiv {
    return Intl.message(
      'Your Health\nis Our Top Priority.',
      name: 'motiv',
      desc: '',
      args: [],
    );
  }

  /// `Cardiovascular`
  String get kardiyovaskuler {
    return Intl.message(
      'Cardiovascular',
      name: 'kardiyovaskuler',
      desc: '',
      args: [],
    );
  }

  /// `Neurological`
  String get norolojik {
    return Intl.message('Neurological', name: 'norolojik', desc: '', args: []);
  }

  /// `Metabolism`
  String get metabolizma {
    return Intl.message('Metabolism', name: 'metabolizma', desc: '', args: []);
  }

  /// `Immune System`
  String get bagisiklik {
    return Intl.message(
      'Immune System',
      name: 'bagisiklik',
      desc: '',
      args: [],
    );
  }

  /// `Analyse`
  String get analyseTitle {
    return Intl.message('Analyse', name: 'analyseTitle', desc: '', args: []);
  }

  /// `Create Dna Analysis`
  String get testTitle {
    return Intl.message(
      'Create Dna Analysis',
      name: 'testTitle',
      desc: '',
      args: [],
    );
  }

  /// `Results`
  String get barItem2 {
    return Intl.message('Results', name: 'barItem2', desc: '', args: []);
  }

  /// `Medication`
  String get barItem3 {
    return Intl.message('Medication', name: 'barItem3', desc: '', args: []);
  }

  /// `Genetic traits are physical, biological, and sensory characteristics inherited from DNA.`
  String get geneticTraitsDescription {
    return Intl.message(
      'Genetic traits are physical, biological, and sensory characteristics inherited from DNA.',
      name: 'geneticTraitsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Taste Perception`
  String get tastePerception {
    return Intl.message(
      'Taste Perception',
      name: 'tastePerception',
      desc: '',
      args: [],
    );
  }

  /// `Circadian Rhythm`
  String get circadianRhythm {
    return Intl.message(
      'Circadian Rhythm',
      name: 'circadianRhythm',
      desc: '',
      args: [],
    );
  }

  /// `Color Vision`
  String get colorVision {
    return Intl.message(
      'Color Vision',
      name: 'colorVision',
      desc: '',
      args: [],
    );
  }

  /// `Muscle Strength`
  String get muscleStrength {
    return Intl.message(
      'Muscle Strength',
      name: 'muscleStrength',
      desc: '',
      args: [],
    );
  }

  /// `Pain Perception`
  String get painPerception {
    return Intl.message(
      'Pain Perception',
      name: 'painPerception',
      desc: '',
      args: [],
    );
  }

  /// `Immune System Strength`
  String get immuneSystemStrength {
    return Intl.message(
      'Immune System Strength',
      name: 'immuneSystemStrength',
      desc: '',
      args: [],
    );
  }

  /// `Personal Information`
  String get personalInformation {
    return Intl.message(
      'Personal Information',
      name: 'personalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get firstName {
    return Intl.message('Name', name: 'firstName', desc: '', args: []);
  }

  /// `Surname`
  String get lastName {
    return Intl.message('Surname', name: 'lastName', desc: '', args: []);
  }

  /// `Age`
  String get age {
    return Intl.message('Age', name: 'age', desc: '', args: []);
  }

  /// `Gender`
  String get gender {
    return Intl.message('Gender', name: 'gender', desc: '', args: []);
  }

  /// `Ethnicity`
  String get ethnicity {
    return Intl.message('Ethnicity', name: 'ethnicity', desc: '', args: []);
  }

  /// `Current Medications`
  String get currentMedications {
    return Intl.message(
      'Current Medications',
      name: 'currentMedications',
      desc: '',
      args: [],
    );
  }

  /// `Medical History`
  String get medicalHistory {
    return Intl.message(
      'Medical History',
      name: 'medicalHistory',
      desc: '',
      args: [],
    );
  }

  /// `Family History`
  String get familyHistory {
    return Intl.message(
      'Family History',
      name: 'familyHistory',
      desc: '',
      args: [],
    );
  }

  /// `Blood Type`
  String get bloodType {
    return Intl.message('Blood Type', name: 'bloodType', desc: '', args: []);
  }

  /// `Height`
  String get height {
    return Intl.message('Height', name: 'height', desc: '', args: []);
  }

  /// `Weight`
  String get weight {
    return Intl.message('Weight', name: 'weight', desc: '', args: []);
  }

  /// `Hair Color`
  String get hairColor {
    return Intl.message('Hair Color', name: 'hairColor', desc: '', args: []);
  }

  /// `Eye Color`
  String get eyeColor {
    return Intl.message('Eye Color', name: 'eyeColor', desc: '', args: []);
  }

  /// `Allergies`
  String get allergies {
    return Intl.message('Allergies', name: 'allergies', desc: '', args: []);
  }

  /// `Health Risks`
  String get healthRisks {
    return Intl.message(
      'Health Risks',
      name: 'healthRisks',
      desc: '',
      args: [],
    );
  }

  /// `Preventive Medications`
  String get recommendedMedications {
    return Intl.message(
      'Preventive Medications',
      name: 'recommendedMedications',
      desc: '',
      args: [],
    );
  }

  /// `Preventive Measures`
  String get preventiveMeasures {
    return Intl.message(
      'Preventive Measures',
      name: 'preventiveMeasures',
      desc: '',
      args: [],
    );
  }

  /// `Health Risk Assessment`
  String get healthRiskAssessment {
    return Intl.message(
      'Health Risk Assessment',
      name: 'healthRiskAssessment',
      desc: '',
      args: [],
    );
  }

  /// `High-Risk Area`
  String get highRiskArea {
    return Intl.message(
      'High-Risk Area',
      name: 'highRiskArea',
      desc: '',
      args: [],
    );
  }

  /// `Body Mass Index`
  String get bodyMassIndex {
    return Intl.message(
      'Body Mass Index',
      name: 'bodyMassIndex',
      desc: '',
      args: [],
    );
  }

  /// `Blood Pressure`
  String get bloodPressure {
    return Intl.message(
      'Blood Pressure',
      name: 'bloodPressure',
      desc: '',
      args: [],
    );
  }

  /// `Cholesterol`
  String get cholesterol {
    return Intl.message('Cholesterol', name: 'cholesterol', desc: '', args: []);
  }

  /// `Physical Condition`
  String get physicalCondition {
    return Intl.message(
      'Physical Condition',
      name: 'physicalCondition',
      desc: '',
      args: [],
    );
  }

  /// `Blood Sugar`
  String get bloodSugar {
    return Intl.message('Blood Sugar', name: 'bloodSugar', desc: '', args: []);
  }

  /// `Sleep Quality`
  String get sleepQuality {
    return Intl.message(
      'Sleep Quality',
      name: 'sleepQuality',
      desc: '',
      args: [],
    );
  }

  /// `Disease Risk Assessment`
  String get diseaseRisks {
    return Intl.message(
      'Disease Risk Assessment',
      name: 'diseaseRisks',
      desc: '',
      args: [],
    );
  }

  /// `Rheumatoid Arthritis`
  String get rheumatoidArthritis {
    return Intl.message(
      'Rheumatoid Arthritis',
      name: 'rheumatoidArthritis',
      desc: '',
      args: [],
    );
  }

  /// `Alzheimer's Disease`
  String get alzheimersDisease {
    return Intl.message(
      'Alzheimer\'s Disease',
      name: 'alzheimersDisease',
      desc: '',
      args: [],
    );
  }

  /// `Colorectal Cancer`
  String get colorectalCancer {
    return Intl.message(
      'Colorectal Cancer',
      name: 'colorectalCancer',
      desc: '',
      args: [],
    );
  }

  /// `Type 2 Diabetes`
  String get type2Diabetes {
    return Intl.message(
      'Type 2 Diabetes',
      name: 'type2Diabetes',
      desc: '',
      args: [],
    );
  }

  /// `Cardiovascular Disease`
  String get cardiovascularDisease {
    return Intl.message(
      'Cardiovascular Disease',
      name: 'cardiovascularDisease',
      desc: '',
      args: [],
    );
  }

  /// `Strength`
  String get strength {
    return Intl.message('Strength', name: 'strength', desc: '', args: []);
  }

  /// `Flexibility`
  String get flexibility {
    return Intl.message('Flexibility', name: 'flexibility', desc: '', args: []);
  }

  /// `Power`
  String get power {
    return Intl.message('Power', name: 'power', desc: '', args: []);
  }

  /// `Endurance`
  String get endurance {
    return Intl.message('Endurance', name: 'endurance', desc: '', args: []);
  }

  /// `Fitness Profile`
  String get fitnessProfile {
    return Intl.message(
      'Fitness Profile',
      name: 'fitnessProfile',
      desc: '',
      args: [],
    );
  }

  /// `Muscle Fiber Composition`
  String get muscleFiberComposition {
    return Intl.message(
      'Muscle Fiber Composition',
      name: 'muscleFiberComposition',
      desc: '',
      args: [],
    );
  }

  /// `Fast Twitch`
  String get fastTwitch {
    return Intl.message('Fast Twitch', name: 'fastTwitch', desc: '', args: []);
  }

  /// `Slow Twitch`
  String get slowTwitch {
    return Intl.message('Slow Twitch', name: 'slowTwitch', desc: '', args: []);
  }

  /// `Muscle Composition`
  String get muscleComposition {
    return Intl.message(
      'Muscle Composition',
      name: 'muscleComposition',
      desc: '',
      args: [],
    );
  }

  /// `Vitamin & Mineral Needs`
  String get vitaminMineralNeeds {
    return Intl.message(
      'Vitamin & Mineral Needs',
      name: 'vitaminMineralNeeds',
      desc: '',
      args: [],
    );
  }

  /// `Nutrition Overview`
  String get nutritionOverview {
    return Intl.message(
      'Nutrition Overview',
      name: 'nutritionOverview',
      desc: '',
      args: [],
    );
  }

  /// `Metabolic Profile`
  String get metabolicProfile {
    return Intl.message(
      'Metabolic Profile',
      name: 'metabolicProfile',
      desc: '',
      args: [],
    );
  }

  /// `Type`
  String get type {
    return Intl.message('Type', name: 'type', desc: '', args: []);
  }

  /// `Ratio`
  String get ratio {
    return Intl.message('Ratio', name: 'ratio', desc: '', args: []);
  }

  /// `Recommended Diet`
  String get recommendedDiet {
    return Intl.message(
      'Recommended Diet',
      name: 'recommendedDiet',
      desc: '',
      args: [],
    );
  }

  /// `Mineral Needs`
  String get mineralNeeds {
    return Intl.message(
      'Mineral Needs',
      name: 'mineralNeeds',
      desc: '',
      args: [],
    );
  }

  /// `Vitamin Needs`
  String get vitaminNeeds {
    return Intl.message(
      'Vitamin Needs',
      name: 'vitaminNeeds',
      desc: '',
      args: [],
    );
  }

  /// `Caloric Need`
  String get caloricNeed {
    return Intl.message(
      'Caloric Need',
      name: 'caloricNeed',
      desc: '',
      args: [],
    );
  }

  /// `Maintenance`
  String get maintenance {
    return Intl.message('Maintenance', name: 'maintenance', desc: '', args: []);
  }

  /// `Weight Loss`
  String get weightLoss {
    return Intl.message('Weight Loss', name: 'weightLoss', desc: '', args: []);
  }

  /// `Weight Gain`
  String get weightGain {
    return Intl.message('Weight Gain', name: 'weightGain', desc: '', args: []);
  }

  /// `Recommendations`
  String get recommendations {
    return Intl.message(
      'Recommendations',
      name: 'recommendations',
      desc: '',
      args: [],
    );
  }

  /// `Genetic`
  String get geneticTitle {
    return Intl.message('Genetic', name: 'geneticTitle', desc: '', args: []);
  }

  /// `Health`
  String get healthTitle {
    return Intl.message('Health', name: 'healthTitle', desc: '', args: []);
  }

  /// `Nutrition`
  String get nutritionTitle {
    return Intl.message(
      'Nutrition',
      name: 'nutritionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Stay Fit`
  String get fitnessTitle {
    return Intl.message('Stay Fit', name: 'fitnessTitle', desc: '', args: []);
  }

  /// `Medicine Tracking`
  String get medicineTitle {
    return Intl.message(
      'Medicine Tracking',
      name: 'medicineTitle',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get total {
    return Intl.message('Total', name: 'total', desc: '', args: []);
  }

  /// `Taken`
  String get taken {
    return Intl.message('Taken', name: 'taken', desc: '', args: []);
  }

  /// `Upcoming`
  String get upcoming {
    return Intl.message('Upcoming', name: 'upcoming', desc: '', args: []);
  }

  /// `Missed`
  String get missed {
    return Intl.message('Missed', name: 'missed', desc: '', args: []);
  }

  /// `Delete Medicine`
  String get deleteMedicineTitle {
    return Intl.message(
      'Delete Medicine',
      name: 'deleteMedicineTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this medicine?`
  String get deleteMedicineConfirmation {
    return Intl.message(
      'Are you sure you want to delete this medicine?',
      name: 'deleteMedicineConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Basic Information`
  String get basicInformation {
    return Intl.message(
      'Basic Information',
      name: 'basicInformation',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Name`
  String get medicineName {
    return Intl.message(
      'Medicine Name',
      name: 'medicineName',
      desc: '',
      args: [],
    );
  }

  /// `Dosage`
  String get dosage {
    return Intl.message('Dosage', name: 'dosage', desc: '', args: []);
  }

  /// `Start Date`
  String get startDate {
    return Intl.message('Start Date', name: 'startDate', desc: '', args: []);
  }

  /// `Intake Time`
  String get intakeTime {
    return Intl.message('Intake Time', name: 'intakeTime', desc: '', args: []);
  }

  /// `Notes`
  String get notes {
    return Intl.message('Notes', name: 'notes', desc: '', args: []);
  }

  /// `Today's Overview`
  String get todaysOverview {
    return Intl.message(
      'Today\'s Overview',
      name: 'todaysOverview',
      desc: '',
      args: [],
    );
  }

  /// `Search medicine...`
  String get searchMedicine {
    return Intl.message(
      'Search medicine...',
      name: 'searchMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Add Medicine Image`
  String get addMedicineImage {
    return Intl.message(
      'Add Medicine Image',
      name: 'addMedicineImage',
      desc: '',
      args: [],
    );
  }

  /// `Medicine Details`
  String get medicineDetails {
    return Intl.message(
      'Medicine Details',
      name: 'medicineDetails',
      desc: '',
      args: [],
    );
  }

  /// `Unit`
  String get unit {
    return Intl.message('Unit', name: 'unit', desc: '', args: []);
  }

  /// `Schedule and Reminders`
  String get scheduleAndReminders {
    return Intl.message(
      'Schedule and Reminders',
      name: 'scheduleAndReminders',
      desc: '',
      args: [],
    );
  }

  /// `Frequency`
  String get frequency {
    return Intl.message('Frequency', name: 'frequency', desc: '', args: []);
  }

  /// `Times`
  String get times {
    return Intl.message('Times', name: 'times', desc: '', args: []);
  }

  /// `Add Time`
  String get addTime {
    return Intl.message('Add Time', name: 'addTime', desc: '', args: []);
  }

  /// `End Date (optional)`
  String get endDateOptional {
    return Intl.message(
      'End Date (optional)',
      name: 'endDateOptional',
      desc: '',
      args: [],
    );
  }

  /// `Select`
  String get select {
    return Intl.message('Select', name: 'select', desc: '', args: []);
  }

  /// `Reminder Settings`
  String get reminderSettings {
    return Intl.message(
      'Reminder Settings',
      name: 'reminderSettings',
      desc: '',
      args: [],
    );
  }

  /// `Add additional notes or instructions about this medicine`
  String get notesHint {
    return Intl.message(
      'Add additional notes or instructions about this medicine',
      name: 'notesHint',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message('Update', name: 'update', desc: '', args: []);
  }

  /// `Save Medicine`
  String get saveMedicine {
    return Intl.message(
      'Save Medicine',
      name: 'saveMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Edit Medicine`
  String get editMedicine {
    return Intl.message(
      'Edit Medicine',
      name: 'editMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Add New Medicine`
  String get addNewMedicine {
    return Intl.message(
      'Add New Medicine',
      name: 'addNewMedicine',
      desc: '',
      args: [],
    );
  }

  /// `Once daily`
  String get onceDaily {
    return Intl.message('Once daily', name: 'onceDaily', desc: '', args: []);
  }

  /// `Twice daily`
  String get twiceDaily {
    return Intl.message('Twice daily', name: 'twiceDaily', desc: '', args: []);
  }

  /// `Three times daily`
  String get threeTimesDaily {
    return Intl.message(
      'Three times daily',
      name: 'threeTimesDaily',
      desc: '',
      args: [],
    );
  }

  /// `Four times daily`
  String get fourTimesDaily {
    return Intl.message(
      'Four times daily',
      name: 'fourTimesDaily',
      desc: '',
      args: [],
    );
  }

  /// `Once weekly`
  String get onceWeekly {
    return Intl.message('Once weekly', name: 'onceWeekly', desc: '', args: []);
  }

  /// `Once monthly`
  String get onceMonthly {
    return Intl.message(
      'Once monthly',
      name: 'onceMonthly',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Medicine Name!`
  String get pleaseEnterMedicineName {
    return Intl.message(
      'Please Enter Medicine Name!',
      name: 'pleaseEnterMedicineName',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Dosage!`
  String get pleaseEnterDosage {
    return Intl.message(
      'Please Enter Dosage!',
      name: 'pleaseEnterDosage',
      desc: '',
      args: [],
    );
  }

  /// `please Select Unit!`
  String get pleaseSelectUnit {
    return Intl.message(
      'please Select Unit!',
      name: 'pleaseSelectUnit',
      desc: '',
      args: [],
    );
  }

  /// `Please select frequency`
  String get pleaseSelectFrequency {
    return Intl.message(
      'Please select frequency',
      name: 'pleaseSelectFrequency',
      desc: '',
      args: [],
    );
  }

  /// `Add additional notes or instructions about this medicine`
  String get medicineNotesHint {
    return Intl.message(
      'Add additional notes or instructions about this medicine',
      name: 'medicineNotesHint',
      desc: '',
      args: [],
    );
  }

  /// `Daily`
  String get daily {
    return Intl.message('Daily', name: 'daily', desc: '', args: []);
  }

  /// `End Date`
  String get endDate {
    return Intl.message('End Date', name: 'endDate', desc: '', args: []);
  }

  /// `DNA\nAnalysis`
  String get dnaAnalysisTitle {
    return Intl.message(
      'DNA\nAnalysis',
      name: 'dnaAnalysisTitle',
      desc: '',
      args: [],
    );
  }

  /// `Discover your unique genetic makeup with our cutting-edge analysis technology.`
  String get dnaAnalysisDesc {
    return Intl.message(
      'Discover your unique genetic makeup with our cutting-edge analysis technology.',
      name: 'dnaAnalysisDesc',
      desc: '',
      args: [],
    );
  }

  /// `Discover your genetic structure and get to know your health more closely. Learn about your disease predispositions through your DNA analysis and receive personalized health recommendations.`
  String get healthDesc {
    return Intl.message(
      'Discover your genetic structure and get to know your health more closely. Learn about your disease predispositions through your DNA analysis and receive personalized health recommendations.',
      name: 'healthDesc',
      desc: '',
      args: [],
    );
  }

  /// `Thanks to your DNA analysis, learn about your genetic disease risks, vitamin and mineral deficiencies, and the most suitable exercises and medications for your body. Live a more conscious and healthy life with health advice tailored to your genetic makeup.`
  String get fitnessDesc {
    return Intl.message(
      'Thanks to your DNA analysis, learn about your genetic disease risks, vitamin and mineral deficiencies, and the most suitable exercises and medications for your body. Live a more conscious and healthy life with health advice tailored to your genetic makeup.',
      name: 'fitnessDesc',
      desc: '',
      args: [],
    );
  }

  /// `Let's get to know you`
  String get letUsKnowYou {
    return Intl.message(
      'Let\'s get to know you',
      name: 'letUsKnowYou',
      desc: '',
      args: [],
    );
  }

  /// `Your Name`
  String get authNameTitle {
    return Intl.message('Your Name', name: 'authNameTitle', desc: '', args: []);
  }

  /// `What is your name?`
  String get whatIsYourName {
    return Intl.message(
      'What is your name?',
      name: 'whatIsYourName',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name!`
  String get authNameValid {
    return Intl.message(
      'Please enter your name!',
      name: 'authNameValid',
      desc: '',
      args: [],
    );
  }

  /// `Select your age`
  String get authAgeHint {
    return Intl.message(
      'Select your age',
      name: 'authAgeHint',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get authAgeTitle {
    return Intl.message('Age', name: 'authAgeTitle', desc: '', args: []);
  }

  /// `How old are you?`
  String get whatIsYourAge {
    return Intl.message(
      'How old are you?',
      name: 'whatIsYourAge',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get authPasswordTitle {
    return Intl.message(
      'Password',
      name: 'authPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `Create your password`
  String get createPassword {
    return Intl.message(
      'Create your password',
      name: 'createPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get enterPassword {
    return Intl.message(
      'Please enter your password',
      name: 'enterPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get invalidPassword {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'invalidPassword',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get authEmailTitle {
    return Intl.message('Email', name: 'authEmailTitle', desc: '', args: []);
  }

  /// `Enter Your Name`
  String get authNameHint {
    return Intl.message(
      'Enter Your Name',
      name: 'authNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get invalidEmail {
    return Intl.message(
      'Please enter a valid email address',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `What is your email address?`
  String get whatIsYourEmail {
    return Intl.message(
      'What is your email address?',
      name: 'whatIsYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get passwordCon {
    return Intl.message(
      'Enter your password',
      name: 'passwordCon',
      desc: '',
      args: [],
    );
  }

  /// `Your Health Assessment`
  String get healthAssessmentTitle {
    return Intl.message(
      'Your Health Assessment',
      name: 'healthAssessmentTitle',
      desc: '',
      args: [],
    );
  }

  /// `Your health has been assessed as {healthyPercent}% healthy and {riskPercent}% at risk. To reduce this risk, the following practices are recommended.`
  String healthAssessmentDescription(
    Object healthyPercent,
    Object riskPercent,
  ) {
    return Intl.message(
      'Your health has been assessed as $healthyPercent% healthy and $riskPercent% at risk. To reduce this risk, the following practices are recommended.',
      name: 'healthAssessmentDescription',
      desc: '',
      args: [healthyPercent, riskPercent],
    );
  }

  /// `Genetic Risk Factors`
  String get geneticRiskFactors {
    return Intl.message(
      'Genetic Risk Factors',
      name: 'geneticRiskFactors',
      desc: '',
      args: [],
    );
  }

  /// `Risk Distribution`
  String get riskDistribution {
    return Intl.message(
      'Risk Distribution',
      name: 'riskDistribution',
      desc: '',
      args: [],
    );
  }

  /// `{riskName} risk: {value}%`
  String riskText(Object riskName, Object value) {
    return Intl.message(
      '$riskName risk: $value%',
      name: 'riskText',
      desc: '',
      args: [riskName, value],
    );
  }

  /// `Heart`
  String get heartRisk {
    return Intl.message('Heart', name: 'heartRisk', desc: '', args: []);
  }

  /// `Diabetes`
  String get diabetesRisk {
    return Intl.message('Diabetes', name: 'diabetesRisk', desc: '', args: []);
  }

  /// `Cancer`
  String get cancerRisk {
    return Intl.message('Cancer', name: 'cancerRisk', desc: '', args: []);
  }

  /// `Obesity`
  String get obesityRisk {
    return Intl.message('Obesity', name: 'obesityRisk', desc: '', args: []);
  }

  /// `Alzheimer`
  String get alzheimersRisk {
    return Intl.message(
      'Alzheimer',
      name: 'alzheimersRisk',
      desc: '',
      args: [],
    );
  }

  /// `Review Health Statistics`
  String get healthStatisticsReview {
    return Intl.message(
      'Review Health Statistics',
      name: 'healthStatisticsReview',
      desc: '',
      args: [],
    );
  }

  /// `Review Medications and Their Importance`
  String get medicationsAndImportanceReview {
    return Intl.message(
      'Review Medications and Their Importance',
      name: 'medicationsAndImportanceReview',
      desc: '',
      args: [],
    );
  }

  /// `Results`
  String get results {
    return Intl.message('Results', name: 'results', desc: '', args: []);
  }

  /// `Your Health Status`
  String get yourHealthStatus {
    return Intl.message(
      'Your Health Status',
      name: 'yourHealthStatus',
      desc: '',
      args: [],
    );
  }

  /// `Menu`
  String get quickActions {
    return Intl.message('Menu', name: 'quickActions', desc: '', args: []);
  }

  /// `Genetics`
  String get genetics {
    return Intl.message('Genetics', name: 'genetics', desc: '', args: []);
  }

  /// `Health`
  String get health {
    return Intl.message('Health', name: 'health', desc: '', args: []);
  }

  /// `Nutrition`
  String get nutrition {
    return Intl.message('Nutrition', name: 'nutrition', desc: '', args: []);
  }

  /// `Fitness`
  String get fitness {
    return Intl.message('Fitness', name: 'fitness', desc: '', args: []);
  }

  /// `Recent Activity`
  String get recentActivity {
    return Intl.message(
      'Recent Activity',
      name: 'recentActivity',
      desc: '',
      args: [],
    );
  }

  /// `According to your risk analysis, your health status:`
  String get healthStatusBasedOnRisk {
    return Intl.message(
      'According to your risk analysis, your health status:',
      name: 'healthStatusBasedOnRisk',
      desc: '',
      args: [],
    );
  }

  /// `Risk level:`
  String get riskLevel {
    return Intl.message('Risk level:', name: 'riskLevel', desc: '', args: []);
  }

  /// `DNA Overview`
  String get dnaOverview {
    return Intl.message(
      'DNA Overview',
      name: 'dnaOverview',
      desc: '',
      args: [],
    );
  }

  /// `Later added items:`
  String get laterIdentifiedItems {
    return Intl.message(
      'Later added items:',
      name: 'laterIdentifiedItems',
      desc: '',
      args: [],
    );
  }

  /// `Medications to be used:`
  String get medicationsToBeUsed {
    return Intl.message(
      'Medications to be used:',
      name: 'medicationsToBeUsed',
      desc: '',
      args: [],
    );
  }

  /// `Food Sensitivities`
  String get foodSensitivities {
    return Intl.message(
      'Food Sensitivities',
      name: 'foodSensitivities',
      desc: '',
      args: [],
    );
  }

  /// `Nutritional Recommendations`
  String get nutritionalRecommendations {
    return Intl.message(
      'Nutritional Recommendations',
      name: 'nutritionalRecommendations',
      desc: '',
      args: [],
    );
  }

  /// `Select what type of information from the DNA sequence you want to analyze.`
  String get analysisTypeSelection {
    return Intl.message(
      'Select what type of information from the DNA sequence you want to analyze.',
      name: 'analysisTypeSelection',
      desc: '',
      args: [],
    );
  }

  /// `Comprehensive analysis of your genetic code to identify important variants.`
  String get geneticPredispositions {
    return Intl.message(
      'Comprehensive analysis of your genetic code to identify important variants.',
      name: 'geneticPredispositions',
      desc: '',
      args: [],
    );
  }

  /// `Analyzes your health status and potential risks`
  String get healthAnalysis {
    return Intl.message(
      'Analyzes your health status and potential risks',
      name: 'healthAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Determines personalized diet and nutrition recommendations.`
  String get personalizedDiet {
    return Intl.message(
      'Determines personalized diet and nutrition recommendations.',
      name: 'personalizedDiet',
      desc: '',
      args: [],
    );
  }

  /// `Determines exercise types suitable for genetic makeup.`
  String get exerciseRecommendations {
    return Intl.message(
      'Determines exercise types suitable for genetic makeup.',
      name: 'exerciseRecommendations',
      desc: '',
      args: [],
    );
  }

  /// `Select Analysis Types`
  String get selectAnalysisTypes {
    return Intl.message(
      'Select Analysis Types',
      name: 'selectAnalysisTypes',
      desc: '',
      args: [],
    );
  }

  /// `Tracking Medication`
  String get TrackingMedication {
    return Intl.message(
      'Tracking Medication',
      name: 'TrackingMedication',
      desc: '',
      args: [],
    );
  }

  /// `Recommended Medications:`
  String get RecommendedMeds {
    return Intl.message(
      'Recommended Medications:',
      name: 'RecommendedMeds',
      desc: '',
      args: [],
    );
  }

  /// `Preventive Measures:`
  String get PreventiveMeasures {
    return Intl.message(
      'Preventive Measures:',
      name: 'PreventiveMeasures',
      desc: '',
      args: [],
    );
  }

  /// `No medication or preventive measure recommended.`
  String get NoRecommendation {
    return Intl.message(
      'No medication or preventive measure recommended.',
      name: 'NoRecommendation',
      desc: '',
      args: [],
    );
  }

  /// `These medications and measures help protect your health and reduce risks.`
  String get MedicationAndMeasuresHelp {
    return Intl.message(
      'These medications and measures help protect your health and reduce risks.',
      name: 'MedicationAndMeasuresHelp',
      desc: '',
      args: [],
    );
  }

  /// `Medications and Measures`
  String get MedicationsAndMeasures {
    return Intl.message(
      'Medications and Measures',
      name: 'MedicationsAndMeasures',
      desc: '',
      args: [],
    );
  }

  /// `DNA Analysis Form`
  String get DNAAnalysisForm {
    return Intl.message(
      'DNA Analysis Form',
      name: 'DNAAnalysisForm',
      desc: '',
      args: [],
    );
  }

  /// `DNA Sequence`
  String get EnterDNASequence {
    return Intl.message(
      'DNA Sequence',
      name: 'EnterDNASequence',
      desc: '',
      args: [],
    );
  }

  /// `Current Medications`
  String get CurrentMedications {
    return Intl.message(
      'Current Medications',
      name: 'CurrentMedications',
      desc: '',
      args: [],
    );
  }

  /// `Medical History`
  String get MedicalHistory {
    return Intl.message(
      'Medical History',
      name: 'MedicalHistory',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get Gender {
    return Intl.message('Gender', name: 'Gender', desc: '', args: []);
  }

  /// `Man`
  String get Man {
    return Intl.message('Man', name: 'Man', desc: '', args: []);
  }

  /// `Woman`
  String get Woman {
    return Intl.message('Woman', name: 'Woman', desc: '', args: []);
  }

  /// `Select Your Blood Type`
  String get SelectBloodType {
    return Intl.message(
      'Select Your Blood Type',
      name: 'SelectBloodType',
      desc: '',
      args: [],
    );
  }

  /// `Submit Analysis`
  String get SubmitAnalysis {
    return Intl.message(
      'Submit Analysis',
      name: 'SubmitAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get Summary {
    return Intl.message('Summary', name: 'Summary', desc: '', args: []);
  }

  /// `DNA Analysis Report`
  String get DNAAnalysisReport {
    return Intl.message(
      'DNA Analysis Report',
      name: 'DNAAnalysisReport',
      desc: '',
      args: [],
    );
  }

  /// `Comprehensive genetic analysis results`
  String get ComprehensiveGeneticResults {
    return Intl.message(
      'Comprehensive genetic analysis results',
      name: 'ComprehensiveGeneticResults',
      desc: '',
      args: [],
    );
  }

  /// `Analysis Name:`
  String get AnalysisName {
    return Intl.message(
      'Analysis Name:',
      name: 'AnalysisName',
      desc: '',
      args: [],
    );
  }

  /// `Sequence Length:`
  String get SequenceLength {
    return Intl.message(
      'Sequence Length:',
      name: 'SequenceLength',
      desc: '',
      args: [],
    );
  }

  /// `base pairs`
  String get BasePairs {
    return Intl.message('base pairs', name: 'BasePairs', desc: '', args: []);
  }

  /// `Reference Number:`
  String get ReferenceNumber {
    return Intl.message(
      'Reference Number:',
      name: 'ReferenceNumber',
      desc: '',
      args: [],
    );
  }

  /// `Technology Used:`
  String get TechnologyUsed {
    return Intl.message(
      'Technology Used:',
      name: 'TechnologyUsed',
      desc: '',
      args: [],
    );
  }

  /// `Created Date:`
  String get CreatedDate {
    return Intl.message(
      'Created Date:',
      name: 'CreatedDate',
      desc: '',
      args: [],
    );
  }

  /// `Lab Name:`
  String get LabName {
    return Intl.message('Lab Name:', name: 'LabName', desc: '', args: []);
  }

  /// `Analysis Types:`
  String get AnalysisTypes {
    return Intl.message(
      'Analysis Types:',
      name: 'AnalysisTypes',
      desc: '',
      args: [],
    );
  }

  /// `Key Findings:`
  String get KeyFindings {
    return Intl.message(
      'Key Findings:',
      name: 'KeyFindings',
      desc: '',
      args: [],
    );
  }

  /// `Health Overview`
  String get HealthOverview {
    return Intl.message(
      'Health Overview',
      name: 'HealthOverview',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred.`
  String get ErrorOccurred {
    return Intl.message(
      'An error occurred.',
      name: 'ErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Data not found.`
  String get DataNotFound {
    return Intl.message(
      'Data not found.',
      name: 'DataNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Click for more details`
  String get ClickForMoreDetails {
    return Intl.message(
      'Click for more details',
      name: 'ClickForMoreDetails',
      desc: '',
      args: [],
    );
  }

  /// `Create an Account`
  String get createAccount {
    return Intl.message(
      'Create an Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message('Next', name: 'next', desc: '', args: []);
  }

  /// `Do you confirm you've taken this medicine?`
  String get confirmMedicineTaken {
    return Intl.message(
      'Do you confirm you\'ve taken this medicine?',
      name: 'confirmMedicineTaken',
      desc: '',
      args: [],
    );
  }

  /// `hat is the medicine? What does it do? What are its side effects? explain in english`
  String get medicineAi {
    return Intl.message(
      'hat is the medicine? What does it do? What are its side effects? explain in english',
      name: 'medicineAi',
      desc: '',
      args: [],
    );
  }

  /// `What does it mean? What does it do? What are its benefits? What are its side effects? explain in english`
  String get measuresAi {
    return Intl.message(
      'What does it mean? What does it do? What are its benefits? What are its side effects? explain in english',
      name: 'measuresAi',
      desc: '',
      args: [],
    );
  }

  /// `Complete`
  String get complete {
    return Intl.message('Complete', name: 'complete', desc: '', args: []);
  }

  /// `Enter your basic information`
  String get enterBasicInfo {
    return Intl.message(
      'Enter your basic information',
      name: 'enterBasicInfo',
      desc: '',
      args: [],
    );
  }

  /// `Back`
  String get back {
    return Intl.message('Back', name: 'back', desc: '', args: []);
  }

  /// `Provide information about your health status`
  String get provideHealthInfo {
    return Intl.message(
      'Provide information about your health status',
      name: 'provideHealthInfo',
      desc: '',
      args: [],
    );
  }

  /// `Medication, food, environmental, etc.`
  String get medicationFoodEnvironmental {
    return Intl.message(
      'Medication, food, environmental, etc.',
      name: 'medicationFoodEnvironmental',
      desc: '',
      args: [],
    );
  }

  /// `Medications you use regularly`
  String get regularMedications {
    return Intl.message(
      'Medications you use regularly',
      name: 'regularMedications',
      desc: '',
      args: [],
    );
  }

  /// `Review Your Information`
  String get reviewYourInfo {
    return Intl.message(
      'Review Your Information',
      name: 'reviewYourInfo',
      desc: '',
      args: [],
    );
  }

  /// `You can review and complete the information you entered`
  String get checkAndComplete {
    return Intl.message(
      'You can review and complete the information you entered',
      name: 'checkAndComplete',
      desc: '',
      args: [],
    );
  }

  /// `Date of Birth`
  String get birthDate {
    return Intl.message('Date of Birth', name: 'birthDate', desc: '', args: []);
  }

  /// `Not Specified`
  String get notSpecified {
    return Intl.message(
      'Not Specified',
      name: 'notSpecified',
      desc: '',
      args: [],
    );
  }

  /// `I accept the privacy policy and terms of use.`
  String get acceptPrivacyPolicy {
    return Intl.message(
      'I accept the privacy policy and terms of use.',
      name: 'acceptPrivacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Read Terms`
  String get readTerms {
    return Intl.message('Read Terms', name: 'readTerms', desc: '', args: []);
  }

  /// `Medical Information`
  String get medicalInformation {
    return Intl.message(
      'Medical Information',
      name: 'medicalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Your Genetic Health Profile`
  String get yourGeneticHealthProfile {
    return Intl.message(
      'Your Genetic Health Profile',
      name: 'yourGeneticHealthProfile',
      desc: '',
      args: [],
    );
  }

  /// `Detailed Risks`
  String get detailedRisks {
    return Intl.message(
      'Detailed Risks',
      name: 'detailedRisks',
      desc: '',
      args: [],
    );
  }

  /// `GENETIC MARKERS`
  String get geneticMarkers {
    return Intl.message(
      'GENETIC MARKERS',
      name: 'geneticMarkers',
      desc: '',
      args: [],
    );
  }

  /// `RECOMMENDATIONS`
  String get recommendationsDetailed {
    return Intl.message(
      'RECOMMENDATIONS',
      name: 'recommendationsDetailed',
      desc: '',
      args: [],
    );
  }

  /// `Unlock your genetic potential`
  String get unlockGeneticPotential {
    return Intl.message(
      'Unlock your genetic potential',
      name: 'unlockGeneticPotential',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message('Email', name: 'email', desc: '', args: []);
  }

  /// `Please enter your email`
  String get enterEmail {
    return Intl.message(
      'Please enter your email',
      name: 'enterEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get validEmail {
    return Intl.message(
      'Please enter a valid email',
      name: 'validEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message('Password', name: 'password', desc: '', args: []);
  }

  /// `Password must be at least 6 characters`
  String get passwordMinLength {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'passwordMinLength',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPassword {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message('Login', name: 'login', desc: '', args: []);
  }

  /// `Don't have an account?`
  String get noAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'noAccount',
      desc: '',
      args: [],
    );
  }

  /// ` Sign Up`
  String get signUp {
    return Intl.message(' Sign Up', name: 'signUp', desc: '', args: []);
  }

  /// `or`
  String get or {
    return Intl.message('or', name: 'or', desc: '', args: []);
  }

  /// `I have an account`
  String get haveAccount {
    return Intl.message(
      'I have an account',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Do you have an account?`
  String get doYouHaveAccount {
    return Intl.message(
      'Do you have an account?',
      name: 'doYouHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `requirement:`
  String get requirement {
    return Intl.message(
      'requirement:',
      name: 'requirement',
      desc: '',
      args: [],
    );
  }

  /// `Language Selection`
  String get languageSelection {
    return Intl.message(
      'Language Selection',
      name: 'languageSelection',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Password updated successfully`
  String get passwordUpdatedSuccessfully {
    return Intl.message(
      'Password updated successfully',
      name: 'passwordUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get currentPassword {
    return Intl.message(
      'Current Password',
      name: 'currentPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password (Repeat)`
  String get newPasswordRepeat {
    return Intl.message(
      'New Password (Repeat)',
      name: 'newPasswordRepeat',
      desc: '',
      args: [],
    );
  }

  /// `Change`
  String get change {
    return Intl.message('Change', name: 'change', desc: '', args: []);
  }

  /// `App Icon Change`
  String get appIconChange {
    return Intl.message(
      'App Icon Change',
      name: 'appIconChange',
      desc: '',
      args: [],
    );
  }

  /// `Please accept the terms.`
  String get pleaseAcceptTerms {
    return Intl.message(
      'Please accept the terms.',
      name: 'pleaseAcceptTerms',
      desc: '',
      args: [],
    );
  }

  /// `No user session.`
  String get noUserSession {
    return Intl.message(
      'No user session.',
      name: 'noUserSession',
      desc: '',
      args: [],
    );
  }

  /// `Your information has been saved successfully.`
  String get infoSavedSuccessfully {
    return Intl.message(
      'Your information has been saved successfully.',
      name: 'infoSavedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred:`
  String get anErrorOccurred {
    return Intl.message(
      'An error occurred:',
      name: 'anErrorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message('Male', name: 'male', desc: '', args: []);
  }

  /// `Female`
  String get female {
    return Intl.message('Female', name: 'female', desc: '', args: []);
  }

  /// `Other`
  String get otherGender {
    return Intl.message('Other', name: 'otherGender', desc: '', args: []);
  }

  /// `Prefer not to say`
  String get preferNotToSay {
    return Intl.message(
      'Prefer not to say',
      name: 'preferNotToSay',
      desc: '',
      args: [],
    );
  }

  /// `Caucasian`
  String get caucasian {
    return Intl.message('Caucasian', name: 'caucasian', desc: '', args: []);
  }

  /// `African`
  String get african {
    return Intl.message('African', name: 'african', desc: '', args: []);
  }

  /// `Asian`
  String get asian {
    return Intl.message('Asian', name: 'asian', desc: '', args: []);
  }

  /// `Hispanic`
  String get hispanic {
    return Intl.message('Hispanic', name: 'hispanic', desc: '', args: []);
  }

  /// `Other`
  String get otherEthnicity {
    return Intl.message('Other', name: 'otherEthnicity', desc: '', args: []);
  }

  /// `Logout`
  String get logout {
    return Intl.message('Logout', name: 'logout', desc: '', args: []);
  }

  /// `My Personal Information`
  String get myPersonalInfo {
    return Intl.message(
      'My Personal Information',
      name: 'myPersonalInfo',
      desc: '',
      args: [],
    );
  }

  /// `Profile not found`
  String get profileNotFound {
    return Intl.message(
      'Profile not found',
      name: 'profileNotFound',
      desc: '',
      args: [],
    );
  }

  /// `My Information`
  String get myInformation {
    return Intl.message(
      'My Information',
      name: 'myInformation',
      desc: '',
      args: [],
    );
  }

  /// `Please list any significant illnesses you have had and any chronic conditions you may have.`
  String get medicalQuestionsPersonalDiseases {
    return Intl.message(
      'Please list any significant illnesses you have had and any chronic conditions you may have.',
      name: 'medicalQuestionsPersonalDiseases',
      desc: '',
      args: [],
    );
  }

  /// `Please indicate any genetic or serious illnesses observed in family members.`
  String get medicalQuestionsFamilyDiseases {
    return Intl.message(
      'Please indicate any genetic or serious illnesses observed in family members.',
      name: 'medicalQuestionsFamilyDiseases',
      desc: '',
      args: [],
    );
  }

  /// `Please list any medications you are currently taking regularly.`
  String get medicalQuestionsCurrentMedications {
    return Intl.message(
      'Please list any medications you are currently taking regularly.',
      name: 'medicalQuestionsCurrentMedications',
      desc: '',
      args: [],
    );
  }

  /// `Please indicate if you have any allergies to medications, foods, environmental factors (pollen, dust, etc.) or anything else.`
  String get medicalQuestionsAllergies {
    return Intl.message(
      'Please indicate if you have any allergies to medications, foods, environmental factors (pollen, dust, etc.) or anything else.',
      name: 'medicalQuestionsAllergies',
      desc: '',
      args: [],
    );
  }

  /// `Hello, I'm AI!`
  String get greetingsWelcome {
    return Intl.message(
      'Hello, I\'m AI!',
      name: 'greetingsWelcome',
      desc: '',
      args: [],
    );
  }

  /// `You can ask me your questions.`
  String get greetingsPrompt {
    return Intl.message(
      'You can ask me your questions.',
      name: 'greetingsPrompt',
      desc: '',
      args: [],
    );
  }

  /// `Your Genetic Traits`
  String get yourGeneticTraits {
    return Intl.message(
      'Your Genetic Traits',
      name: 'yourGeneticTraits',
      desc: '',
      args: [],
    );
  }

  /// `Based on your DNA analysis results`
  String get dnaAnalysisResults {
    return Intl.message(
      'Based on your DNA analysis results',
      name: 'dnaAnalysisResults',
      desc: '',
      args: [],
    );
  }

  /// `Detailed Analysis`
  String get detailedAnalysis {
    return Intl.message(
      'Detailed Analysis',
      name: 'detailedAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message('Description', name: 'description', desc: '', args: []);
  }

  /// `Prevalence`
  String get prevalence {
    return Intl.message('Prevalence', name: 'prevalence', desc: '', args: []);
  }

  /// `Implications`
  String get implications {
    return Intl.message(
      'Implications',
      name: 'implications',
      desc: '',
      args: [],
    );
  }

  /// `Global Distribution`
  String get globalDistribution {
    return Intl.message(
      'Global Distribution',
      name: 'globalDistribution',
      desc: '',
      args: [],
    );
  }

  /// `Taste Sensitivity Spectrum`
  String get tasteSensitivitySpectrum {
    return Intl.message(
      'Taste Sensitivity Spectrum',
      name: 'tasteSensitivitySpectrum',
      desc: '',
      args: [],
    );
  }

  /// `Please share your DNA sequence.`
  String get dnaSequenceInquiry {
    return Intl.message(
      'Please share your DNA sequence.',
      name: 'dnaSequenceInquiry',
      desc: '',
      args: [],
    );
  }

  /// `The analysis process may take some time. Please wait...`
  String get analysisMayTakeTime {
    return Intl.message(
      'The analysis process may take some time. Please wait...',
      name: 'analysisMayTakeTime',
      desc: '',
      args: [],
    );
  }

  /// `Your DNA data is being analyzed...`
  String get dnaDataAnalyzing {
    return Intl.message(
      'Your DNA data is being analyzed...',
      name: 'dnaDataAnalyzing',
      desc: '',
      args: [],
    );
  }

  /// `Genetic Traits Analysis`
  String get geneticTraitsAnalysis {
    return Intl.message(
      'Genetic Traits Analysis',
      name: 'geneticTraitsAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Nutrition DNA Analysis`
  String get nutritionDnaAnalysis {
    return Intl.message(
      'Nutrition DNA Analysis',
      name: 'nutritionDnaAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Health DNA Analysis`
  String get healthDnaAnalysis {
    return Intl.message(
      'Health DNA Analysis',
      name: 'healthDnaAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `Fitness DNA Analysis`
  String get fitnessDnaAnalysis {
    return Intl.message(
      'Fitness DNA Analysis',
      name: 'fitnessDnaAnalysis',
      desc: '',
      args: [],
    );
  }

  /// `DNA Analyse`
  String get dnaAnalysis {
    return Intl.message('DNA Analyse', name: 'dnaAnalysis', desc: '', args: []);
  }

  /// `Analysis completed!`
  String get analysisCompleted {
    return Intl.message(
      'Analysis completed!',
      name: 'analysisCompleted',
      desc: '',
      args: [],
    );
  }

  /// `preparing all reports...`
  String get preparingAllReports {
    return Intl.message(
      'preparing all reports...',
      name: 'preparingAllReports',
      desc: '',
      args: [],
    );
  }

  /// `calculating results...`
  String get calculatingResults {
    return Intl.message(
      'calculating results...',
      name: 'calculatingResults',
      desc: '',
      args: [],
    );
  }

  /// `ccanning polymorphisms...`
  String get scanningPolymorphisms {
    return Intl.message(
      'ccanning polymorphisms...',
      name: 'scanningPolymorphisms',
      desc: '',
      args: [],
    );
  }

  /// `analyzing genetic markers...`
  String get analyzingGeneticMarkers {
    return Intl.message(
      'analyzing genetic markers...',
      name: 'analyzingGeneticMarkers',
      desc: '',
      args: [],
    );
  }

  /// `retrieving DNA data for...`
  String get fetchingDnaData {
    return Intl.message(
      'retrieving DNA data for...',
      name: 'fetchingDnaData',
      desc: '',
      args: [],
    );
  }

  /// `Finalizing your genetic report...`
  String get finalizingReport {
    return Intl.message(
      'Finalizing your genetic report...',
      name: 'finalizingReport',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
