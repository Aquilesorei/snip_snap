import 'package:realm/realm.dart';
import 'dart:io';

part 'booking.g.dart';

@RealmModel()
class _Booking {
  @MapTo('_id')
  @PrimaryKey()
  late final  ObjectId id;
  late final String customerName;
  late final String customerEmail;
  late final String stylistName;
  late final String stylistEmail;
  late final DateTime dateTime;
  late final String service;
  late final int duration;
  late final int price;
  @MapTo('owner_id')
  late String ownerId;
  late bool isAccepted;
  late bool isRejected ;
  late bool completed;

}
