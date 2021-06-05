

import 'package:e_home/domain/entities/user_entity.dart';
import 'package:e_home/domain/repositories/firebase_repository.dart';

class GetUsersUseCase {
  final FireBaseRepository repository;

  GetUsersUseCase({this.repository});

  Stream<List<UserEntity>> call() => repository.getUsers();


}