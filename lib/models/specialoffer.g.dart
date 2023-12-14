// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'specialoffer.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class SpecialOffer extends _SpecialOffer
    with RealmEntity, RealmObjectBase, RealmObject {
  SpecialOffer(
    ObjectId id,
    String name,
    String description,
    String imageUrl,
    DateTime startDate,
    DateTime endDate,
    int discount,
    String ownerId,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'description', description);
    RealmObjectBase.set(this, 'imageUrl', imageUrl);
    RealmObjectBase.set(this, 'startDate', startDate);
    RealmObjectBase.set(this, 'endDate', endDate);
    RealmObjectBase.set(this, 'discount', discount);
    RealmObjectBase.set(this, 'owner_id', ownerId);
  }

  SpecialOffer._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) =>  RealmObjectBase.set(this, 'name', value);

  @override
  String get description =>
      RealmObjectBase.get<String>(this, 'description') as String;
  @override
  set description(String value) =>  RealmObjectBase.set(this, 'description', value);

  @override
  String get imageUrl =>
      RealmObjectBase.get<String>(this, 'imageUrl') as String;
  @override
  set imageUrl(String value) =>  RealmObjectBase.set(this, 'imageUrl', value);

  @override
  DateTime get startDate =>
      RealmObjectBase.get<DateTime>(this, 'startDate') as DateTime;
  @override
  set startDate(DateTime value) =>  RealmObjectBase.set(this, 'startDate', value);

  @override
  DateTime get endDate =>
      RealmObjectBase.get<DateTime>(this, 'endDate') as DateTime;
  @override
  set endDate(DateTime value) =>  RealmObjectBase.set(this, 'endDate', value);

  @override
  int get discount => RealmObjectBase.get<int>(this, 'discount') as int;
  @override
  set discount(int value) =>  RealmObjectBase.set(this, 'discount', value);

  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  Stream<RealmObjectChanges<SpecialOffer>> get changes =>
      RealmObjectBase.getChanges<SpecialOffer>(this);

  @override
  SpecialOffer freeze() => RealmObjectBase.freezeObject<SpecialOffer>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(SpecialOffer._);
    return const SchemaObject(
        ObjectType.realmObject, SpecialOffer, 'SpecialOffer', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('description', RealmPropertyType.string),
      SchemaProperty('imageUrl', RealmPropertyType.string),
      SchemaProperty('startDate', RealmPropertyType.timestamp),
      SchemaProperty('endDate', RealmPropertyType.timestamp),
      SchemaProperty('discount', RealmPropertyType.int),
      SchemaProperty('ownerId', RealmPropertyType.string, mapTo: 'owner_id'),
    ]);
  }
}
