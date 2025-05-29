import 'package:another_flushbar/flushbar.dart';
import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/screens/auth/registir_page.dart';
import 'package:dna_analyse/screens/auth/forgot_password_page.dart';
import 'package:dna_analyse/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class LoginTheme {
  static const Color emailTextFieldFillColor = Color.fromARGB(255, 13, 13, 13);
  static const Color passwordlTextFieldFillColor = Color.fromARGB(
    255,
    13,
    13,
    13,
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final String loginLogo = "assets/images/loginlogo.png";

  bool _obscurePassword = true;
  String errorMessage = "";

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    try {
      await authService.signIn(
        email: _emailController.text,
        password: _passwordController.text,
      );
      print("Login yapildi !");
      Navigator.pop(context);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => MyHomePage()),
      // );
    } on AuthException catch (e) {
      print(e);

      errorMessage = e.message ?? 'This is not working';

      if (mounted) {
        Flushbar(
          message: e.message,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.redAccent.shade200,
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(5),
        ).show(context);
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       "Error: ${e.message}",
        //       style: TextStyle(color: Colors.white),
        //     ),
        //     backgroundColor: Colors.redAccent.shade200,
        //   ),
        // );
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
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isDarkMode
                        ? Colors.white.withValues(alpha: 0.02)
                        : Colors.black.withValues(alpha: 0.08),
              ),
            ),
          ),

          Positioned(
            bottom: -100,
            left: -120,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    isDarkMode
                        ? Colors.white.withValues(alpha: 0.02)
                        : Colors.black.withValues(alpha: 0.08),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                // Logo ve Başlık
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        fit: BoxFit.fill,
                        loginLogo,
                        color:
                            isDarkMode
                                ? Colors.grey[400]
                                : Colors
                                    .black, //Theme.of(context).colorScheme.primary,
                      ),
                      Text(
                        "DNA Analyses",
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium?.copyWith(
                          color: isDarkMode ? Colors.grey[300] : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),

                      Text(
                        S.of(context).unlockGeneticPotential,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color:
                              isDarkMode ? Colors.grey[600] : Colors.grey[900],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Giriş Formu
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              isDarkMode
                                  ? const Color.fromARGB(255, 10, 10, 15)
                                  : Colors.white,
                          labelText: S.of(context).email,
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
                                  isDarkMode
                                      ? Colors.grey.shade800
                                      : Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color:
                                  isDarkMode
                                      ? Colors.grey.shade800
                                      : Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color:
                                  isDarkMode
                                      ? Colors.grey.shade400
                                      : Colors.black,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.red.shade400),
                          ),
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color:
                                isDarkMode
                                    ? Colors.grey.shade600
                                    : Colors.black,
                          ),
                        ),

                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).enterEmail;
                          }
                          if (!value.contains('@')) {
                            return S.of(context).validEmail;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              isDarkMode
                                  ? const Color.fromARGB(255, 10, 10, 15)
                                  : Colors.white,
                          labelText: S.of(context).password,
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
                                  isDarkMode
                                      ? Colors.grey.shade800
                                      : Colors.black,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color:
                                  isDarkMode
                                      ? Colors.grey.shade800
                                      : Colors.black,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color:
                                  isDarkMode
                                      ? Colors.grey.shade400
                                      : Colors.black,
                              width: 2,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.red.shade400),
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outlined,
                            color:
                                isDarkMode
                                    ? Colors.grey.shade600
                                    : Colors.black,
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

                        obscureText: _obscurePassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return S.of(context).enterPassword;
                          }
                          if (value.length < 6) {
                            return S.of(context).passwordMinLength;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 5),
                      //  Text(errorMessage, style: TextStyle(color: Colors.red)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPasswordPage(),
                                ),
                              );
                            },
                            child: Text(
                              S.of(context).forgotPassword,
                              style: TextStyle(
                                color:
                                    isDarkMode
                                        ? Colors.white
                                        : Colors.grey[900],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              login();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isDarkMode
                                    ? Colors.white.withOpacity(0.8)
                                    : Colors
                                        .grey[900], //Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            S.of(context).login,
                            style: TextStyle(
                              color:
                                  isDarkMode ? Colors.grey[900] : Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      //const SizedBox(height: 24),
                      //_orLine(),
                      //const SizedBox(height: 24),
                      //_googleLogin(),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => RegistirPage()),
                      );
                      // Navigator.pushAndRemoveUntil(
                      //   context,
                      //   MaterialPageRoute(builder: (_) => const Registir_Page()),
                      //   (route) => false,
                      // );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: S.of(context).noAccount,
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.grey[900],
                        ),
                        children: [
                          TextSpan(
                            text: S.of(context).signUp,
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Row _orLine() {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: isDarkMode ? Colors.grey.shade400 : Colors.black,
            thickness: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            S.of(context).or,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.shade400, thickness: 1)),
      ],
    );
  }
}
