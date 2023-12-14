
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:realm/realm.dart';
import 'package:snip_snap/components/special_offer_item.dart';
import 'package:snip_snap/components/widgets.dart';

import '../models/specialoffer.dart';
import '../realm/realm_services.dart';
import 'create_offer.dart';

class OfferList extends StatefulWidget {
  const OfferList({Key? key}) : super(key: key);

  @override
  State<OfferList> createState() => _OfferListState();
}

class _OfferListState extends State<OfferList> {
  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);

    return
      Scaffold(
          appBar: AppBar(
            title: const Text('Special Offers'),
            centerTitle: true,

          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton: const CreateOfferAction(),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: StreamBuilder<RealmResultsChanges<SpecialOffer>>(
              stream: realmServices.realm
                  .query<SpecialOffer>("TRUEPREDICATE SORT(_id ASC)").changes,

              builder: (context, snapshot) {
                final data = snapshot.data;

                if (data == null) return  waitingIndicator();

                final results = data.results;
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: results.realm.isClosed ? 0 : results.length,
                  itemBuilder: (context, index) => results[index].isValid
                      ?  SpecialOfferListTile(specialOffer:results[index],)
                      : Container(),
                );
              },
            ),
          )
      );
  }
}


