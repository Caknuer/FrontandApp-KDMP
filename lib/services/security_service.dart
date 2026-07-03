import 'package:firebase_auth/firebase_auth.dart';

class SecurityService {

  static Future<String?> changePassword({

    required String currentPassword,
    required String newPassword,

  }) async {

    try {

      final user = FirebaseAuth.instance.currentUser;

      if (user == null) {

        return "User tidak ditemukan";

      }

      final credential = EmailAuthProvider.credential(

        email: user.email!,

        password: currentPassword,

      );

      await user.reauthenticateWithCredential(
        credential,
      );

      await user.updatePassword(
        newPassword,
      );

      return null;

    } on FirebaseAuthException catch (e) {

      return e.message;

    } catch (e) {

      return e.toString();

    }

  }

}