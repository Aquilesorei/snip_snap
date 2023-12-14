// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Booking extends _Booking with RealmEntity, RealmObjectBase, RealmObject {
  Booking(
    ObjectId id,
    String customerName,
    String customerEmail,
    String stylistName,
    String stylistEmail,
    DateTime dateTime,
    String service,
    int duration,
    int price,
    String ownerId,
    bool isAccepted,
    bool isRejected,
    bool completed,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'customerName', customerName);
    RealmObjectBase.set(this, 'customerEmail', customerEmail);
    RealmObjectBase.set(this, 'stylistName', stylistName);
    RealmObjectBase.set(this, 'stylistEmail', stylistEmail);
    RealmObjectBase.set(this, 'dateTime', dateTime);
    RealmObjectBase.set(this, 'service', service);
    RealmObjectBase.set(this, 'duration', duration);
    RealmObjectBase.set(this, 'price', price);
    RealmObjectBase.set(this, 'owner_id', ownerId);
    RealmObjectBase.set(this, 'isAccepted', isAccepted);
    RealmObjectBase.set(this, 'isRejected', isRejected);
    RealmObjectBase.set(this, 'completed', completed);
  }

  Booking._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get customerName => RealmObjectBase.get<String>(this, 'customerName') as String;
  @override
  set customerName(String value) => RealmObjectBase.set(this,'customerName', value);


  @override
  String get customerEmail => RealmObjectBase.get<String>(this, 'customerEmail') as String;
  @override
  set customerEmail(String value) => RealmObjectBase.set(this,'customerEmail', value);


  @override
  String get stylistName => RealmObjectBase.get<String>(this, 'stylistName') as String;
  @override
  set stylistName(String value) => RealmObjectBase.set(this,'stylistName', value);


  @override
  String get stylistEmail => RealmObjectBase.get<String>(this, 'stylistEmail') as String;
  @override
  set stylistEmail(String value) => RealmObjectBase.set(this,'stylistEmail', value);


  @override
  String get service => RealmObjectBase.get<String>(this, 'service') as String;
  @override
  set service(String value) => RealmObjectBase.set(this,'service', value);


  @override
  DateTime get dateTime => RealmObjectBase.get<String>(this, 'dateTime') as DateTime;
  @override
  set dateTime(DateTime value) => RealmObjectBase.set(this,'dateTime', value);

  @override
  int get duration => RealmObjectBase.get<int>(this, 'duration') as int;
  @override
  set duration(int value) => RealmObjectBase.set(this,'duration', value);


  @override
  int get  price => RealmObjectBase.get<int>(this, 'price') as int;
  @override
  set price(int value) => RealmObjectBase.set(this,'price', value);


  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  bool get isAccepted => RealmObjectBase.get<bool>(this, 'isAccepted') as bool;
  @override
  set isAccepted(bool value) => RealmObjectBase.set(this, 'isAccepted', value);

  @override
  bool get isRejected => RealmObjectBase.get<bool>(this, 'isRejected') as bool;
  @override
  set isRejected(bool value) => RealmObjectBase.set(this, 'isRejected', value);

  @override
  bool get completed => RealmObjectBase.get<bool>(this, 'completed') as bool;
  @override
  set completed(bool value) => RealmObjectBase.set(this, 'completed', value);

  @override
  Stream<RealmObjectChanges<Booking>> get changes =>
      RealmObjectBase.getChanges<Booking>(this);

  @override
  Booking freeze() => RealmObjectBase.freezeObject<Booking>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Booking._);
    return const SchemaObject(ObjectType.realmObject, Booking, 'Booking', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('customerName', RealmPropertyType.string),
      SchemaProperty('customerEmail', RealmPropertyType.string),
      SchemaProperty('stylistName', RealmPropertyType.string),
      SchemaProperty('stylistEmail', RealmPropertyType.string),
      SchemaProperty('dateTime', RealmPropertyType.timestamp),
      SchemaProperty('service', RealmPropertyType.string),
      SchemaProperty('duration', RealmPropertyType.int),
      SchemaProperty('price', RealmPropertyType.int),
      SchemaProperty('ownerId', RealmPropertyType.string, mapTo: 'owner_id'),
      SchemaProperty('isAccepted', RealmPropertyType.bool),
      SchemaProperty('isRejected', RealmPropertyType.bool),
      SchemaProperty('completed', RealmPropertyType.bool),
    ]);
  }
}
