import 'package:another_flushbar/flushbar.dart';
import 'package:dna_analyse/generated/l10n.dart';
import 'package:dna_analyse/screens/auth/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _newpasswordController = TextEditingController();
  final _connewpasswordController = TextEditingController();
  bool _obscurePassword = true;
  String errorMessage = "";
  final SupabaseClient _supabase = Supabase.instance.client;

  @override
  void dispose() {
    _passwordController.dispose();
    _newpasswordController.dispose();
    _connewpasswordController.dispose();
    super.dispose();
  }

  Future<void> updateUserPassword() async {
    try {
      final response = await _supabase.auth.updateUser(
        UserAttributes(password: _newpasswordController.text),
      );
      if (mounted) {
        await Flushbar(
          message: S.of(context).passwordUpdatedSuccessfully,
          duration: Duration(seconds: 1),
          backgroundColor: Colors.green,
          margin: EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(5),
        ).show(context);
      }
      Navigator.pop(context);
    } on AuthException catch (e) {
      print(e);
      errorMessage = e.message;
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          S.of(context).changePassword,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: LoginTheme.passwordlTextFieldFillColor,
                  labelText: S.of(context).currentPassword,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
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
              SizedBox(height: 12),
              TextFormField(
                controller: _newpasswordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: LoginTheme.passwordlTextFieldFillColor,
                  labelText: S.of(context).newPassword,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
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
              SizedBox(height: 12),
              TextFormField(
                controller: _connewpasswordController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: LoginTheme.passwordlTextFieldFillColor,
                  labelText: S.of(context).newPasswordRepeat,
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
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
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
              SizedBox(height: 15),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      updateUserPassword();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isDark
                            ? Colors.white.withOpacity(0.8)
                            : Colors
                                .grey[900], //Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    S.of(context).change,
                    style: TextStyle(
                      color: isDark ? Colors.grey[900] : Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
