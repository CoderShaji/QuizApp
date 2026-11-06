import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService._();

  static final AuthService instance = AuthService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<User?> authStateChanges() => _auth.userChanges();

  User? get currentUser => _auth.currentUser;

  bool get canUseGoogleSignIn {
    if (kIsWeb) {
      return true;
    }

    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw Exception('Unable to create account right now.');
    }

    await user.updateDisplayName(name.trim());
    await _safeUpsertUserProfile(
      user: user,
      name: name.trim(),
      email: email.trim(),
      provider: 'password',
    );
    await user.sendEmailVerification();
    await user.reload();
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final user = credential.user;
    if (user != null) {
      await _safeUpsertUserProfile(
        user: user,
        name: user.displayName,
        email: user.email,
        provider: 'password',
      );
    }
  }

  Future<void> signInWithGoogle() async {
    if (!canUseGoogleSignIn) {
      throw Exception(
        'Google sign-in is only available on Android, iOS, and Web.',
      );
    }

    UserCredential credential;

    if (kIsWeb) {
      credential = await _auth.signInWithPopup(GoogleAuthProvider());
    } else {
      final googleUser = await GoogleSignIn(scopes: ['email']).signIn();
      if (googleUser == null) {
        return;
      }

      final googleAuth = await googleUser.authentication;
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      credential = await _auth.signInWithCredential(authCredential);
    }

    final user = credential.user;
    if (user != null) {
      await _safeUpsertUserProfile(
        user: user,
        name: user.displayName,
        email: user.email,
        provider: 'google',
      );
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  Future<void> sendEmailVerification() async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('No logged in user found.');
    }

    await user.sendEmailVerification();
  }

  Future<User?> reloadCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) {
      return null;
    }

    await user.reload();
    return _auth.currentUser;
  }

  Future<void> changePassword(String newPassword) async {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('Please log in again to change your password.');
    }

    await user.updatePassword(newPassword);
  }

  Future<void> signOut() async {
    if (!kIsWeb && canUseGoogleSignIn) {
      try {
        await GoogleSignIn().signOut();
      } catch (_) {}
    }

    await _auth.signOut();
  }

  Future<void> _safeUpsertUserProfile({
    required User user,
    required String? name,
    required String? email,
    required String provider,
  }) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': (name ?? '').trim(),
        'email': (email ?? '').trim(),
        'provider': provider,
        'emailVerified': user.emailVerified,
        'updatedAt': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (_) {
      // Auth should still work even if profile writes are restricted.
    }
  }
}

String mapAuthError(Object error) {
  if (error is FirebaseAuthException) {
    switch (error.code) {
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'weak-password':
        return 'Password must be at least 6 characters long.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      case 'requires-recent-login':
        return 'Please log in again before changing your password.';
      case 'popup-closed-by-user':
        return 'Google sign-in was cancelled.';
      default:
        return error.message ?? 'Authentication failed. Please try again.';
    }
  }

  if (error is Exception) {
    return error.toString().replaceFirst('Exception: ', '');
  }

  return 'Something went wrong. Please try again.';
}
