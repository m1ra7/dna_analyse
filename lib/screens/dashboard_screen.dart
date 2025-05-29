import 'package:dna_analyse/models/values.dart';
import 'package:dna_analyse/screens/view/health/dashboard_health_metrics_view.dart';
import 'package:dna_analyse/services/auth_service.dart';
import 'package:dna_analyse/services/loading_data.dart';
import 'package:dna_analyse/utils/appTheme.dart';
import 'package:dna_analyse/widgets/ai_button.dart';
import 'package:dna_analyse/widgets/mainWidgets.dart';
import 'package:flutter/material.dart';
import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/screens/view/%20dashboard/general_health_profile.dart';
import 'package:dna_analyse/screens/view/%20dashboard/health_stats_widgets.dart';
import 'package:dna_analyse/screens/view/health/widgets/health_metrics_card_widget.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

//Güncel
class Dashboard extends StatefulWidget {
  const Dashboard({super.key});
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late ScrollController scrollController;
  final authService = AuthService();
  // final SupabaseClient _supabase = Supabase.instance.client;
  bool showAppBarTitle = false;
  final String dnaImage = "assets/images/logo.png";
  Map<String, dynamic>? analysisData;
  bool isLoading = true;
  String? error;
  late Future<Map<String, dynamic>> futureAnalysis;
  //late Future<List<dynamic>> fetchProfile;

  Future<List<dynamic>> _fetchProfile() async {
    final user = Supabase.instance.client.auth.currentUser;

    final response = await Supabase.instance.client
        .from('profil')
        .select()
        .eq('id', user!.id);

    return response;
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      final isScrolled = scrollController.offset > 10;
      if (isScrolled != showAppBarTitle) {
        setState(() {
          showAppBarTitle = isScrolled;
        });
      }
    });

    futureAnalysis = JsonService.fetchDnaAnalysis();
    // fetchProfile = _fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDarkMode ? darkBackground : lightBackground,
      drawer: Customdrawer(),
      appBar: AppBar(
        title:
            scrollController.hasClients && scrollController.offset > 10
                ? Text(
                  S.of(context).dashboard,
                  style: Theme.of(context).textTheme.headlineSmall,
                )
                : null,
        actions: [AiAssistant()],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: futureAnalysis,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red),
                  SizedBox(height: 16),
                  Text('Hata: ${snapshot.error}'),
                ],
              ),
            );
          }
          final data = snapshot.data!;
          final results = data['analysisResult'];
          final keyHealthMetricsMap =
              data['analysisResult']['keyHealthMetrics'];
          final keyHealthMetricsList = keyHealthMetricsMap.entries.toList();

          return Scrollbar(
            controller: scrollController,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, bottom: 8),
                      child: Text(
                        S.of(context).dashboard,
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ),
                  ),
                  _dashboardHello(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GeneralHealthProfile(results),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      S.of(context).basicHealthMeasurements,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 250,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical, // Yatay kaydırma
                      padding: EdgeInsets.only(left: 10, right: 10),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        mainAxisExtent: 110,
                      ),
                      itemCount: keyHealthMetricsList.length,
                      // Lokalizasyonlu liste
                      itemBuilder: (context, index) {
                        final entry = keyHealthMetricsList[index];
                        final keyHealthMetricsName = keyMetrics(
                          context,
                        ); // Çevirileri al
                        return HealthMetricsCard(
                          metricKey: keyHealthMetricsName,
                          metricValue: entry.value,
                          index: index,
                        );
                      },
                    ),
                  ),
                  healtoverviewMetricsScreen(context, results),
                  healthstats(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  GestureDetector healtoverviewMetricsScreen(
    BuildContext context,
    dynamic results,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HealthMetricsScreen()),
        );
      },
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              S.of(context).HealthOverview,
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900),
            ),
            Icon(Icons.arrow_drop_down_sharp),
          ],
        ),
      ),
    );
  }

  Padding _dashboardHello() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${S.of(context).helloScreen},", //${analysisResult.userInformation.name}
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 5),
              Text(
                S.of(context).motiv,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Image.asset(dnaImage, height: 90, fit: BoxFit.cover),
        ],
      ),
    );
  }
}
