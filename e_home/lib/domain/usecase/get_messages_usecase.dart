

import 'package:e_home/domain/entities/text_message_entity.dart';
import 'package:e_home/domain/repositories/firebase_repository.dart';

class GetMessagesUseCase {
  final FireBaseRepository repository;

  GetMessagesUseCase({this.repository});

  Stream<List<TextMessageEntity>> call() => repository.getMessages();

}