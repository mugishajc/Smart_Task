import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smart_task/constant/shared_preference_key.dart';
import 'package:smart_task/feature/home/controllers/tasks_controller.dart';
import '../../../core/dependency/dependency.dart';
import '../../../core/logger.dart';

final authStateChangesProvider = StreamProvider<User?>(
  (ref) => ref.watch(Dependency.firebaseAuth).authStateChanges(),
);

final authRepoProvider = Provider((ref) => AuthenticationRepository(ref));

class AuthenticationRepository {
  AuthenticationRepository(this.ref);

  final Ref ref;

  FirebaseAuth get _firebaseAuth => ref.read(Dependency.firebaseAuth);
  GoogleSignIn get _googleSignIn => ref.read(Dependency.googleSignIn);

  static Provider<AuthenticationRepository> get provider => authRepoProvider;

  Future<UserCredential> signIn(
      {required String email, required String password}) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e, stackTrace) {
      Log.error("Sign in error: ${e.code} - ${e.message}",
          error: e, stackTrace: stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      Log.error("Unexpected sign-in error: $e",
          error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<UserCredential> signUp(
      {required String email, required String password}) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e, stackTrace) {
      Log.error("Sign up error: ${e.code} - ${e.message}",
          error: e, stackTrace: stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      Log.error("Unexpected sign-up error: $e",
          error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
        return await _firebaseAuth.signInWithPopup(googleAuthProvider);
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
        if (googleUser == null) return null;

        final GoogleSignInAuthentication googleSignInAuth =
            await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth.accessToken,
          idToken: googleSignInAuth.idToken,
        );

        return await _firebaseAuth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e, stackTrace) {
      Log.error("Google sign-in error: ${e.code} - ${e.message}",
          error: e, stackTrace: stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      Log.error("Unexpected Google sign-in error: $e",
          error: e, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
      await setValue(USER_UID, "");
      ref.invalidate(pendingTasksProvider);
      ref.invalidate(completedTasksProvider);
    } on FirebaseAuthException catch (e, stackTrace) {
      Log.error("Sign out error: ${e.code} - ${e.message}",
          error: e, stackTrace: stackTrace);
      rethrow;
    } catch (e, stackTrace) {
      Log.error("Unexpected sign-out error: $e",
          error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
