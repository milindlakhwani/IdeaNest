import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/core/utils.dart';
import 'package:reddit_clone/features/auth/repository/auth_repository.dart';
import 'package:reddit_clone/models/user_model.dart';

// With state provider we can change the content or the value of the state provider.
// Since we are returning null initially, we have to specify the type of the provider explicitily.
final userProvider = StateProvider<UserModel?>((ref) => null);
// UserModel can be null so we are adding UserModel?

// Provider is a read only widget. Value of provider cannot be changed.
// ProviderRef gives a bunch of methods to talk to other to providers.
final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    // Used watch to get any changes made inn authRepositoryProvider
    authRepository: ref.watch(authRepositoryProvider),
    ref: ref,
  ),
);

final authStateChangeProvider = StreamProvider((ref) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.authStateChange;
});

// This StreamProvider will be conitnuously used everywhere, so it allows us to reuse it.
// Whereas streamBuilder doesn't allows to reuse it.
final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authControllerProvider.notifier);
  return authController.getUserData(uid);
}); // family allows to use getUserDataProvider as a function, so that we can pass the uid of the user.

// Similar to ChangeNotifierProvider, StateNotifier means if there are any changes made to the state we want to notify
// it to every provider that will be listening to it.
class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false); //loading part
  // super(T) needs a type for the state, in this case we are using it to check loading state, we only have simple boolean.

  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context, bool isFromLogin) async {
    state = true;
    // We don't need to do any notifyListeners() as StateNotifier automatically does that whenever there is a change in state.
    final user = await _authRepository.signInWithGoogle(isFromLogin);
    state = false;
    // l means left i.e the error, and r means right meaning Success.
    user.fold(
      (l) {
        showToast(
            "Google verification wasn't completed successfully. Please try again.");
      },
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
    // _ref.read(userProvider) gives us access to the UserModel and not any thing to update, but we need to update it in this case.
    // So userProvider.notifier gives us access to multiple methods that allows us to change the content over here.
    // state here is the state of the UserModel before we update it.
  }

  void signInAsGuest(BuildContext context) async {
    state = true;
    _authRepository.logOut();
    final user = await _authRepository.signInAsGuest();
    state = false;
    user.fold(
      (l) => showSnackBar(context, l.message),
      (userModel) =>
          _ref.read(userProvider.notifier).update((state) => userModel),
    );
  }

  Stream<UserModel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }

  void logOut() async {
    _authRepository.logOut();
  }
}
