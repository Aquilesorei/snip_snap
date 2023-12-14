import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:snip_snap/components/haircut_gallery.dart';
import 'package:snip_snap/components/salon_photo.dart';
import 'package:snip_snap/components/service_card.dart';

import '../models/picture_directory.dart';

class HomeBody extends StatelessWidget {


  PictureDirectory?  _pictureDirectory;

   HomeBody({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size.width * 0.3;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            
            const Text(
              'Services Offered',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
             ServiceCard(
              title: 'Haircut',
              description: 'We offer trendy haircuts for men and women.',
              iconData: Icons.content_cut,
              onClick: () async {
                _pictureDirectory ??= await PictureDirectory.fromJsonAsset('assets/directory_map.json');

                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => PictureGalleryWidget(
                      womenPictures: _pictureDirectory!.women,
                      menPictures: _pictureDirectory!.men,
                    ),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0); // Start position of the widget
                      const end = Offset.zero; // End position of the widget
                      final tween = Tween(begin: begin, end: end);
                      final offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: 16.0),
             ServiceCard(
              title: 'Coloring',
              description: 'Get a new hair color with our professional colorists.',
              iconData: Icons.color_lens,
              onClick: () async {
                _pictureDirectory ??= await PictureDirectory.fromJsonAsset('assets/directory_map.json');
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => PictureGalleryWidget(
                      womenPictures: _pictureDirectory!.coloredWomen,
                      menPictures: _pictureDirectory!.coloredMan,
                    ),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0); // Start position of the widget
                      const end = Offset.zero; // End position of the widget
                      final tween = Tween(begin: begin, end: end);
                      final offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );

              },
            ),
            const SizedBox(height: 16.0),
             ServiceCard(
              title: 'Special Hairstyles',
              description: 'For special occasions, we provide elegant and unique hairstyles.',
              iconData: Icons.style,
              onClick: () async {
                _pictureDirectory ??= await PictureDirectory.fromJsonAsset('assets/directory_map.json');

                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) => GenericScafold(urlImages: _pictureDirectory!.occasion,),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const begin = Offset(1.0, 0.0); // Start position of the widget
                      const end = Offset.zero; // End position of the widget
                      final tween = Tween(begin: begin, end: end);
                      final offsetAnimation = animation.drive(tween);

                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );

              },
            ),
            const SizedBox(height: 32.0),
            const Text(
              'Opening Hours',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Monday - Friday: 9:00 AM - 6:00 PM',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            const Text(
              'Saturday: 9:00 AM - 4:00 PM',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32.0),
            const Text(
              'Salon Photos',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                SalonPhoto(imageUrl: 'assets/pictures/salon/1.jpg',size: size,),
                SalonPhoto(imageUrl: 'assets/pictures/salon/2.jpg',size: size,),
                SalonPhoto(imageUrl: 'assets/pictures/salon/3.jpg',size: size,),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
