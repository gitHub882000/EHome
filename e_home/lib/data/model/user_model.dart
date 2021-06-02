import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_home/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({String name, String email, String uid, String profileUrl})
      : super(name, email, uid, profileUrl);

  factory UserModel.fromJson(Map<String,dynamic> json){
    return UserModel(
      name: json['name'],
      profileUrl: json['profileUrl'],
      email: json['email'],
      uid: json['uid']
    );
  }
  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> documentSnapshot){
    return UserModel(
      name: documentSnapshot.data()['name'],
      uid: documentSnapshot.data()['uid'],
      email: documentSnapshot.data()['email'],
      profileUrl: documentSnapshot.data()['profileUrl'],
    );
  }
  Map<String,dynamic> toDocument(){
    return {
      "name" :name,
      "uid" :uid,
      "email":email,
      "profileUrl":profileUrl,
    };
  }
}
