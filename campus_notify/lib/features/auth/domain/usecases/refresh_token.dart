
import '../repositories/auth_repository.dart';

class RefreshToken {
  RefreshToken(this._repository);

  final AuthRepository _repository;

  Future<String> call(String refreshToken) {
    return _repository.refresh(refreshToken);
  }
}
