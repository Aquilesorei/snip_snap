import 'package:flutter/material.dart';
import 'package:snip_snap/components/booking_accepted_list.dart';
import 'package:snip_snap/components/booking_finished_list.dart';
import 'package:snip_snap/components/booking_wait_list.dart';


class BookingManager extends StatefulWidget {
  const BookingManager({Key? key}) : super(key: key);

  @override
  State<BookingManager> createState() => _BookingManagerState();
}

class _BookingManagerState extends State<BookingManager> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Booking"),
          bottom: const TabBar(
            isScrollable: true,
            tabs: [
              Tab(
                icon: Icon(Icons.hourglass_empty_sharp),
                text: "Waiting",
              ),
              Tab(
                icon: Icon(Icons.check_circle_outlined),
                text: "confirmed",
              ),
              Tab(
                icon: Icon(Icons.history),
                text: "History",
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            BookingWaitList() ,
            BookingAcceptedList(),
            BookingFinishedList()
          ],
        ),
      ),
    );

  }
}
