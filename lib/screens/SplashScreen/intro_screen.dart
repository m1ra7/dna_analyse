import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/provider/locale_provider.dart';
import 'package:dna_analyse/screens/auth/auth_page.dart';
import 'package:dna_analyse/screens/auth/registir_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late PageController _pageController = PageController();
  int _currentPage = 0;
  late List<Map<String, dynamic>> _pages;
  String? _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages = _getLocalizedPages(context);
  }

  // final List<Map<String, dynamic>> _pages2 = [
  //   {
  //     'title': 'Advanced Genome Sequencing',
  //     'description':
  //         'Discover your unique genetic makeup with our cutting-edge analysis technology',
  //     'image': 'assets/images/pille.png',
  //     'color': Colors.deepPurple,
  //   },
  //   {
  //     'title': 'Health Insights',
  //     'image': 'assets/images/pille.png',
  //     'color': Colors.blueAccent,
  //   },
  //   {
  //     'title': 'Ancestry Breakdown',
  //     'image': 'assets/images/pille.png',
  //     'color': Colors.teal,
  //   },
  // ];

  // final List<Map<String, dynamic>> _oldpages = [
  //   {
  //     'title': 'DNA\nAnaliziniz',
  //     'description':
  //         'Discover your unique genetic makeup with our cutting-edge analysis technology',
  //     'icon': Icons.biotech,
  //     'color': Colors.green,
  //     'image': 'assets/images/dnalogo.png',
  //   },
  //   {
  //     'title': 'Sağlık',
  //     'description':
  //         'Genetik yapınızı keşfedin, sağlığınızı daha yakından tanıyın. DNA analizinizle hastalıklara yatkınlıklarınızı öğrenin ve kişiselleştirilmiş sağlık önerileri alın.',
  //     'icon': Icons.medical_services,
  //     'color': Colors.red,
  //     'image': 'assets/images/health.png',
  //   },
  //   // {
  //   //   'title': 'İlaç\nUyumunuz',
  //   //   'description':
  //   //       'Get personalized health recommendations based on your DNA',
  //   //   'icon': Icons.medical_services,
  //   //   'color': Colors.blue,
  //   //   'image': 'assets/images/pille.png',
  //   // },
  //   {
  //     'title': 'Fit Kalma',
  //     'description':
  //         'DNA analiziniz sayesinde genetik hastalık risklerinizi, vitamin ve mineral eksikliklerinizi, vücudunuza en uygun egzersiz ve ilaçları öğrenin. Genetik yapınıza özel sağlık tavsiyeleriyle daha bilinçli ve sağlıklı bir yaşam sürün.',
  //     'icon': Icons.medical_services,
  //     'color': Colors.blue,
  //     'image': 'assets/images/pille.png',
  //   },
  // ];

  List<Map<String, dynamic>> _getLocalizedPages(BuildContext context) {
    return [
      {
        'title': S.of(context).dnaAnalysisTitle,
        'description': S.of(context).dnaAnalysisDesc,
        'icon': Icons.biotech,
        'color': Colors.green,
        'image': 'assets/images/dnalogo.png',
      },
      {
        'title': S.of(context).healthTitle,
        'description': S.of(context).healthDesc,
        'icon': Icons.medical_services,
        'color': Colors.red,
        'image': 'assets/images/health.png',
      },
      {
        'title': S.of(context).fitnessTitle,
        'description': S.of(context).fitnessDesc,
        'icon': Icons.fitness_center, // Changed to more appropriate icon
        'color': Colors.blue,
        'image': 'assets/images/pille.png', // Consider changing image
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    // final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 15),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return _buildPage(_pages[index]);
            },
          ),
          Positioned(
            top: 50,
            left: 270,
            child: DropdownButton<String>(
              borderRadius: BorderRadius.circular(10),

              padding: EdgeInsets.all(8),
              value: _selectedLanguage,
              hint: Text(S.of(context).language),
              dropdownColor: Colors.grey[800], // Açılır menü rengi beyaz
              style: TextStyle(
                color: Colors.white, // Seçilen metnin rengi
                fontSize: 16,
              ),
              underline: Container(height: 2, color: Colors.transparent),
              items:
                  ["English", "Türkçe"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
              onChanged: (newValue) {
                setState(() {
                  if (newValue == "Türkçe") {
                    context.read<LocaleProvider>().setTurkish();
                  } else if (newValue == "English") {
                    context.read<LocaleProvider>().setEnglish();
                  }
                  _selectedLanguage = newValue;
                });
              },
            ),
          ),

          Positioned(
            bottom: 160,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _pages.length,
                effect: WormEffect(
                  activeDotColor: _pages[_currentPage]['color'],
                  dotColor: Colors.grey[500]!, //isDark ? : Colors.grey[500]!,
                  dotHeight: 5,
                  dotWidth: 24,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage < _pages.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                RegistirPage(), //RegistirPage(), //MyHomePage()
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _pages[_currentPage]['color'],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  _currentPage == _pages.length - 1
                      ? S.of(context).createAccount
                      : S.of(context).next,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),

          if (_currentPage == _pages.length - 1)
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: TextButton(
                child: Text(
                  S.of(context).haveAccount,
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(), //MyHomePage()
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPage(Map<String, dynamic> page) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Stack(
      children: [
        // Arka plan resmi
        Positioned.fill(
          child: Opacity(
            opacity: 0.4, // Resmin şeffaflığını ayarlayabilirsiniz
            child: Image.asset(page['image'], fit: BoxFit.cover),
          ),
        ),
        // İçerik
        Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            verticalDirection: VerticalDirection.down,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 120),
              Text(
                page['title'],
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: page['color'],
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              Text(
                page['description'],
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.grey[500],
                  height: 1.6,
                ),
                textAlign: TextAlign.left,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
