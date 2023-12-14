import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';

import '../models/profile.dart';
import '../models/specialoffer.dart';

import '../realm/realm_services.dart';
class SpecialOfferListTile extends StatefulWidget {

  final SpecialOffer specialOffer;

  SpecialOfferListTile({super.key, required this.specialOffer});
  @override
  State<SpecialOfferListTile> createState()  =>_SpecialOfferListTileState();

}

class _SpecialOfferListTileState extends  State<SpecialOfferListTile> {

  bool _isLoading = false;


  void _handleImageLoading(bool isLoading) {
    setState(() {
      _isLoading = isLoading;
    });
  }

  late NetworkImage _image;
  @override
  void initState() {
    super.initState();

    // Register the image loading callbacks
    final imageProvider = NetworkImage(widget.specialOffer.imageUrl);
    _image = imageProvider;
    imageProvider.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
            (info, synchronousCall) {
          _handleImageLoading(false); // Image finished loading
        },
        onError: (error, stackTrace) {
          _handleImageLoading(false); // Image loading error occurred
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final realmServices = Provider.of<RealmServices>(context);
    final res = realmServices.realm.query<Profile>(r'owner_id == $0', [realmServices.currentUser?.id]);
    final DateFormat dateFormat = DateFormat('dd MMMM yyyy');

    final String startDateFormatted = dateFormat.format(widget.specialOffer.startDate);
    final String endDateFormatted = dateFormat.format(widget.specialOffer.endDate);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Stack(
         children :
         [
           Container(
            height: 200,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              image: DecorationImage(
                image: _image,
                fit: BoxFit.cover,
              ),
            ),
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
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.specialOffer.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.specialOffer.description,
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Discount: ${widget.specialOffer.discount}%',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    const Icon(Icons.calendar_today),
                    const SizedBox(width: 4.0),
                    Flexible(
                      child: Text(
                        'Valid from $startDateFormatted to $endDateFormatted',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
