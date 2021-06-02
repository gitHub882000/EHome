

import 'package:e_home/domain/repositories/firebase_repository.dart';

class SignUpUseCase{
  final FireBaseRepository repository;

  SignUpUseCase({this.repository});

  Future<void> call(String email,String password) async{
    return repository.signUp(email, password);
  }
}