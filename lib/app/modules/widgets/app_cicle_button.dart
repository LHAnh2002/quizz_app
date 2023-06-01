import 'package:flutter/material.dart';

class AppCicleButton extends StatelessWidget {
  const AppCicleButton(
      {Key? key, required this.child, this.color, this.width = 60, this.ontap})
      : super(key: key);
  final Widget child;
  final Color? color;
  final double width;
  final VoidCallback? ontap;
  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.hardEdge,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: ontap,
        child: child,
      ),
    );
  }
}
