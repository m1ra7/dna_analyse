// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class AnalysisResult {
  final HealthRisk healthRisk;
  final NutritionProfile nutritionProfile;
  final FitnessProfile fitnessProfile;
  final UserInformation userInformation;
  final GeneticTraits geneticTraits;
  final KeyHealthMetrics keyHealthMetrics;
  final AnalysesInformation analysesInformation;

  AnalysisResult({
    required this.keyHealthMetrics,
    required this.userInformation,
    required this.geneticTraits,
    required this.healthRisk,
    required this.nutritionProfile,
    required this.fitnessProfile,
    required this.analysesInformation,
  });
}

class HealthRisk {
  final double riskScore;
  final List<String> preventiveMeasures;
  final List<Medicine> medicationRecommendations;
  final HealthConditions healthConditions;

  HealthRisk({
    required this.riskScore,
    required this.preventiveMeasures,
    required this.medicationRecommendations,
    required this.healthConditions,
  });
}

class HealthConditions {
  final List<HealthCondition> rad1;
  final List<HealthCondition> rad2;

  HealthConditions({required this.rad1, required this.rad2});
}

class HealthCondition {
  final String name;
  final String riskLevel;
  final List<String> markers;
  final List<String> recommendations;
  final int risk;

  HealthCondition({
    required this.name,

    required this.recommendations,
    required this.risk,
    required this.markers,
    required this.riskLevel,
  });
}

class NutritionProfile {
  final String vitaminNeeds;
  final String mineralNeeds;
  final String macronutrientSensitivities;
  final int rate;
  final String type;
  final String diet;
  final int maintenance;
  final int weightLoss;
  final int weightGain;
  final MacronutrientData macronutrientData;

  NutritionProfile({
    required this.macronutrientData,
    required this.rate,
    required this.diet,
    required this.type,
    required this.vitaminNeeds,
    required this.mineralNeeds,
    required this.macronutrientSensitivities,
    required this.maintenance,
    required this.weightLoss,
    required this.weightGain,
  });
}

class MacronutrientData {
  final double carbohydrates;
  final double protein;
  final double fats;
  MacronutrientData({
    required this.carbohydrates,
    required this.protein,
    required this.fats,
  });
}

class FitnessProfile {
  final String endurance;
  final String strength;
  final List<String> recommendations;
  final Aptitude aptitude;
  final Composition muscleFiberComposition;

  FitnessProfile({
    required this.muscleFiberComposition,
    required this.endurance,
    required this.strength,
    required this.recommendations,
    required this.aptitude,
  });
}

class Aptitude {
  final double power;
  final double flexibility;
  final double strength;
  final double endurance;

  Aptitude({
    required this.power,
    required this.flexibility,
    required this.strength,
    required this.endurance,
  });
}

class Composition {
  final double fastTwitch;
  final double slowTwich;

  Composition({required this.fastTwitch, required this.slowTwich});
}

class UserInformation {
  final String name;
  final String surname;
  final int age;
  final String gender;
  final String ethnicity;
  final String medicalHistory;
  final String familyHistory;
  final String bloodType;
  final String height;
  final String weight;
  final String allergies;
  final String currentMedications;
  final String haircolor;
  final String eyecolor;

  UserInformation({
    required this.name,
    required this.surname,
    required this.age,
    required this.gender,
    required this.ethnicity,
    required this.medicalHistory,
    required this.familyHistory,
    required this.bloodType,
    required this.height,
    required this.weight,
    required this.allergies,
    required this.currentMedications,
    required this.haircolor,
    required this.eyecolor,
  });
}

class GeneticTraits {
  final String tastePerception; // Tat algısı (Tatlı, acı, tuzlu vb.)
  final String circadianRhythm; // Sirkadiyen ritim (Sabahcı, gececi)
  final String colorVision; // Renk görme (Renk körlüğü)
  final String muscleStrength; // Kas gücü ve dayanıklılık
  final String painPerception; // Fiziksel ağrı algısı
  final String immuneSystemStrength; // Bağışıklık sistemi gücü
  final List<Traits> traits;

  GeneticTraits({
    required this.tastePerception,
    required this.circadianRhythm,
    required this.colorVision,
    required this.muscleStrength,
    required this.painPerception,
    required this.immuneSystemStrength,
    required this.traits,
  });
}

