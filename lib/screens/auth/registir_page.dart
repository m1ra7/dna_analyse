import 'package:another_flushbar/flushbar.dart';
import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/screens/auth/auth_page.dart';
import 'package:dna_analyse/screens/form/get_user_data.dart';
import 'package:dna_analyse/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class DarkRegistirTheme {
  static const Color signUpButton = Colors.white;
  static const Color signUpButtonText = Colors.black;
}

class LightRegistirTheme {
  static Color signUpButton = Colors.grey.shade900;
  static const Color signUpButtonText = Colors.white;
}

class RegistirPage extends StatefulWidget {
  const RegistirPage({super.key});

  @override
  State<RegistirPage> createState() => _RegistirPageState();
}

class _RegistirPageState extends State<RegistirPage> {
  final _formKey = GlobalKey<FormState>();
  final authService = AuthService();

  final PageController _pageController = PageController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmePasswordController =
      TextEditingController();
  bool _obscurePassword = true;

  int _currentPage = 0;
  String? _selectedGender;
  String? _selectedBloodType;
  String _name = '';
  int _age = 30;
  String _email = '';
  String _password = '';

  // final List<Map<String, dynamic>> pages = [
  //   {'title': 'Adınız', 'hint': 'Tam adınızı giriniz'},
  //   {'title': 'Yaşınız', 'hint': 'Yaşınızı seçiniz'},
  //   {'title': 'E-posta', 'hint': 'E-posta adresiniz'},
  //   {'title': 'Şifre', 'hint': 'Şifrenizi oluşturun'},
  // ];

  Future<void> register() async {
    if (_passwordController.text != _confirmePasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Sifreler ayni degil !")));
      return;
    }

    try {
      await authService.createAccount(
        email: _emailController.text,
        password: _passwordController.text,
      );
      // Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserData()),
      );
    } on AuthException catch (e) {
      print(e.message);
      if (mounted) {
        Flushbar(
          message: e.message,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.redAccent.shade200,
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(5),
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SizedBox(height: 20),
          Form(
            key: _formKey,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [_buildEmailPasswordPage(isDarkMode)],
            ),
          ),
          // Positioned(
          //   bottom: 160,
          //   left: 0,
          //   right: 0,
          //   child: Center(
          //     child: SmoothPageIndicator(
          //       controller: _pageController,
          //       count: 2,
          //       effect: WormEffect(
          //         dotHeight: 5,
          //         dotWidth: 24,
          //         activeDotColor: Colors.white,
          //         dotColor: Colors.grey,
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            bottom: 90,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    print(
                      "${_emailController.text} ${_passwordController.text}",
                    );
                    register();

                    // if (_currentPage < _getLocalizedPages(context).length - 1) {
                    //   setState(() {
                    //     _currentPage++;
                    //   });
                    //   _pageController.nextPage(
                    //     duration: const Duration(milliseconds: 500),
                    //     curve: Curves.easeInOut,
                    //   );
                    // } else {
                    //   if (_formKey.currentState!.validate()) {
                    //     print(
                    //       "${_emailController.text} ${_passwordController.text}",
                    //     );
                    //     register();
                    //   }
                    // }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isDarkMode
                          ? DarkRegistirTheme.signUpButton
                          : LightRegistirTheme.signUpButton,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: Text(
                  S.of(context).signUp,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                    color:
                        isDarkMode
                            ? DarkRegistirTheme.signUpButtonText
                            : LightRegistirTheme.signUpButtonText,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmailPasswordPage(isDarkMode) {
    final String backgroundImage = "assets/images/dnalogo.png";

    return Stack(
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
        Column(
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).whatIsYourEmail,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      //color: Colors.deepPurple[900],
                    ),
                  ),
                  const SizedBox(height: 30),

                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,

                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          isDarkMode
                              ? const Color.fromARGB(255, 10, 10, 15)
                              : Colors.white,
                      labelText: S.of(context).authEmailTitle,
                      labelStyle: TextStyle(
                        color:
                            isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade800,
                      ),
                      hintStyle: TextStyle(
                        color:
                            isDarkMode
                                ? Colors.grey.shade500
                                : Colors.grey.shade600,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? Colors.grey.shade800 : Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? Colors.grey.shade800 : Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? Colors.grey.shade400 : Colors.black,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red.shade400),
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: isDarkMode ? Colors.grey.shade600 : Colors.black,
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).invalidEmail;
                      }
                      if (!value.contains('@')) {
                        return S.of(context).invalidEmail;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 1000.ms),
            Padding(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    S.of(context).createPassword,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      //color: Colors.deepPurple[900],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          isDarkMode
                              ? const Color.fromARGB(255, 10, 10, 15)
                              : Colors.white,
                      labelText: S.of(context).authPasswordTitle,

                      labelStyle: TextStyle(
                        color:
                            isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade800,
                      ),
                      hintStyle: TextStyle(
                        color:
                            isDarkMode
                                ? Colors.grey.shade500
                                : Colors.grey.shade600,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? Colors.grey.shade800 : Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? Colors.grey.shade800 : Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? Colors.grey.shade400 : Colors.black,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red.shade400),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: isDarkMode ? Colors.grey.shade600 : Colors.black,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).enterPassword;
                      }
                      if (value.length < 6) {
                        return S.of(context).invalidPassword;
                      }
                      return null;
                    },

                    onSaved: (value) {
                      _password = value!;
                    },
                  ),

                  SizedBox(height: 10),
                  TextFormField(
                    controller: _confirmePasswordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:
                          isDarkMode
                              ? const Color.fromARGB(255, 10, 10, 15)
                              : Colors.white,
                      labelText: S.of(context).authPasswordTitle,

                      labelStyle: TextStyle(
                        color:
                            isDarkMode
                                ? Colors.grey.shade400
                                : Colors.grey.shade800,
                      ),
                      hintStyle: TextStyle(
                        color:
                            isDarkMode
                                ? Colors.grey.shade500
                                : Colors.grey.shade600,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? Colors.grey.shade800 : Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? Colors.grey.shade800 : Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? Colors.grey.shade400 : Colors.black,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.red.shade400),
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: isDarkMode ? Colors.grey.shade600 : Colors.black,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return S.of(context).enterPassword;
                      }
                      if (value.length < 6) {
                        return S.of(context).invalidPassword;
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(S.of(context).doYouHaveAccount),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          S.of(context).login,
                          style: TextStyle(
                            color: isDarkMode ? Colors.white : Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(duration: 1500.ms),
          ],
        ),
      ],
    );
  }
}
