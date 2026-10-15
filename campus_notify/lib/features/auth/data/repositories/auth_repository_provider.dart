import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/auth_repository.dart';
import '../../domain/usecases/refresh_token.dart';
import 'auth_repository_impl.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);

final refreshTokenUseCaseProvider = Provider<RefreshToken>(
  (ref) => RefreshToken(ref.watch(authRepositoryProvider)),
);