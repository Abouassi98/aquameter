import 'package:flutter/material.dart';

class ImageBG extends StatelessWidget {
  final String image;
  final bool network;
  final double? width, height;
  const ImageBG(
      {Key? key,
      required this.image,
      required this.network,
      this.height,
      this.width})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return network == true
        ? Image.network(
            image,
            fit: BoxFit.fill,
            height: height,
            width: width,
          )
        : Image.asset(
            image,
            fit: BoxFit.fill,
            height: height,
            width: width,
          );
  }
}
