


import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:snip_snap/components/salon_photo.dart';

import 'gallery_widget.dart';

class PictureGalleryWidget extends StatelessWidget {
  final List<String> womenPictures;
  final List<String> menPictures;


  const PictureGalleryWidget({super.key,
    required this.womenPictures,
    required this.menPictures,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Haircuts'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Women'),
              Tab(text: 'Men'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Gallery(urlImages: womenPictures),
            Gallery(urlImages: menPictures),
          ],
        ),
      ),
    );
  }
}


class GenericScafold extends StatelessWidget {
  final List<String> urlImages;
  const GenericScafold({Key? key, required this.urlImages}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Haircuts'),

        ),
        body: Gallery(urlImages: urlImages,)
    );
  }
}



const whitecolor = Colors.white;
const blackcolor = Colors.black;
class Gallery extends StatefulWidget {

  final List<String> urlImages;
  const Gallery({Key? key, required this.urlImages}) : super(key: key);
  @override
  State<Gallery> createState() => _GalleryState();
}
class _GalleryState extends State<Gallery> {


  List<String> urlImages = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      urlImages = widget.urlImages;

    });
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width * 0.3;
    return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                  child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    /*  decoration: const BoxDecoration(
                        color: whitecolor,
                      ),*/
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          return RawMaterialButton(
                            child: SalonPhoto(size: size, imageUrl: urlImages[index],),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GalleryWidget(
                                        urlImages: urlImages,
                                        index: index,
                                      )));
                            },
                          );
                        },
                        itemCount: urlImages.length,
                      )))
            ],
          ));
  }
}