class Traits {
  String title;
  String result;
  String gene;
  String prevalence;
  String description;
  List<String> implications;
  List<GlobalDistribution>? globalDistribution; //null

  Traits({
    required this.title,
    required this.result,
    required this.gene,
    required this.prevalence,
    required this.description,
    required this.implications,
    this.globalDistribution,
  });
}

class GlobalDistribution {
  final String key;
  final dynamic value;
  GlobalDistribution({required this.key, required this.value});
}

class KeyHealthMetrics {
  final int cardiovascular;
  final int neurological;
  final int metabolisma;
  final int immuneSystem;

  KeyHealthMetrics({
    required this.cardiovascular,
    required this.neurological,
    required this.metabolisma,
    required this.immuneSystem,
  });
}

class AnalysesInformation {
  final String analysisName;
  final int sequenceLength;
  final List<String> analysisTypes;
  final DateTime createdAt;
  final List<String> keyFindings;
  final String? labName;
  final String? referenceNumber;
  final String? technologyUsed;
  final List<String> additionalInfo;

  AnalysesInformation({
    required this.analysisName,
    required this.sequenceLength,
    required this.analysisTypes,
    required this.createdAt,
    required this.keyFindings,
    required this.additionalInfo,
    this.labName,
    this.referenceNumber,
    this.technologyUsed,
  });
}

List<String> assessment = [
  "Rheumatoid Arthritis",
  "Alzheimer's Disease",
  "Colorectal Cancer",
  "Type 2 Diabetes",
  "Cardiovascular Disease",
];
List<String> macronutrientData = ["Carbohydrates", "Protein", "Fats"];
//30.0,40.0,20.0
List<String> macronutrientDistribution = ["Carbohydrates", "Protein", "Fats"];

class Medicine {
  final String id;
  final String name;
  final String dosage;
  final DateTime startDate;
  final DateTime? endDate;
  final TimeOfDay time;
  final bool isActive;
  final String? notes; // Yeni alan
  List<DateTime> takenDates;

  MedicineStatus status;
  DateTime? lastTaken;
  bool isTakenToday;

  Medicine({
    this.status = MedicineStatus.upcoming,
    this.lastTaken,
    this.isTakenToday = false,
    required this.id,
    required this.name,
    required this.dosage,
    required this.startDate,
    required this.time,
    this.endDate,
    this.isActive = true,
    this.notes,
    List<DateTime>? takenDates,
  }) : takenDates = takenDates ?? [];
}

enum MedicineStatus { upcoming, taken, missed }

