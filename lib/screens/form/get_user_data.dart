import 'package:another_flushbar/flushbar.dart';
import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/screens/analysing/analysing.dart';
import 'package:dna_analyse/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  final _pageController = PageController();
  final String backgroundImage = "assets/images/dnalogo.png";
  final authService = AuthService();
  int _currentPage = 0;
  String? _gender;
  String? _ethnicity;
  String? _bloodType;
  String _medicalHistory = '';
  String _familyHistory = '';
  String _allergies = '';
  String _currentMedications = '';
  String _dnaSequence = '';
  List<String> selectedAnalysisTypes = [];

  String? _name;
  String? _surname;

  double _height = 170;
  double _weight = 70;
  bool _acceptTerms = false;
  DateTime? _birthDate;

  List<String> analysisTypes(BuildContext context) {
    return [
      "Genetic",
      S.of(context).health,
      S.of(context).nutrition,
      S.of(context).fitness,
    ];
  }

  List<String> typeSubtitle(BuildContext context) {
    return [
      S.of(context).geneticPredispositions,
      S.of(context).healthAnalysis,
      S.of(context).personalizedDiet,
      S.of(context).exerciseRecommendations,
    ];
  }

  List<String> _genders() {
    return [S.of(context).male, S.of(context).female];
  }

  List<String> _ethnicities() {
    return [
      S.of(context).caucasian,
      S.of(context).african,
      S.of(context).asian,
      S.of(context).hispanic,
      S.of(context).otherEthnicity,
    ];
  }

  final List<String> _bloodTypes = [
    'A Rh+',
    'A Rh-',
    'B Rh+',
    'B Rh-',
    'AB Rh+',
    'AB Rh-',
    '0 Rh+',
    '0 Rh-',
  ];

  void _nextPage() {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      _submitForm();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _submitForm() async {
    if (!_acceptTerms) {
      Flushbar(
        message: S.of(context).pleaseAcceptTerms,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.redAccent,
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(5),
      ).show(context);
      return;
    }

    try {
      print('Form kaydediliyor...');
      final user = Supabase.instance.client.auth.currentUser;

      if (user == null) {
        throw Exception(S.of(context).noUserSession);
      }

      final response =
          await Supabase.instance.client.from("profil").insert({
            'id': user.id,
            'name': _name,
            'surname': _surname,
            'gender': _gender,
            'ethnicity': _ethnicity,
            'bloodtype': _bloodType,
            'birthdate': _birthDate?.toIso8601String(),
            'height': _height,
            'weight': _weight,
            'medicalhistory': _medicalHistory,
            'familyhistory': _familyHistory,
            'allergies': _allergies,
            'currentmedications': _currentMedications,
          }).select();

      print('Form başarıyla kaydedildi: $response');

      if (context.mounted) {
        Flushbar(
          message: S.of(context).infoSavedSuccessfully,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(5),
        ).show(context);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder:
                (context) => Analysing(analysisTypes: selectedAnalysisTypes),
          ),
          (route) => false,
        );
      }
    } on AuthException catch (e) {
      if (context.mounted) {
        Flushbar(
          message: e.message,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.redAccent.shade200,
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(5),
        ).show(context);
      }
    } catch (e) {
      if (context.mounted) {
        Flushbar(
          message: "${S.of(context).anErrorOccurred} ${e.toString()}",
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(5),
        ).show(context);
      }
      print("Beklenmeyen hata: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color cardColor =
        isDarkMode
            ? const Color.fromARGB(255, 10, 10, 15)
            : Colors.blue.shade700;
    final Color shadowColor =
        isDarkMode
            ? Colors.black.withValues(alpha: 0.3)
            : Colors.black.withValues(alpha: 0.05);

    //final Color textFieldColor = isDarkMode ? const Color.fromARGB(255, 10, 10, 15) : Colors.white;

    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.05,
                child: Image.asset(
                  backgroundImage,
                  fit: BoxFit.cover,
                  color: isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Row(
                      children: List.generate(4, (index) {
                        return Expanded(
                          child: Container(
                            height: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color:
                                  isDarkMode
                                      ? (_currentPage >= index
                                          ? Colors.white
                                          : Colors.grey.withValues(alpha: 0.4))
                                      : (_currentPage >= index
                                          ? Colors.black
                                          : Colors.grey.withValues(alpha: 0.5)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      onPageChanged:
                          (page) => setState(() => _currentPage = page),
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        _buildPersonalInfoPage(
                          isDarkMode,
                          cardColor,
                          shadowColor,
                        ),
                        _buildMedicalInfoPage(
                          isDarkMode,
                          cardColor,
                          shadowColor,
                        ),
                        _makeDnaAnalyse(
                          isDarkMode,
                          cardColor,
                          shadowColor,
                          selectedAnalysisTypes,
                        ),

                        _buildReviewPage(isDarkMode, cardColor, shadowColor),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        if (_currentPage > 0)
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 18,
                                ),
                                side: BorderSide(
                                  color:
                                      isDarkMode
                                          ? Colors.grey.shade700
                                          : Colors.black,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: _previousPage,
                              child: Text(
                                S.of(context).back,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        if (_currentPage > 0) const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  isDarkMode
                                      ? Colors.white
                                      : Colors
                                          .grey
                                          .shade900, // Neredeyse siyah (En koyu gri)
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: _nextPage,
                            child: Text(
                              _currentPage == 3
                                  ? S.of(context).complete
                                  : S.of(context).next,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.black : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoPage(
    bool isDarkMode,
    Color cardColor,
    Color shadowColor,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            S.of(context).letUsKnowYou,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).enterBasicInfo,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        isDarkMode
                            ? const Color.fromARGB(255, 10, 10, 15)
                            : Colors.white,
                    labelText: S.of(context).firstName,
                    labelStyle: TextStyle(
                      color:
                          isDarkMode
                              ? Colors.grey.shade400
                              : Colors.grey.shade800,
                    ),
                    // hintStyle: TextStyle(
                    //   color:
                    //       isDarkMode
                    //           ? Colors.grey.shade500
                    //           : Colors.grey.shade600,
                    // ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.grey.shade800 : Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.grey.shade800 : Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.grey.shade400 : Colors.black,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.red.shade400),
                    ),
                  ),
                  onChanged: (value) => setState(() => _name = value),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        isDarkMode
                            ? const Color.fromARGB(255, 10, 10, 15)
                            : Colors.white,
                    labelText: S.of(context).lastName,
                    labelStyle: TextStyle(
                      color:
                          isDarkMode
                              ? Colors.grey.shade400
                              : Colors.grey.shade800,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.grey.shade800 : Colors.black,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.grey.shade800 : Colors.black,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: isDarkMode ? Colors.grey.shade400 : Colors.black,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.red.shade400),
                    ),
                  ),
                  onChanged: (value) => setState(() => _surname = value),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // Gender Selection
          _buildModernDropdown(
            isDarkMode: isDarkMode,
            cardColor: cardColor,
            shadowColor: shadowColor,
            icon: Iconsax.profile_2user,
            label: S.of(context).gender,
            value: _gender,
            items: _genders(),
            onChanged: (value) => setState(() => _gender = value),
          ),
          const SizedBox(height: 20),

          // Ethnicity
          _buildModernDropdown(
            isDarkMode: isDarkMode,
            cardColor: cardColor,
            shadowColor: shadowColor,
            icon: Iconsax.global,
            label: S.of(context).ethnicity,
            value: _ethnicity,
            items: _ethnicities(),
            onChanged: (value) => setState(() => _ethnicity = value),
          ),
          const SizedBox(height: 20),

          // Blood Type
          _buildModernDropdown(
            isDarkMode: isDarkMode,
            cardColor: cardColor,
            shadowColor: shadowColor,
            icon: Icons.bloodtype_rounded,
            label: S.of(context).bloodType,
            value: _bloodType,
            items: _bloodTypes,
            onChanged: (value) => setState(() => _bloodType = value),
          ),
          const SizedBox(height: 20),

          _buildDatePickerField(isDarkMode, cardColor, shadowColor),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  isDarkMode: isDarkMode,
                  cardColor: cardColor,
                  shadowColor: shadowColor,
                  icon: Iconsax.ruler,
                  label: S.of(context).height,
                  value: _height.round(),
                  onChanged:
                      (value) => setState(() => _height = value.toDouble()),
                  min: 100,
                  max: 220,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMetricCard(
                  isDarkMode: isDarkMode,
                  cardColor: cardColor,
                  shadowColor: shadowColor,
                  icon: Iconsax.weight,
                  label: S.of(context).weight,
                  value: _weight.round(),
                  onChanged:
                      (value) => setState(() => _weight = value.toDouble()),
                  min: 30,
                  max: 150,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildMedicalInfoPage(
    bool isDarkMode,
    Color cardColor,
    Color shadowColor,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            S.of(context).medicalInformation,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          Text(
            S.of(context).provideHealthInfo,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 15),

          // Medical History
          _buildModernTextField(
            isDarkMode: isDarkMode,
            cardColor: cardColor,
            shadowColor: shadowColor,
            icon: Iconsax.health,
            label: S.of(context).MedicalHistory,
            value: _medicalHistory,
            onChanged: (value) => _medicalHistory = value,
            maxLines: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 3.0),
            child: Text(
              S.of(context).medicalQuestionsPersonalDiseases,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade900,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Family History
          _buildModernTextField(
            isDarkMode: isDarkMode,
            cardColor: cardColor,
            shadowColor: shadowColor,
            icon: Iconsax.activity,
            label: S.of(context).familyHistory,
            value: _familyHistory,
            onChanged: (value) => _familyHistory = value,
            maxLines: 3,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 3.0),
            child: Text(
              S.of(context).medicalQuestionsFamilyDiseases,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade900,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Allergies
          _buildModernTextField(
            isDarkMode: isDarkMode,
            cardColor: cardColor,
            shadowColor: shadowColor,
            icon: Iconsax.warning_2,
            label: S.of(context).allergies,
            value: _allergies,
            onChanged: (value) => _allergies = value,
            hintText: S.of(context).medicationFoodEnvironmental,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 3.0),
            child: Text(
              S.of(context).medicalQuestionsAllergies,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade900,
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Medications
          _buildModernTextField(
            isDarkMode: isDarkMode,
            cardColor: cardColor,
            shadowColor: shadowColor,
            icon: Icons.medication,
            label: S.of(context).currentMedications,
            value: _currentMedications,
            onChanged: (value) => _currentMedications = value,
            hintText: S.of(context).regularMedications,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5.0, top: 3.0),
            child: Text(
              S.of(context).medicalQuestionsCurrentMedications,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isDarkMode ? Colors.grey.shade300 : Colors.grey.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewPage(bool isDarkMode, Color cardColor, Color shadowColor) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            S.of(context).reviewYourInfo,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            S.of(context).checkAndComplete,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 10),

          // Basic Information Card
          Card(
            color: isDarkMode ? Colors.grey.shade900 : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Basic Information', // veya S.of(context).basicInformation
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildReviewItem(
                    S.of(context).firstName,
                    _name ?? S.of(context).notSpecified,
                    isDarkMode,
                  ),
                  _buildReviewItem(
                    S.of(context).lastName,
                    _surname ?? S.of(context).notSpecified,
                    isDarkMode,
                  ),
                  _buildReviewItem(
                    S.of(context).gender,
                    _gender ?? S.of(context).notSpecified,
                    isDarkMode,
                  ),
                  _buildReviewItem(
                    S.of(context).ethnicity,
                    _ethnicity ?? S.of(context).notSpecified,
                    isDarkMode,
                  ),
                  _buildReviewItem(
                    S.of(context).bloodType,
                    _bloodType ?? S.of(context).notSpecified,
                    isDarkMode,
                  ),
                  _buildReviewItem(
                    S.of(context).birthDate,
                    _birthDate != null
                        ? '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'
                        : S.of(context).notSpecified,
                    isDarkMode,
                  ),
                  _buildReviewItem(
                    S.of(context).height,
                    '${_height.round()} cm',
                    isDarkMode,
                  ),
                  _buildReviewItem(
                    S.of(context).weight,
                    '${_weight.round()} kg',
                    isDarkMode,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),

          // Medical Information Card
          Card(
            color: isDarkMode ? Colors.grey.shade900 : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).medicalInformation,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildReviewItem(
                    S.of(context).medicalHistory,
                    _medicalHistory.isNotEmpty
                        ? _medicalHistory
                        : S.of(context).notSpecified,
                    isDarkMode,
                  ),
                  _buildReviewItem(
                    S.of(context).familyHistory,
                    _familyHistory.isNotEmpty
                        ? _familyHistory
                        : S.of(context).notSpecified,
                    isDarkMode,
                  ),
                  _buildReviewItem(
                    S.of(context).allergies,
                    _allergies.isNotEmpty
                        ? _allergies
                        : S.of(context).notSpecified,
                    isDarkMode,
                  ),
                  _buildReviewItem(
                    S.of(context).currentMedications,
                    _currentMedications.isNotEmpty
                        ? _currentMedications
                        : S.of(context).notSpecified,
                    isDarkMode,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),

          // DNA Analysis Card
          Card(
            color: isDarkMode ? Colors.grey.shade900 : Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'DNA Analysis Types', // veya S.of(context).dnaAnalysis
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildReviewItem(
                    "${S.of(context).EnterDNASequence}:",
                    _dnaSequence.isNotEmpty
                        ? '${_dnaSequence.substring(0, _dnaSequence.length > 50 ? 50 : _dnaSequence.length)}${_dnaSequence.length > 50 ? '...' : ''}'
                        : S.of(context).notSpecified,
                    isDarkMode,
                  ),
                  _buildReviewItem(
                    S.of(context).AnalysisTypes,
                    selectedAnalysisTypes.isNotEmpty
                        ? selectedAnalysisTypes.join(', ')
                        : S.of(context).notSpecified,
                    isDarkMode,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 5),

          // Terms and Conditions Card
          Card(
            color: isDarkMode ? Colors.grey.shade900 : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                    offset: const Offset(0, -4),
                    child: Checkbox(
                      value: _acceptTerms,
                      activeColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      onChanged:
                          (value) =>
                              setState(() => _acceptTerms = value ?? false),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: S.of(context).acceptPrivacyPolicy,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black87,
                            ),
                          ),
                          TextSpan(
                            text: S.of(context).readTerms,
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildModernDropdown({
    required bool isDarkMode,
    required Color cardColor,
    required Color shadowColor,
    required IconData icon,
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          filled: true,
          fillColor:
              isDarkMode ? const Color.fromARGB(255, 10, 10, 15) : Colors.white,
          labelText: label,

          labelStyle: TextStyle(
            color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade800,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.grey.shade800 : Colors.black,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.grey.shade800 : Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: isDarkMode ? Colors.grey.shade400 : Colors.black,
              width: 2,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.red.shade400),
          ),
          prefixIcon: Icon(
            icon,
            color: isDarkMode ? Colors.grey.shade600 : Colors.black,
          ),
        ),
        items:
            items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black87,
                  ),
                ),
              );
            }).toList(),
        onChanged: onChanged,
        borderRadius: BorderRadius.circular(12),
        isExpanded: true,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: isDarkMode ? Colors.white : Colors.black87,
        ),
        dropdownColor: isDarkMode ? const Color(0xFF2D2D3D) : Colors.white,
        icon: Icon(
          Iconsax.arrow_down_1,
          color: isDarkMode ? Colors.grey.shade600 : Colors.black,
        ),
      ),
    );
  }

  Widget _buildDatePickerField(
    bool isDarkMode,
    Color cardColor,
    Color shadowColor,
  ) {
    return GestureDetector(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate:
              _birthDate ??
              DateTime.now().subtract(const Duration(days: 365 * 25)),
          firstDate: DateTime(1900),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          setState(() => _birthDate = date);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color:
              isDarkMode ? const Color.fromARGB(255, 10, 10, 15) : Colors.white,
          border: Border.all(
            color: isDarkMode ? Colors.grey.shade800 : Colors.black,
            width: 1.0, // Match the default border width
          ),
          borderRadius: BorderRadius.circular(
            12,
          ), // Changed to match TextFormField (12 instead of 16)
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Iconsax.calendar,
              color: isDarkMode ? Colors.grey.shade600 : Colors.black,
            ),
            const SizedBox(width: 12),
            Text(
              _birthDate != null
                  ? '${_birthDate!.day}/${_birthDate!.month}/${_birthDate!.year}'
                  : S.of(context).birthDate,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color:
                    _birthDate != null
                        ? (isDarkMode ? Colors.white : Colors.black87)
                        : isDarkMode
                        ? Colors.grey.shade500
                        : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required bool isDarkMode,
    required Color cardColor,
    required Color shadowColor,
    required IconData icon,
    required String label,
    required int value,
    required Function(int) onChanged,
    required int min,
    required int max,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDarkMode ? Colors.grey : Colors.white),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: isDarkMode ? Colors.grey.shade600 : Colors.white,
                size: 22,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Colors.white),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value.toString(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isDarkMode ? Colors.white : Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              // IconButton(
              //   icon: const Icon(Iconsax.minus),
              //   onPressed: value > min ? () => onChanged(value - 1) : null,
              //   style: IconButton.styleFrom(
              //     backgroundColor:
              //         isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              // ),
              // const SizedBox(width: 8),
              Expanded(
                child: Slider(
                  value: value.toDouble(),
                  min: min.toDouble(),
                  max: max.toDouble(),
                  divisions: max - min,
                  onChanged: (val) => onChanged(val.toInt()),
                  activeColor: Colors.white,
                  inactiveColor:
                      isDarkMode
                          ? Colors.grey.withOpacity(isDarkMode ? 0.4 : 0.2)
                          : Colors.grey,
                ),
              ),
              // const SizedBox(width: 8),
              // IconButton(
              //   icon: const Icon(Iconsax.add),
              //   onPressed: value < max ? () => onChanged(value + 1) : null,
              //   style: IconButton.styleFrom(
              //     backgroundColor:
              //         isDarkMode ? Colors.grey.shade800 : Colors.grey.shade100,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _makeDnaAnalyse(
    bool isDarkMode,
    Color cardColor,
    Color shadowColor,
    selectedAnalysisTypes,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).selectAnalysisTypes,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              S.of(context).analysisTypeSelection,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
              ),
            ),
            SizedBox(height: 10),
            _buildModernTextField(
              value: _dnaSequence,
              shadowColor: shadowColor,
              hintText: S.of(context).regularMedications,
              onChanged: (value) => _dnaSequence = value,
              cardColor: cardColor,
              isDarkMode: isDarkMode,
              icon: FontAwesomeIcons.dna,
              label: S.of(context).EnterDNASequence,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 5.0, top: 3.0),
              child: Text(
                S.of(context).dnaSequenceInquiry,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color:
                      isDarkMode ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
            ),
            SizedBox(height: 10),

            Card(
              color: isDarkMode ? Colors.grey.shade900 : Colors.white,

              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: List.generate(analysisTypes(context).length, (
                    index,
                  ) {
                    String type = analysisTypes(context)[index];
                    String subtitle = typeSubtitle(context)[index];

                    return CheckboxListTile(
                      activeColor: Colors.green,

                      title: Text(
                        type,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      subtitle: Text(subtitle),
                      value: selectedAnalysisTypes.contains(type),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value == true) {
                            selectedAnalysisTypes.add(type);
                          } else {
                            selectedAnalysisTypes.remove(type);
                          }
                        });
                      },
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildModernTextField({
    required bool isDarkMode,
    required Color cardColor,
    required Color shadowColor,
    IconData? icon,
    required String label,
    required String value,
    required Function(String) onChanged,
    String? hintText,
    int maxLines = 1,
  }) {
    return TextFormField(
      style: TextStyle(color: isDarkMode ? Colors.white : Colors.black87),
      decoration: InputDecoration(
        filled: true,
        fillColor:
            isDarkMode ? const Color.fromARGB(255, 10, 10, 15) : Colors.white,
        labelText: label,
        labelStyle: TextStyle(
          color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade800,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDarkMode ? Colors.grey.shade500 : Colors.grey.shade600,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey.shade800 : Colors.black,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey.shade800 : Colors.black,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDarkMode ? Colors.grey.shade400 : Colors.black,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.red.shade400),
        ),
        prefixIcon: Icon(
          icon,
          color: isDarkMode ? Colors.grey.shade600 : Colors.black,
        ),
      ),
      onChanged: onChanged,
    );
  }

  Widget _buildReviewItem(String title, String value, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontSize: 15,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: isDarkMode ? Colors.grey.shade400 : Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
