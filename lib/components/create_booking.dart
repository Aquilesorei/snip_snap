import 'package:flutter/material.dart';
import 'package:snip_snap/preferences.dart';
import '../components/widgets.dart';
import '../data_manager.dart';
import '../models/booking.dart';
import '../realm/realm_services.dart';
import 'package:provider/provider.dart';

class CreateBookingAction extends StatelessWidget {
  const CreateBookingAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return styledFloatingAddButton(context,
        onPressed: () => showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (_) => Wrap(children: const [CreateBookingForm()]),
            ));
  }
}

class CreateBookingForm extends StatefulWidget {
  const CreateBookingForm({Key? key}) : super(key: key);

  @override
  createState() => _CreateBookingFormState();
}

class _CreateBookingFormState extends State<CreateBookingForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _itemEditingController;

  @override
  void initState() {
    _itemEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _itemEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return formLayout(
        context,
        Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Make a booking", style: theme.titleLarge),
              TextFormField(
                controller: _itemEditingController,
                validator: (value) => (value ?? "").isEmpty ? "Please enter the service you need" : null,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    cancelButton(context),
                    Consumer<RealmServices>(builder: (context, realmServices, child) {
                      return okButton(context, "OK", onPressed: () => save(realmServices, context));
                    }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<void> save(RealmServices realmServices, BuildContext context) async{

    if (_formKey.currentState!.validate()) {
      final service = _itemEditingController.text;

      realmServices.createBooking(realmServices.profile.name,realmServices.profile.email, service);

        final result = realmServices.realm.query<Booking>("TRUEPREDICATE SORT(_id ASC)");
        for (var element in result) {
          DataManager.instance.subscribeForDeletion(element, element.dateTime);
        }
        if(!DataManager.instance.isActive()) {
        DataManager.instance.run(realmServices);
      }

      Navigator.pop(context);
    }
  }
}
