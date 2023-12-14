
import 'dart:math';

import 'package:realm/realm.dart';
import 'package:flutter/material.dart';
import 'package:snip_snap/models/specialoffer.dart';
import '../models/booking.dart';
import '../models/profile.dart';

class RealmServices with ChangeNotifier {
  static const String queryAllBooking = "getAllBookingSubscription";
  static const String queryAllProfiles = "getAllProfilesSubscrition";
  static const String queryAllOffers = "getAllOffersSubscription";
  
  static const queryMyProfile = "getMyProfileSubscription";
  static const queryMyBooking = "getMyBookingsSubscription";

  bool isAdmin = false;

  bool offlineModeOn = false;
  bool isWaiting = false;
  late Realm realm;
  User? currentUser;
  App app;
 late Profile profile;

  RealmServices(this.app) {
    if (app.currentUser != null || currentUser != app.currentUser) {
      currentUser ??= app.currentUser;
      realm = Realm(Configuration.flexibleSync(currentUser!, [Profile.schema,Booking.schema,SpecialOffer.schema]));
     
          final list = realm.query<Profile>(r'owner_id == $0', [currentUser?.id]);
          if(list.isNotEmpty) {
        isAdmin = list.first.isAdmin;
        profile = list.first;
      }

      if (realm.subscriptions.isEmpty) {
        updateSubscriptions();
      }
    }
  }

  Future<void> updateSubscriptions() async {
    realm.subscriptions.update((mutableSubscriptions) {
      mutableSubscriptions.clear();
      if (isAdmin) {
        mutableSubscriptions.add(realm.all<Booking>(), name: queryAllBooking);
        mutableSubscriptions.add(realm.all<Profile>(),name: queryAllProfiles);
      } else {
        mutableSubscriptions.add(realm.query<Booking>(r'owner_id == $0', [currentUser?.id]), name: queryMyBooking);
        mutableSubscriptions.add(realm.query<Profile>(r'owner_id == $0', [currentUser?.id]), name: queryMyProfile);
      }
      mutableSubscriptions.add(realm.all<SpecialOffer>(),name: queryAllOffers);
    });
    await realm.subscriptions.waitForSynchronization();
  }

  Future<void> sessionSwitch() async {
    offlineModeOn = !offlineModeOn;
    if (offlineModeOn) {
      realm.syncSession.pause();
    } else {
      try {
        isWaiting = true;
        notifyListeners();
        realm.syncSession.resume();
        await updateSubscriptions();
      } finally {
        isWaiting = false;
      }
    }
    notifyListeners();
  }

  Future<void> switchSubscription(bool value) async {

    if (!offlineModeOn) {
      try {
        isWaiting = true;
        notifyListeners();
        await updateSubscriptions();
      } finally {
        isWaiting = false;
      }
    }
    notifyListeners();
  }

  void createBooking(
      String customerName,
      String customerEmail,
      String service,
) {

    final booking =  Booking(ObjectId(), customerName, customerEmail,"", "", DateTime.now(), service, 0, 0,currentUser!.id,false,false,false);


    print("is admin $isAdmin");

    realm.write<Booking>(() => realm.add<Booking>(booking));
    notifyListeners();
  }

  void createProfile(String name,String email, bool isAdmin,String sex,String picture){
    final profile = Profile(ObjectId(), name, email,sex,picture,isAdmin,currentUser!.id);

    realm.write<Profile>(() => realm.add<Profile>(profile));
    notifyListeners();
  }

  void createOffer(
      String name,
      String description,
      String imageUrl,
      DateTime startDate,
      DateTime endDate,
      int discount
      ){


    final offer = SpecialOffer(ObjectId(), name, description, imageUrl, startDate, endDate, discount, currentUser!.id);
    realm.write<SpecialOffer>(() => realm.add<SpecialOffer>(offer));
    notifyListeners();
  }

  void deleteBooking(Booking booking) {
    realm.write(() => realm.delete(booking));
    notifyListeners();
  }

    void deleteProfile(Profile profile) {
      realm.write(() => realm.delete(profile));
      notifyListeners();
    }

  void deleteOffer(SpecialOffer offer) {
    realm.write(() => realm.delete(offer));
    notifyListeners();
  }

  Future<void> updateCompleted(Booking booking ,{required bool completed}) async {
    realm.write(() => booking.completed = completed);
  }


  Future<void> updateBooking(Booking booking,
      {   required String stylistName,required String stylistEmail,required DateTime dateTime,required int duration,required int price,required bool isAccepted}) async {
    realm.write(() {
      booking.stylistName =stylistName;
      booking.stylistEmail = stylistEmail;
      booking.dateTime = dateTime;
      booking.duration = duration;
      booking.price = price;
      booking.isAccepted = isAccepted;
      booking.isRejected = !isAccepted;

    });
    notifyListeners();
  }




  Future<void> close() async {
    if (currentUser != null) {
      await currentUser?.logOut();
      currentUser = null;
    }
    realm.close();
  }

  @override
  void dispose() {
    realm.close();
    super.dispose();
  }
}
