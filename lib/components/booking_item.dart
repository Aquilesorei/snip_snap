

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snip_snap/components/update_booking.dart';
import 'package:snip_snap/components/widgets.dart';
import 'package:snip_snap/realm/realm_services.dart';

import '../models/booking.dart';
import '../models/profile.dart';
enum MenuOption { edit, delete }
class BookingItem extends StatefulWidget{

  final Booking booking;
  const BookingItem(this.booking,{Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BookingItemState();

}

class BookingItemState extends State<BookingItem> {



  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);
     final res = realmServices.realm.query<Profile>(r'owner_id == $0', [realmServices.currentUser?.id]);
     final profile = res.first;
      final isWaiting = ((widget.booking.isRejected == widget.booking.isAccepted ) && !widget.booking.isAccepted);

     if(profile.isAdmin){
       final dateTimeString =  !isWaiting ? DateFormat('dd/MM/yyyy \'at\' HH:mm').format(widget.booking.dateTime) : "-";
       final durationString =  !isWaiting ? '${widget.booking.duration ~/ 60}h ${widget.booking.duration % 60}m' : "-";

       final isAccepted = widget.booking.isAccepted;
       return ListTile(
         title:KeyValue(context, "Service", widget.booking.service),
         subtitle: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             KeyValue(context, "Customer name", widget.booking.customerName),
             KeyValue(context, "Customer email", widget.booking.customerEmail),
             KeyValue(context, "Date and time", dateTimeString),
             KeyValue(context,"Duration", durationString),
             KeyValue(context, "Price", "${isWaiting  ? " - " :widget.booking.price}")
           ],
         ),
         trailing: isAccepted
             ? ElevatedButton(
           onPressed:()=> handleButtonClick(context,MenuOption.delete,widget.booking,realmServices),
           child: const Text('Cancel'),
         )
             : Row(
           mainAxisSize: MainAxisSize.min,
           children: [
             ElevatedButton(
               onPressed:()=> handleButtonClick(context,MenuOption.edit,widget.booking,realmServices),
               child: const Text('Accept'),
             ),
             const SizedBox(width: 8),
             ElevatedButton(
               onPressed:()=> handleButtonClick(context,MenuOption.delete,widget.booking,realmServices),
               child: const Text('Reject'),
             ),
           ],
         ),
         shape: const Border(bottom: BorderSide()),
       );
     }
     else {
       final dateTimeString = DateFormat('dd/MM/yyyy \'at\' HH:mm').format(widget.booking.dateTime);
       final durationString =
           '${widget.booking.duration ~/ 60}h ${widget.booking.duration % 60}m';
       return ListTile(
         title: Text(widget.booking.service),
         subtitle: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             KeyValue(context, "Date and time", dateTimeString),
             KeyValue(context,"Duration", durationString),
             KeyValue(context, "Price", "${isWaiting  ? " - " :widget.booking.price}")

           ],
         ),
         trailing: ElevatedButton(
           onPressed: ()=> handleButtonClick(context,MenuOption.delete,widget.booking,realmServices),
           child: const Text('Cancel'),
         ),
       );

     }

  }

  void handleButtonClick(BuildContext context, MenuOption menuItem, Booking booking,RealmServices realmServices) {
    switch (menuItem) {
      case MenuOption.edit:
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => Wrap(children: [EditBookingForm(booking  :booking) ]),
          );

        break;
      case MenuOption.delete:
          realmServices.deleteBooking(booking);

        break;
    }
  }
}


