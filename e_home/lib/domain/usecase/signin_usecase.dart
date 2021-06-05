

import 'package:e_home/domain/repositories/firebase_repository.dart';

class SignInUseCase{
  final FireBaseRepository repository;

  SignInUseCase({this.repository});

  Future<void> call(String email,String password){
    return repository.signIn(email, password);
  }

}