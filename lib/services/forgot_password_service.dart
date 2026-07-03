import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordService {

  static Future<String?> resetPassword(
    String email,
  ) async {

    try {

      await FirebaseAuth.instance
          .sendPasswordResetEmail(
        email: email.trim(),
      );

      return null;

    } on FirebaseAuthException catch (e) {

      return e.message;

    } catch (e) {

      return e.toString();

    }

  }

}