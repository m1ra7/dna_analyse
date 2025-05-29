import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/services/auth_service.dart';
import 'package:dna_analyse/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  String email = '';

  final _formKey = GlobalKey<FormState>();
  final authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  Future<void> resetPassword() async {
    try {
      await authService.resetPassword(email: _emailController.text);
      Navigator.pop(context);
    } on AuthException catch (e) {
      print(e.message);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Error: ${e.message}",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.redAccent.shade200,
          ),
        );
      }
    }
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Mailinizi kontrol edin")));
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Color button = Color.fromARGB(255, 13, 13, 13);

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Reset Password',
          style: Theme.of(context).textTheme.displaySmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Please enter your email to reset your password.",
                      style: TextStyle(
                        color: isDarkMode ? Colors.white54 : Colors.black54,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor:
                        isDarkMode
                            ? button // const Color.fromARGB(255, 10, 10, 15)
                            : Colors.white,
                    labelStyle: TextStyle(
                      color:
                          isDarkMode
                              ? Colors.grey.shade400
                              : Colors.grey.shade800,
                    ),
                    labelText: S.of(context).email,
                    hintStyle: TextStyle(
                      color:
                          isDarkMode
                              ? Colors.grey.shade500
                              : Colors.grey.shade600,
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
                      Icons.email_outlined,
                      color: isDarkMode ? Colors.grey.shade600 : Colors.black,
                    ),
                  ),

                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return S.of(context).invalidEmail;
                    }
                    if (!value.contains('@')) {
                      return S.of(context).invalidEmail;
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 18),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("${_emailController.text} mail gönderiliyor..");
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
                  // style: ElevatedButton.styleFrom(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  // ),
                  child: Text(
                    'Send',
                    style: TextStyle(
                      color: isDarkMode ? Colors.grey[900] : Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              /*Padding(
                padding: EdgeInsets.only(top: size.height * 0.08),
                child: Row(
                  //TODO: replace text logo with your logo
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [],
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }

  bool pwVisible = false;
  Widget buildTextField(
    String hintText,
    IconData icon,
    bool password,
    size,
    FormFieldValidator validator,
    bool isDarkMode,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.025),
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.06,
        decoration: BoxDecoration(
          color:
              isDarkMode
                  ? const Color.fromARGB(255, 29, 27, 32)
                  : const Color(0xffF7F8F8),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Form(
          key: _formKey,
          child: TextFormField(
            style: TextStyle(
              color: isDarkMode ? const Color(0xffADA4A5) : Colors.black,
            ),
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            validator: validator,
            textInputAction: TextInputAction.next,
            obscureText: password ? !pwVisible : false,
            decoration: InputDecoration(
              errorStyle: const TextStyle(height: 0),
              hintStyle: const TextStyle(color: Color(0xffADA4A5)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: size.height * 0.02),
              hintText: hintText,
              prefixIcon: Padding(
                padding: EdgeInsets.only(top: size.height * 0.005),
                child: Icon(icon, color: const Color(0xff7B6F72)),
              ),
              suffixIcon:
                  password
                      ? Padding(
                        padding: EdgeInsets.only(top: size.height * 0.005),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              pwVisible = !pwVisible;
                            });
                          },
                          child:
                              pwVisible
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
          ),
        ),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> buildSnackError(
    String error,
    context,
    size,
  ) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red,
        content: SizedBox(
          height: size.height * 0.02,
          child: Center(
            child: Text(error, style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }
}
