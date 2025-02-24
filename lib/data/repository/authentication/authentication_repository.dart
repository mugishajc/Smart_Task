import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../core/dependency/dependency.dart';
import '../../../core/logger.dart';

final authStateChangesProvider = StreamProvider<User?>(
      (ref) => ref.watch(Dependency.firebaseAuth).authStateChanges(),
);

final authRepoProvider = Provider((ref) => AuthenticationRepository(ref.read));

class AuthenticationRepository {
  AuthenticationRepository(this.reader) {
    _firebaseAuth = reader(Dependency.firebaseAuth);
  }

  final Reader reader;
  late FirebaseAuth _firebaseAuth;

  static Provider<AuthenticationRepository> get provider => authRepoProvider;

  Future<UserCredential> signIn({required String email, required String password}) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Log.error("Sign in error: ${e.code} - ${e.message}");
      throw e;
    } catch (e, stackTrace) {
      Log.error("Unexpected sign in error: $e");
      Log.error(stackTrace.toString());
      throw e;
    }
  }

  Future<UserCredential> signUp({required String email, required String password}) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      Log.error("Sign up error: ${e.code} - ${e.message}");
      throw e;
    } catch (e, stackTrace) {
      Log.error("Unexpected sign up error: $e");
      Log.error(stackTrace.toString());
      throw e;
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        final GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
        await _firebaseAuth.signInWithRedirect(googleAuthProvider);
        return null;
      } else {
        final GoogleSignInAccount? googleUser = await reader(Dependency.googleSignIn).signIn();
        if (googleUser == null) {
          return null;
        }
        final GoogleSignInAuthentication googleSignInAuth = await googleUser.authentication;
        final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuth.accessToken,
          idToken: googleSignInAuth.idToken,
        );
        return await _firebaseAuth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      Log.error("Google sign in error: ${e.code} - ${e.message}");
      throw e;
    } catch (e, stackTrace) {
      Log.error("Unexpected Google sign in error: $e");
      Log.error(stackTrace.toString());
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await reader(Dependency.googleSignIn).signOut();
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      Log.error("Sign out error: ${e.code} - ${e.message}");
      throw e;
    } catch (e, stackTrace) {
      Log.error("Unexpected sign out error: $e");
      Log.error(stackTrace.toString());
      throw e;
    }
  }
}