

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:snip_snap/components/widgets.dart';
import 'package:snip_snap/preferences.dart';

import '../data_manager.dart';
import '../models/booking.dart';
import '../realm/realm_services.dart';


class EditBookingForm extends StatefulWidget {
  final Booking booking;

  const EditBookingForm({Key? key, required this.booking}) : super(key: key);

  @override
  State<EditBookingForm>  createState() => _EditBookingFormState();
}

class _EditBookingFormState extends State<EditBookingForm> {
  final _formKey = GlobalKey<FormState>();
  late DateTime _dateTime;
  late int _duration;
  late int _price;


  void _submitForm(RealmServices realmServices, BuildContext context){
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();


      realmServices.updateBooking(widget.booking,stylistEmail:  realmServices.profile.email,stylistName: realmServices.profile.name,dateTime: _dateTime,duration: _duration,price: _price,isAccepted : true);
      final result = realmServices.realm.query<Booking>("TRUEPREDICATE SORT(_id ASC)");
      for (var element in result) {
        DataManager.instance.subscribeForDeletion(element, element.dateTime);
      }
      if(!DataManager.instance.isActive()) {
        DataManager.instance.run(realmServices);
      }
      Navigator.of(context).pop();
    }
  }
  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    _duration =0;
    _price =0;
  }

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context, listen:  false);

    return formLayout(
        context,
        Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Date and time'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              final newDateTime = await showDatePicker(
                context: context,
                initialDate: _dateTime,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );
              if (newDateTime != null) {
                final newTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.fromDateTime(_dateTime),
                );
                if (newTime != null) {
                  setState(() {
                    _dateTime = DateTime(
                      newDateTime.year,
                      newDateTime.month,
                      newDateTime.day,
                      newTime.hour,
                      newTime.minute,
                    );
                  });
                }
              }
            },
            child: Text(DateFormat('dd/MM/yyyy \'at\' HH:mm').format(_dateTime)),
          ),
          const SizedBox(height: 16),


          TextFormField(
            initialValue: '$_duration',
            decoration: const InputDecoration(
              labelText: 'Duration (minutes)',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a duration';
              }
              final intDuration = int.tryParse(value);
              if (intDuration == null || intDuration <= 0) {
                return 'Please enter a valid duration';
              }
              return null;
            },
            onSaved: (value) {
              _duration = int.parse(value!);
            },
          ),
          const SizedBox(height: 16),

          TextFormField(
            initialValue: '$_price',
            decoration: const InputDecoration(
              labelText: 'Price',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a price';
              }
              final intPrice = int.tryParse(value);
              if (intPrice == null || intPrice <= 0) {
                return 'Please enter a valid price';
              }
              return null;
            },
            onSaved: (value) {
              _price = int.parse(value!);
            },
          ),
          const SizedBox(height: 32),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cancelButton(context),
                Consumer<RealmServices>(builder: (context, realmServices, child) {
                  return okButton(context, "OK", onPressed: () => _submitForm(realmServices, context));
                }),
              ],
            ),
          ),

        ],
      ),
    ));
  }
}
