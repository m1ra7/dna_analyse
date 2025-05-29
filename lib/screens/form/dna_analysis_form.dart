import 'package:dna_analyse/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DnaAnalysisForm extends StatefulWidget {
  const DnaAnalysisForm({super.key});

  @override
  State<DnaAnalysisForm> createState() => _DnaAnalysisFormsState();
}

class _DnaAnalysisFormsState extends State<DnaAnalysisForm> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _dnaSequenceController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _medicalHistoryController =
      TextEditingController();
  final TextEditingController _familyHistoryController =
      TextEditingController();
  final TextEditingController _allergiesController = TextEditingController();

  final TextEditingController _currentMedications = TextEditingController();

  String? _selectedGender;
  String? _selectedBloodType;
  final bool _includeClinicalTrials = false;
  final bool _includeGeneReferences = true;
  final bool _includeScientificReferences = false;
  final bool _includeRiskFactors = true;
  final bool _includeMedicationRecommendations = true;
  final bool _includePreventiveMeasures = true;

  List<String> analysisTypes(BuildContext context) {
    return [
      S.of(context).health,
      S.of(context).nutrition,
      S.of(context).fitness,
    ];
  }

  List<String> typeSubtitle(BuildContext context) {
    return [
      S.of(context).geneticPredispositions,
      S.of(context).personalizedDiet,
      S.of(context).exerciseRecommendations,
    ];
  }

  List<String> selectedAnalysisTypes = [];

  void _submitData() {
    Map<String, dynamic> requestData = {
      "dnaSequence": _dnaSequenceController.text,
      "analysisTypes": selectedAnalysisTypes,
      'medicalHistory': _medicalHistoryController.text,
      'familyHistory': _familyHistoryController.text,
      'allergies': _allergiesController.text,
      'currentMedications': _currentMedications,
      "patientInfo": {
        "age": _ageController.text,
        "gender": _selectedGender,
        "weight": _weightController.text,
        "height": _heightController.text,
        "bloodType": _selectedBloodType,
      },
      "analysisParameters": {
        "includeMedicationRecommendations": _includeMedicationRecommendations,
        "includeClinicalTrials": _includeClinicalTrials,
        "includeRiskFactors": _includeRiskFactors,
        "includeGeneReferences": _includeGeneReferences,
        "includeScientificReferences": _includeScientificReferences,
        "includePreventiveMeasures": _includePreventiveMeasures,
      },
    };
    print(requestData);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _ageController.dispose();
    _dnaSequenceController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    _medicalHistoryController.dispose();
    _familyHistoryController.dispose();
    _allergiesController.dispose();
    _currentMedications.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          S.of(context).DNAAnalysisForm,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Scrollbar(
        controller: _scrollController,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuildTextField(
                    heightController: _dnaSequenceController,
                    type: TextInputType.number,
                    label: S.of(context).EnterDNASequence,
                    icon: FontAwesomeIcons.dna,
                  ),

                  BuildTextField(
                    heightController: _currentMedications,
                    icon: Icons.medication,
                    type: TextInputType.text,
                    label: S.of(context).CurrentMedications,
                  ),
                  BuildTextField(
                    heightController: _medicalHistoryController,
                    icon: Icons.abc,
                    type: TextInputType.text,
                    label: S.of(context).MedicalHistory,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButton<String>(
                        borderRadius: BorderRadius.circular(10),
                        padding: EdgeInsets.all(8),
                        value: _selectedGender,
                        hint: Text(S.of(context).Gender),
                        items:
                            [S.of(context).Man, S.of(context).Woman].map((
                              String value,
                            ) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedGender = newValue;
                          });
                        },
                      ),
                      DropdownButton<String>(
                        value: _selectedBloodType,
                        hint: Text(S.of(context).SelectBloodType),
                        items:
                            [
                              "A Rh(+)",
                              "A Rh(-)",
                              "B Rh(+)",
                              "B Rh(-)",
                              "AB Rh(+)",
                              "AB Rh(-)",
                              "0 Rh(+)",
                              "0 Rh(-)",
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedBloodType = newValue;
                          });
                        },
                      ),
                    ],
                  ),

                  //Divider(),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            S.of(context).selectAnalysisTypes,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                S.of(context).analysisTypeSelection,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              children: List.generate(
                                analysisTypes(context).length,
                                (index) {
                                  String type = analysisTypes(context)[index];
                                  String subtitle =
                                      typeSubtitle(context)[index];

                                  return CheckboxListTile(
                                    title: Text(
                                      type,
                                      style:
                                          Theme.of(
                                            context,
                                          ).textTheme.headlineSmall,
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
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  _subAnalyseButton(isDark, context),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Align _subAnalyseButton(bool isDark, BuildContext context) {
    return Align(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _submitData();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  Colors.grey[800], //Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              S.of(context).SubmitAnalysis,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  /*
  BuildTextField height() {
    return BuildTextField(
        heightController: _heightController,
        icon: Icons.straighten,
        type: TextInputType.number,
        label: "Boy(cm)");
  }

  BuildTextField weight() {
    return BuildTextField(
      heightController: _weightController,
      type: TextInputType.number,
      icon: Icons.monitor_weight,
      label: "Agirlik (KG)",
    );
  }

  BuildTextField age() {
    return BuildTextField(
      heightController: _ageController,
      icon: Icons.person,
      label: "Yaş",
      type: TextInputType.number,
    );
  }

  Row nameSurname(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.41,
            height: MediaQuery.sizeOf(context).height * 0.05,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 29, 27, 32),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: TextField(
              controller: _heightController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                //labelText: label,
                border: OutlineInputBorder(
                    gapPadding: 1,
                    borderSide: BorderSide(color: Colors.white, width: 10),
                    borderRadius: BorderRadius.all(Radius.circular(
                        10))), //InputBorder.none, //InputBorder.none,

                // contentPadding: EdgeInsets.only(
                //   top: MediaQuery.sizeOf(context).height * 0.012,
                // ),
                hintText: "Isim",
                // prefixIcon: Padding(
                //   padding: EdgeInsets.only(
                //     top: MediaQuery.sizeOf(context).height * 0.002,
                //   ),
                //   // child: Icon(icon, color: Colors.blue),
                // ),
                //suffixIcon:
              ),

              //errorStyle: const TextStyle(height: 0),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: MediaQuery.sizeOf(context).width * 0.435,
            height: MediaQuery.sizeOf(context).height * 0.05,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 29, 27, 32),
              borderRadius: const BorderRadius.all(Radius.circular(15)),
            ),
            child: TextField(
              controller: _heightController,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                //labelText: label,
                border: OutlineInputBorder(
                    gapPadding: 1,
                    borderSide: BorderSide(color: Colors.white, width: 10),
                    borderRadius: BorderRadius.all(Radius.circular(
                        10))), //InputBorder.none, //InputBorder.none,

                // contentPadding: EdgeInsets.only(
                //   top: MediaQuery.sizeOf(context).height * 0.012,
                // ),
                hintText: "Soyisim",
                // prefixIcon: Padding(
                //   padding: EdgeInsets.only(
                //     top: MediaQuery.sizeOf(context).height * 0.002,
                //   ),
                //   // child: Icon(icon, color: Colors.blue),
                // ),
                //suffixIcon:
              ),

              //errorStyle: const TextStyle(height: 0),
            ),
          ),
        ),
      ],
    );
  }*/
}

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    required TextEditingController heightController,
    required this.label,
    required this.type,
    required this.icon,
  }) : _heightController = heightController;

  final TextEditingController _heightController;
  final String label;
  final TextInputType type;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: _heightController,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        keyboardType: type,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Lütfen e-posta adresinizi girin';
          }
          if (!value.contains('@')) {
            return 'Geçerli bir e-posta adresi girin';
          }
          return null;
        },
      ),
    ); /*Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.9,
        height: MediaQuery.sizeOf(context).height * 0.05,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 29, 27, 32),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: TextFormField(
          controller: _heightController,
          keyboardType: type,
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(
                gapPadding: 1,
                borderSide: BorderSide(color: Colors.white, width: 10),
                borderRadius: BorderRadius.all(Radius.circular(
                    10))), //InputBorder.none, //InputBorder.none,

            // contentPadding: EdgeInsets.only(
            //   top: MediaQuery.sizeOf(context).height * 0.012,
            // ),
            hintText: label,
            // prefixIcon: Padding(
            //   padding: EdgeInsets.only(
            //     top: MediaQuery.sizeOf(context).height * 0.002,
            //   ),
            //   // child: Icon(icon, color: Colors.blue),
            // ),
            //suffixIcon:
          ),

          //errorStyle: const TextStyle(height: 0),
        ),
      ),
    );*/
  }
}










/*
TextFormField(
            style: TextStyle(
                color: isDarkMode ? const Color(0xffADA4A5) : Colors.black),
            onChanged: (value) {
              setState(() {
                textfieldsStrings[stringToEdit] = value;
              });
            },
            validator: validator,
            textInputAction: TextInputAction.next,
            obscureText: password ? !pwVisible : false,
            decoration: InputDecoration(
              //errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(
                color: Color(0xffADA4A5),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                top: size.height * 0.012,
              ),
              hintText: hintText,
              prefixIcon: Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.002,
                ),
                child: Icon(
                  icon,
                  color: const Color(0xff7B6F72),
                ),
              ),
              suffixIcon: password
                  ? Padding(
                      padding: EdgeInsets.only(
                        top: size.height * 0.005,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            pwVisible = !pwVisible;
                          });
                        },
                        child: pwVisible
                            ? const Icon(
                                Icons.visibility_off_outlined,
                                color: Color(0xff7B6F72),
                              )
                            : const Icon(
                                Icons.visibility_outlined,
                                color: Color(0xff7B6F72),
                              ),
                      ),
                    )
                  : null,
            ),
          ),*/