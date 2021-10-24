import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetWorkImage extends StatelessWidget {
  final double width;
  final double height;
  final String url;
  final double radius;
  final BoxFit boxFit;

  const NetWorkImage(
      {Key key, this.width, this.height, this.url, this.radius = 10, this.boxFit = BoxFit.fitWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, url) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
            image: DecorationImage(image: url, fit: boxFit ),
          ),
          width: width,
          height: height,
        );
      },
      placeholder: (context, url) => Center(
        child: Container(
          width: 30,
          height: 30,
          child: CircularProgressIndicator(),
        ),
      ),
      errorWidget: (context, url, error) => new Icon(Icons.error),
    );
  }
}
