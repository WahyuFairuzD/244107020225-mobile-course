
import 'package:flutter_test/flutter_test.dart';
import 'package:campus_notify/features/auth/domain/entities/auth_session.dart';
import 'package:campus_notify/features/auth/domain/repositories/auth_repository.dart';
import 'package:campus_notify/features/auth/domain/usecases/login.dart';

class FakeAuthRepository implements AuthRepository {
  final bool shouldFail;

  FakeAuthRepository({this.shouldFail = false});

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    if (shouldFail) {
      throw Exception('Login gagal');
    }

    return AuthSession(
      access: 'fake-access-token',
      refresh: 'fake-refresh-token',
    );
  }

  @override
  Future<String> refresh(String refreshToken) async {
    return 'fake-renewed-access-token';
  }
}

void main() {
  group('Login use case', () {
    test('returns session when login succeeds', () async {
      final login = Login(FakeAuthRepository());

      final result = await login(
        email: 'wahyu@example.com',
        password: 'password123',
      );

      expect(result.access, 'fake-access-token');
      expect(result.refresh, 'fake-refresh-token');
    });

    test('throws exception when login fails', () async {
      final login = Login(
        FakeAuthRepository(shouldFail: true),
      );

      expect(
        () => login(
          email: 'wahyu@example.com',
          password: 'password123',
        ),
        throwsException,
      );
    });
  });
}
