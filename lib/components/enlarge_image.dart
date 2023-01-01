import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class EnlargeImage extends StatelessWidget {
  final String? profileImg;
  const EnlargeImage({Key? key, this.profileImg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: PhotoView(
              heroAttributes: PhotoViewHeroAttributes(
                tag: profileImg!,
                transitionOnUserGestures: true,
              ),
              minScale: 0.2,
              initialScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: 5.0,
              imageProvider: MemoryImage(
                base64Decode(profileImg!),
              ),
              // loadingBuilder: (context, event) => Center(
              //   child: Container(
              //     width: 20.0,
              //     height: 20.0,
              //     child: CircularProgressIndicator(
              //       value: event == null ? 0 : event.cumulativeBytesLoaded / (event.expectedTotalBytes ?? 1),
              //     ),
              //   ),
              // ),
            ),
          ),
          Positioned(
            top: 70,
            right: 20,
            child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                )),
          )
        ],
      ),
    );
  }
}