//Sonuclarin verisi
final analysisResult = AnalysisResult(
  analysesInformation: AnalysesInformation(
    analysisName: '88Sample DNA Analysis with Known Markers',
    sequenceLength: 1500,
    analysisTypes: ['health_risk', 'nutrition', 'fitness', 'genetic_traits'],
    createdAt: DateTime.now(),
    keyFindings: [
      'Your DNA profile has been analyzed across several health domains.',
      'Identified 0 potential health risk factors',
      'Detected 3 nutritional sensitivities',
      'Found 2 fitness-related genetic markers',
    ],
    labName: "Genetics Lab",
    referenceNumber: "DNA-2023-8876",
    technologyUsed: "Next-Generation Sequencing",
    additionalInfo: [
      'Analysis performed using Next-Gen Sequencing',
      'Coverage depth: 30x',
      'Quality score: Q30',
    ],
  ),
  healthRisk: HealthRisk(
    riskScore: 0.3,
    medicationRecommendations: [
      Medicine(
        id: 'med1',
        name: 'Paracetamol',
        dosage: '500mg',
        startDate: DateTime.now(),
        time: TimeOfDay(hour: 9, minute: 0),
        notes: 'Aç karnına al',
      ),
      Medicine(
        id: 'med2',
        name: 'Ibuprofen',
        dosage: '200mg',
        startDate: DateTime.now(),
        time: TimeOfDay(hour: 14, minute: 0),
        notes: 'Yemekten sonra al',
      ),
      Medicine(
        id: 'med3',
        name: 'Aspirin',
        dosage: '300mg',
        startDate: DateTime.now().subtract(Duration(days: 2)),
        time: TimeOfDay(hour: 7, minute: 30),
        notes: 'Geceleri al',
      ),
      Medicine(
        id: 'med4',
        name: 'Amoxicillin',
        dosage: '500mg',
        startDate: DateTime.now().add(Duration(days: 1)),
        time: TimeOfDay(hour: 8, minute: 0),
        notes: 'Yemekle birlikte al',
      ),
      Medicine(
        id: 'med5',
        name: 'Metformin',
        dosage: '500mg',
        startDate: DateTime.now(),
        time: TimeOfDay(hour: 18, minute: 30),
        notes: 'Akşamları al',
      ),
      Medicine(
        id: 'med6',
        name: 'Loratadine',
        dosage: '10mg',
        startDate: DateTime.now().subtract(Duration(days: 5)),
        time: TimeOfDay(hour: 20, minute: 0),
        notes: 'Alerji için',
      ),
      Medicine(
        id: 'med7',
        name: 'Simvastatin',
        dosage: '20mg',
        startDate: DateTime.now().add(Duration(days: 3)),
        time: TimeOfDay(hour: 21, minute: 0),
        notes: 'Gece yatmadan önce al',
      ),
      Medicine(
        id: 'med8',
        name: 'Omeprazole',
        dosage: '20mg',
        startDate: DateTime.now().add(Duration(days: 4)),
        time: TimeOfDay(hour: 7, minute: 0),
        notes: 'Aç karnına al',
      ),
      Medicine(
        id: 'med9',
        name: 'Cetirizine',
        dosage: '10mg',
        startDate: DateTime.now(),
        time: TimeOfDay(hour: 12, minute: 0),
        notes: 'Günlük al',
      ),
      Medicine(
        id: 'med10',
        name: 'Losartan',
        dosage: '50mg',
        startDate: DateTime.now(),
        time: TimeOfDay(hour: 13, minute: 27),
        notes: 'Sabahları al',
      ),
      Medicine(
        id: 'med11',
        name: 'Hydrochlorothiazide',
        dosage: '25mg',
        startDate: DateTime.now().add(Duration(days: 2)),
        time: TimeOfDay(hour: 9, minute: 0),
        notes: 'Sabahları al',
      ),
      Medicine(
        id: 'med12',
        name: 'Sertraline',
        dosage: '50mg',
        startDate: DateTime.now().add(Duration(days: 5)),
        time: TimeOfDay(hour: 7, minute: 45),
        notes: 'Sabahları al',
      ),
      Medicine(
        id: 'med13',
        name: 'Gabapentin',
        dosage: '300mg',
        startDate: DateTime.now().add(Duration(days: 6)),
        time: TimeOfDay(hour: 22, minute: 0),
        notes: 'Gece yatmadan önce al',
      ),
      Medicine(
        id: 'med14',
        name: 'Furosemide',
        dosage: '40mg',
        startDate: DateTime.now(),
        time: TimeOfDay(hour: 8, minute: 30),
        notes: 'Sabahları al',
      ),
      Medicine(
        id: 'med15',
        name: 'Clopidogrel',
        dosage: '75mg',
        startDate: DateTime.now().subtract(Duration(days: 3)),
        time: TimeOfDay(hour: 10, minute: 0),
        notes: 'Yemekle birlikte al',
      ),
    ],
    preventiveMeasures: [
      "Bol su iç",
      "Günde 30 dakika yürüyüş yap",
      "Günde 8 bardak su iç",
      "Düzenli egzersiz yap (günde en az 30 dakika yürüyüş)",
      "Sağlıklı ve dengeli beslen",
      "Sigara ve alkolden uzak dur",
      "Düzenli uyku (günde 7-8 saat)",
      "Stresi azaltacak aktiviteler yap (meditasyon, yoga, vs.)",
      "Yüksek kalorili ve işlenmiş gıdalardan kaçın",
      "Düzenli sağlık kontrolleri yaptır",
      "Ellerini sık sık yıka",
      "Hijyene dikkat et",
      "Meyve ve sebze tüketimini artır",
      "Şeker tüketimini azalt",
      "Tuz kullanımını azalt",
      "Güneş ışığı al ama koruyucu kullan",
      "D vitamini seviyeni kontrol ettir",
      "Kahve ve enerji içeceği tüketimini sınırlı tut",
      "Günde en az 1 defa açık havaya çık",
      "Sırt ve duruş pozisyonuna dikkat et",
      "Zihinsel aktiviteler yap (bulmaca, kitap okuma vs.)",
      "Yeterli lif alımı sağla (tam tahıllar, sebzeler)",
      "Kafein tüketimini akşam saatlerinde sınırla",
      "Yeterli miktarda protein al",
      "Günlük multivitamin kullan (doktor önerisiyle)",
      "Düzenli olarak tansiyonunu ve nabzını ölç",
    ],
    healthConditions: HealthConditions(
      rad1: [
        HealthCondition(
          name: "cardiovascularDisease",
          recommendations: [
            'Regular cardio exercise',
            'Heart-healthy diet',
            'Monitor blood pressure',
            'Avoid smoking',
          ],
          risk: 40,
          markers: ['9p21', 'LDLR', 'APOB'],
          riskLevel: 'High',
        ),
        HealthCondition(
          name: "alzheimersDisease",
          riskLevel: 'High',
          markers: ['APOE ε4', 'CLU', 'CR1'],
          recommendations: [
            'Cognitive exercises',
            'Mediterranean diet',
            'Regular physical activity',
            'Quality sleep routine',
          ],
          risk: 10,
        ),
        HealthCondition(
          name: "rheumatoidArthritis",

          riskLevel: 'Moderate',
          markers: ['HLA-DRB1', 'PTPN22', 'STAT4'],
          recommendations: [
            'Joint-supportive exercise',
            'Regular monitoring',
            'Anti-inflammatory diet',
            'Vitamin D supplementation',
          ],
          risk: 20,
        ),
        HealthCondition(
          name: "type2Diabetes",
          riskLevel: 'Moderate',
          markers: ['TCF7L2', 'PPARG', 'KCNJ11'],
          recommendations: [
            'Monitor blood sugar levels',
            'Balanced carbohydrate intake',
            'Regular exercise',
            'Maintain healthy weight',
          ],
          risk: 13,
        ),
        HealthCondition(
          name: "colorectalCancer",
          riskLevel: 'Low',
          markers: ['APC', 'MLH1', 'MSH2'],
          recommendations: [
            'Regular colonoscopy after 45',
            'High-fiber diet',
            'Limit processed meats',
            'Maintain healthy weight',
          ],
          risk: 11,
        ),
      ],
      rad2: [
        HealthCondition(
          name: "bodyMassIndex",
          riskLevel: 'Moderate',
          markers: ['HLA-DRB1', 'PTPN22', 'STAT4'],
          recommendations: ['Regular exercise', 'Balanced diet'],
          risk: 40,
        ),
        HealthCondition(
          name: "bloodPressure",
          riskLevel: 'High',
          markers: ['ACE', 'AGT'],
          recommendations: ['Reduce salt intake', 'Monitor daily'],
          risk: 60,
        ),
        HealthCondition(
          name: "cholesterol",
          riskLevel: 'Low',
          markers: ['LDLR', 'APOB'],
          recommendations: ['Low-fat diet', 'Cardio exercises'],
          risk: 20,
        ),
        HealthCondition(
          name: "bloodSugar",
          riskLevel: 'Moderate',
          markers: ['GCK', 'HNF1A'],
          recommendations: ['Limit sugar intake', 'Regular checkups'],
          risk: 35,
        ),
        HealthCondition(
          name: "sleepQuality",
          riskLevel: 'Low',
          markers: ['Cortisol', 'Melatonin'],
          recommendations: [
            'Regular sleep schedule',
            'Avoid caffeine before bed',
          ],
          risk: 10,
        ),
        HealthCondition(
          name: "physicalCondition",
          riskLevel: 'Moderate',
          markers: ['Testosterone', 'Growth Hormone'],
          recommendations: [
            'Exercise 3 times a week',
            'Balanced protein intake',
          ],
          risk: 30,
        ),
      ],
    ),
  ),
  userInformation: UserInformation(
    name: "Mirac",
    surname: "Suicmez",
    age: 24,
    gender: "erkek",
    ethnicity: "ethnicity",
    medicalHistory: "medicalHistory",
    familyHistory: "familyHistory",
    bloodType: "0 RH+",
    height: "179",
    weight: "73",
    allergies: "Yok",
    currentMedications: "Yok",
    haircolor: "black",
    eyecolor: "blue",
  ),
  geneticTraits: GeneticTraits(
    tastePerception: 'Tatlıyı daha fazla hissediyor',
    circadianRhythm: 'Sabahcı',
    colorVision: 'Normal',
    muscleStrength: 'Orta düzeyde kas gücü',
    painPerception: 'Yüksek ağrı toleransı',
    immuneSystemStrength: 'Soğuk algınlığına karşı dirençli',
    traits: [
      Traits(
        title: "Earwax Type",
        result: "Dry-type earwax",
        gene: "ABCC11",
        prevalence: "Common in East Asian populations",
        description:
            "Your genetic results indicate you have dry-type earwax, which is associated with the ABCC11 gene variant.",
        implications: [
          "Common in 80-95% of East Asians",
          "Associated with reduced body odor",
          "May impact personal hygiene product choices",
        ],
        globalDistribution: [
          GlobalDistribution(key: 'East Asian', value: "80-90"),
          GlobalDistribution(key: 'Other', value: "5-20"),
        ],
      ),
      Traits(
        title: "Taste Perception",
        result: "Super Taster",
        gene: "TAS2R38",
        prevalence: "About 25% of population",
        description:
            "You have heightened sensitivity to bitter tastes due to variations in your TAS2R38 gene.",
        implications: [
          "More sensitive to bitter flavors",
          "May dislike certain vegetables",
          "Potentially more sensitive to spicy foods",
        ],

        globalDistribution: [
          GlobalDistribution(key: 'Non-Taster', value: 0.3),
          GlobalDistribution(key: 'Medium', value: 0.4),
          GlobalDistribution(key: 'Super-Taster', value: 0.3),
        ],
      ),
      Traits(
        title: "Circadian Rhythm",
        result: "Morning Chronotype",
        gene: "PER3",
        prevalence: "15-20% of population",
        description:
            "Your genetic profile suggests you're naturally inclined to be a morning person.",
        implications: [
          "Better productivity in mornings",
          "May struggle with night shifts",
          "Earlier natural sleep/wake times",
        ],
      ),
      Traits(
        title: "Lactose Tolerance",
        result: "Lactose Intolerant",
        gene: "MCM6",
        prevalence: "65% of adults worldwide",
        description:
            "Your genetic results suggest reduced lactase enzyme activity in adulthood.",
        implications: [
          "Potential discomfort from dairy",
          "May need lactose-free alternatives",
          "Common in most global populations",
        ],
      ),
      Traits(
        title: "Muscle Composition",
        result: "Power/Strength Oriented",
        gene: "ACTN3",
        prevalence: "30% of Europeans",
        description:
            "Your genetic profile shows a predisposition for power and strength activities.",
        implications: [
          "Higher proportion of fast-twitch fibers",
          "May excel in sprinting",
          "Potential for power sports advantage",
        ],
      ),
    ],
  ),
  keyHealthMetrics: KeyHealthMetrics(
    cardiovascular: 6,
    neurological: 3,
    metabolisma: 4,
    immuneSystem: 4,
  ),
  nutritionProfile: NutritionProfile(
    vitaminNeeds: "Vitamin A, Vitamin D",
    mineralNeeds: "Iron, Calcium ",
    macronutrientSensitivities: "Lactose, Gluten",
    type: "Dengeli metabolizma",
    diet: "Dengeli beslenme",
    rate: 2200,
    maintenance: 1432,
    weightLoss: 1923,
    weightGain: 2001,
    macronutrientData: MacronutrientData(
      carbohydrates: 30.0,
      protein: 40.0,
      fats: 20.0,
    ),
  ),
  fitnessProfile: FitnessProfile(
    endurance: "High",
    strength: "Medium",
    aptitude: Aptitude(
      power: 60.0,
      flexibility: 50.0,
      strength: 58.0,
      endurance: 52.0,
    ),
    recommendations: ["Situps", "Treadmill"],
    muscleFiberComposition: Composition(fastTwitch: 35.0, slowTwich: 65.0),
  ),
);


// Risk modeliniz (örnek bir sınıf)

/*
Rheumatoid Arthritis,
Alzheimer's Disease,
Colorectal Cancer,
Type 2 Diabetes,
Cardiovascular Disease*/


/*
Caloric Needs ,
Maintenance,
Weight Loss,
Weight Gain,*/

/*
Kalori Gereksinimleri,
Bakım,
Kilo Kaybı,
Kilo Alımı,
*/






/*


  s
*/