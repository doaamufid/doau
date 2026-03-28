
import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 1)
 class UserModel{
  @HiveField(0)
   String? email;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? password;

  UserModel({this.email,this.password, this.name});
}