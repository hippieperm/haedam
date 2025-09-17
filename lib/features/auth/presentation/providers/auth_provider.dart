import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/models/user_model.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authStateProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

final currentUserProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.when(
    data: (user) => user,
    loading: () => null,
    error: (_, __) => null,
  );
});

final userModelProvider = FutureProvider.family<UserModel?, String>((
  ref,
  uid,
) async {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.getUserModel(uid);
});

final currentUserModelProvider = Provider<AsyncValue<UserModel?>>((ref) {
  final currentUser = ref.watch(currentUserProvider);

  if (currentUser == null) {
    return const AsyncValue.data(null);
  }

  return ref.watch(userModelProvider(currentUser.uid));
});

final isAdminProvider = Provider<bool>((ref) {
  final userModel = ref.watch(currentUserModelProvider);
  return userModel.when(
    data: (model) => model?.roles['admin'] ?? false,
    loading: () => false,
    error: (_, __) => false,
  );
});

final isSellerProvider = Provider<bool>((ref) {
  final userModel = ref.watch(currentUserModelProvider);
  return userModel.when(
    data: (model) => model?.roles['seller'] ?? false,
    loading: () => false,
    error: (_, __) => false,
  );
});
