
import 'package:realm/realm.dart';

part 'specialoffer.g.dart';

@RealmModel()
class _SpecialOffer {
  @MapTo('_id')
  @PrimaryKey()
  late final ObjectId id;
  late final String name;
  late final String description;
  late final String imageUrl;
  late final DateTime startDate;
  late final DateTime endDate;
  late final int discount;
  @MapTo('owner_id')
  late String ownerId;
}

