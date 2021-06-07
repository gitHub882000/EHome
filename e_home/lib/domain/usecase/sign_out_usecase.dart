


import 'package:e_home/domain/repositories/firebase_repository.dart';

class SignOutUseCase{
  final FireBaseRepository repository;

  SignOutUseCase({this.repository});

  Future<void> call()async{
    return await repository.signOut();
  }

}