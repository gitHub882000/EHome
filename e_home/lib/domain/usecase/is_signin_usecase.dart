
import 'package:e_home/domain/repositories/firebase_repository.dart';

class IsSignInUseCase{
  final FireBaseRepository repository;

  IsSignInUseCase(this.repository);

  Future<bool> call() async => repository.isSignIn();
}