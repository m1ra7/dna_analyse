import 'package:flutter/foundation.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import 'package:flutter/foundation.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;
  // User? get currentUser => _supabase.currentUser;
  // Stream<User?> get authStateChanges => _supabase.authStateChanges();

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> createAccount({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }
}

/*firebase
ValueNotifier<AuthService> authService = ValueNotifier(AuthService());

class AuthService {
  final SupabaseClient _supabase = Supabase.instance.client;
  // User? get currentUser => _supabase.currentUser;
  // Stream<User?> get authStateChanges => _supabase.authStateChanges();

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> createAccount({
    required String email,
    required String password,
  }) async {
    return await _supabase.auth.signUp(email: email, password: password);
  }

  Future<void> signOut() async {
    await _supabase.auth.signOut();
  }

  Future<void> resetPassword({required String email}) async {
    await _supabase.auth.resetPasswordForEmail(email);
  }

  // Future<void> updateUsername({required String displayName}) async {
  //   await _supabase.auth.updateUser();
  // }

  String? getCurrentUserEmail() {
    final session = _supabase.auth.currentSession;
    final user = session?.user;
    return user?.email;
  }

  // Future<void> deleteAccount({
  //   required String email,
  //   required String password,
  // }) async {
  //   AuthCredential credential = EmailAuthProvider.credential(
  //     email: email,
  //     password: password,
  //   );
  //   await currentUser!.reauthenticateWithCredential(credential);
  //   await currentUser!.delete();
  //   await _supabase.signOut();
  // }

  // Future<void> resetPasswordFromCurrentPassword({
  //   required String currentPassword,
  //   required String newPassword,
  //   required String email,
  // }) async {
  //   AuthCredential credential = EmailAuthProvider.credential(
  //     email: email,
  //     password: newPassword,
  //   );
  //   await currentUser!.reauthenticateWithCredential(credential);
  //   await currentUser!.updatePassword(newPassword);
  // }
}
*/
