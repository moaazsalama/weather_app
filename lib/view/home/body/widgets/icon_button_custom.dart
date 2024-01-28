

import 'package:flutter/material.dart';

class IconButtonCustom extends StatelessWidget {
  final Function()? onTap;
  final Widget? child;
  final double? width, height;
  const IconButtonCustom({
    Key? key,
    
    this.onTap,
    this.child,
     this.height,
     this.width,
  }) : super(key: key);

  // final WeatherBloc _weatherBloc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? 35,
        height: height ?? 35,
        decoration: ShapeDecoration(
          color: Colors.white.withOpacity(0.30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        child: child,
      ),
    );
  }
}
