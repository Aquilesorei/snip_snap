// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class Profile extends _Profile with RealmEntity, RealmObjectBase, RealmObject {
  Profile(
    ObjectId id,
    String name,
    String email,
    String sex,
    String picture,
    bool isAdmin,
    String ownerId,
  ) {
    RealmObjectBase.set(this, '_id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'email', email);
    RealmObjectBase.set(this, 'sex', sex);
    RealmObjectBase.set(this, 'picture', picture);
    RealmObjectBase.set(this, 'isAdmin', isAdmin);
    RealmObjectBase.set(this, 'owner_id', ownerId);
  }

  Profile._();

  @override
  ObjectId get id => RealmObjectBase.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get email => RealmObjectBase.get<String>(this, 'email') as String;
  @override
  set email(String value) => RealmObjectBase.set(this, 'email', value);

  @override
  String get sex => RealmObjectBase.get<String>(this, 'sex') as String;
  @override
  set sex(String value) => RealmObjectBase.set(this, 'sex', value);

  @override
  String get picture => RealmObjectBase.get<String>(this, 'picture') as String;
  @override
  set picture(String value) => RealmObjectBase.set(this, 'picture', value);

  @override
  bool get isAdmin => RealmObjectBase.get<bool>(this, 'isAdmin') as bool;
  @override
  set isAdmin(bool value) => RealmObjectBase.set(this, 'isAdmin', value);

  @override
  String get ownerId => RealmObjectBase.get<String>(this, 'owner_id') as String;
  @override
  set ownerId(String value) => RealmObjectBase.set(this, 'owner_id', value);

  @override
  Stream<RealmObjectChanges<Profile>> get changes =>
      RealmObjectBase.getChanges<Profile>(this);

  @override
  Profile freeze() => RealmObjectBase.freezeObject<Profile>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObjectBase.registerFactory(Profile._);
    return const SchemaObject(ObjectType.realmObject, Profile, 'Profile', [
      SchemaProperty('id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('email', RealmPropertyType.string),
      SchemaProperty('sex', RealmPropertyType.string),
      SchemaProperty('picture', RealmPropertyType.string),
      SchemaProperty('isAdmin', RealmPropertyType.bool),
      SchemaProperty('ownerId', RealmPropertyType.string, mapTo: 'owner_id'),
    ]);
  }
}
