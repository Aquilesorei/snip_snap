

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:snip_snap/components/widgets.dart';
import 'package:snip_snap/utils.dart';

import '../data_manager.dart';
import '../models/specialoffer.dart';
import '../realm/realm_services.dart';
import 'choose_file.dart';



class CreateOfferAction extends StatelessWidget {
  const CreateOfferAction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return styledFloatingAddButton(context,
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (_) => Wrap(children: const [CreateOfferForm()]),
        ));
  }
}
class CreateOfferForm extends StatefulWidget {
  const CreateOfferForm({super.key});

  @override
  State<CreateOfferForm> createState() => _CreateOfferFormState();
}

class _CreateOfferFormState extends State<CreateOfferForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _name = '';
  String _description = '';
  String _imageUrl = '';
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  int _discount = 0;
  String _filename = "";
  bool _isVisible = false;
  bool _isLoading = false;
  late File _file;
  static const space = 10.0;

  Future<void> _submitForm(RealmServices realmServices, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      // Form is valid, save the offer or perform any other necessary actions
      _formKey.currentState!.save();

      setState(() {
        _isLoading = true;
      });

      _imageUrl = await CloudManager.uploadFile(_file.path);

      realmServices.createOffer(_name, _description, _imageUrl, _startDate, _endDate, _discount);

      final result = realmServices.realm.query<SpecialOffer>("TRUEPREDICATE SORT(_id ASC)");
      for (var element in result) {
        DataManager.instance.subscribeForDeletion(element, element.endDate);
      }
      if(!DataManager.instance.isActive()) {
        DataManager.instance.run(realmServices);
      }

      Navigator.pop(context);
      // TODO: Handle saving the new offer or performing other actions
      setState(() {
        _isLoading = false;
      });
      // Clear the form
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
         children :
         [
           formLayout(
        context,
        Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
            onSaved: (value) {
              _name = value!;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Description'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              return null;
            },
            onSaved: (value) {
              _description = value!;
            },
          ),
          const SizedBox(height: space),
          Visibility(
            visible: _isVisible,
            child : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children :[
                  Text(
                      _filename,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.start
                  ),
                  IconButton(
                      onPressed: (){

                        setState(() {
                          _filename = "";
                          _isVisible=  _filename.isNotEmpty;
                        });
                      },
                      icon: const Icon(Icons.close,color: Colors.grey,)
                  )
                ]
            ),),

          ChooseFile(
             color: Colors.black,
              onFileChoosen: (file) {
                setState(() {
                  _file = file;
                  _filename = file.uri.pathSegments.last;
                  _isVisible=  _filename.isNotEmpty;
                });

              }
          ),
          ElevatedButton(
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _startDate ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                setState(() {
                  _startDate = pickedDate;
                });
              }
            },
            child: Text(
              _startDate != null
                  ? 'Start Date: ${DateFormat('dd/MM/yyyy').format(_startDate!)}'
                  : 'Select Start Date',
            ),
          ),
          const SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _endDate,
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
              );

              if (pickedDate != null) {
                setState(() {
                  _endDate = pickedDate;
                });
              }
            },
            child: Text(
              _endDate != null
                  ? 'End Date: ${DateFormat('dd/MM/yyyy').format(_endDate!)}'
                  : 'Select End Date',
            ),
          ),

          TextFormField(
            decoration: const InputDecoration(labelText: 'Discount'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a discount value';
              }
              if (int.tryParse(value) == null) {
                return 'Please enter a valid number';
              }
              return null;
            },
            onSaved: (value) {
              _discount = int.parse(value!);
            },
          ),
          const SizedBox(height: 16.0),
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
    )
       ),
           Center(
             child: Visibility(
               visible: _isLoading,
               child: LoadingAnimationWidget.flickr(
                 leftDotColor: const Color(0xFF1A1A3F),
                 rightDotColor: const Color.fromARGB(255, 12, 110, 42),
                 size: 50,
               ),
             ),
           )
         ]
    );
  }
}
