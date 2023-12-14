
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:realm/realm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snip_snap/models/booking.dart';
import 'package:snip_snap/models/profile.dart';
import 'package:snip_snap/models/specialoffer.dart';
import 'package:snip_snap/realm/realm_services.dart';
import 'dart:core';
import 'package:synchronized/synchronized.dart';


class DataManager {
  final _lock = Lock();
  final _dates = <dynamic, DateTime>{};

  static DataManager? _instance;

  DataManager._(); // private constructor

  static DataManager get instance {
    _instance ??= DataManager._(); // create a new instance if it doesn't exist
    return _instance!;
  }

  Timer? _timer;

  void run(RealmServices realmServices) {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) async {
      await check(realmServices);
      if (_dates.isEmpty) {
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> check(RealmServices realmServices) async {
    await _lock.synchronized(() {
      final keysToRemove = <dynamic>[];

      _dates.forEach((key, value) {
        // Check if it's time to run the task
        if (DateTime.now().isAfter(value)) {
          if (key is Booking) {
            realmServices.updateCompleted(key, completed: true);
            keysToRemove.add(key);
          } else if (key is Profile) {
            realmServices.deleteProfile(key);
            keysToRemove.add(key);
          } else if (key is SpecialOffer) {
            realmServices.deleteOffer(key);
            keysToRemove.add(key);
          }
        }
      });

      for (var key in keysToRemove) {
        _dates.remove(key);
      }
    });
  }

  Future<void> subscribeForDeletion(dynamic obj, DateTime dateTime) async {
    await _lock.synchronized(() {
      _dates[obj] = dateTime;
    });
  }

  bool isActive() => _timer != null;
}


