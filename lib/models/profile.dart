

import 'package:realm/realm.dart';
import 'dart:io';

part 'profile.g.dart';

@RealmModel()
class _Profile{
  @MapTo('_id')
  @PrimaryKey()
  late final  ObjectId id;
  late String name;
  late String email;
  late String sex;
  late String picture;
  late bool isAdmin ;
  @MapTo('owner_id')
  late String ownerId;
}