import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_task/constant/shared_preference_key.dart';
import 'package:smart_task/core/base/base_state.dart';
import 'package:smart_task/core/logger.dart';
import 'package:smart_task/data/repository/authentication/authentication_repository.dart';
import 'package:smart_task/core/dependency/repository.dart';
import 'package:nb_utils/nb_utils.dart';

final authenticationProvider = StateNotifierProvider(
      (ref) => AuthenticationController(ref: ref),
);

class AuthenticationController extends StateNotifier<BaseState> {
  AuthenticationController({required this.ref}) : super(InitialState()) {
    _repository = ref.watch(Repository.authentication);
  }

  final Ref ref;
  late AuthenticationRepository _repository;

  static StateNotifierProvider<AuthenticationController, dynamic>
  get controller => authenticationProvider;

  Future<void> signIn({required String email, required String password}) async {
    try {
      state = LoadingState();
      await _repository.signIn(email: email, password: password);
      _handleAuthStateChange();
    } on FirebaseAuthException catch (e, stackTrace) {
      Log.error("Sign in error: $e");
      Log.error(stackTrace.toString());
      state = ErrorState(message: e.message ?? "Sign in failed"); // Provide a fallback message
    }
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      state = LoadingState();
      await _repository.signUp(email: email, password: password);
      _handleAuthStateChange();
    } on FirebaseAuthException catch (e, stackTrace) {
      Log.error("Sign up error: $e");
      Log.error(stackTrace.toString());
      state = ErrorState(message: e.message ?? "Sign up failed");
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      state = LoadingState();
      await _repository.signInWithGoogle();
      _handleAuthStateChange();
    } on FirebaseAuthException catch (e, stackTrace) {
      Log.error("Google sign in error: $e");
      Log.error(stackTrace.toString());
      state = ErrorState(message: e.message ?? "Google sign in failed");
    } catch (e, stackTrace) {
      Log.error("General sign in error: $e");
      Log.error(stackTrace.toString());
      state = ErrorState(message: "Something went wrong");
    }
  }

  void _handleAuthStateChange() {
    ref.read(authStateChangesProvider).whenData((user) {
      if (user != null) {
        try {
          setValue(USER_UID, user.uid);
          Log.info("User UID: ${user.uid}");
          state = SuccessState();
        } catch (e, stackTrace) {
          Log.error("Error saving user UID: $e");
          Log.error(stackTrace.toString());
          state = ErrorState(message: "Failed to save user UID");
        }
      } else {
        state = ErrorState(message: "Authentication state changed to null");
      }
    });
  }

  Future<void> signOut() async {
    try {
      await _repository.signOut();
    } catch (e, stackTrace) {
      Log.error("Sign out failed: $e");
      Log.error(stackTrace.toString());
      state = ErrorState(message: "Sign out failed");
    }
  }
}