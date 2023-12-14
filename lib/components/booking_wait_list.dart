
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:snip_snap/components/booking_item.dart';
import 'package:snip_snap/components/widgets.dart';
import 'package:snip_snap/models/booking.dart';

import '../realm/realm_services.dart';


class BookingWaitList extends StatefulWidget {
  const BookingWaitList({Key? key}) : super(key: key);

  @override
  State<BookingWaitList> createState() => _BookingWaitListState();
}

class _BookingWaitListState extends State<BookingWaitList> {
  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);

    return  Padding(

        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: StreamBuilder<RealmResultsChanges<Booking>>(
          stream:realmServices.isAdmin ? realmServices.realm.query<Booking>(r'owner_id != $0', ["biscuit"]).changes

              : realmServices.realm.query<Booking>(r'owner_id == $0', [realmServices.currentUser?.id]).changes,
          builder: (context, snapshot) {
            final data = snapshot.data;

            if (data == null) return waitingIndicator();

            final results = data.results;
           // print(results.first.customerEmail);
            return ListView.builder(
              shrinkWrap: true,
              itemCount: results.realm.isClosed ? 0 : results.length,
              itemBuilder: (context, index) => results[index].isValid && ((results[index].isRejected == results[index].isAccepted ) && !results[index].isAccepted )
                  ? BookingItem(results[index])
                  : Container(),
            );
          },
        ),
      );

  }
}
