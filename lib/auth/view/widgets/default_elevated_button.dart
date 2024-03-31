import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  const DefaultElevatedButton({
    required this.onPressed,
    required this.child,
    this.width,
    this.borderRadiusValue = 6,
  });

  final VoidCallback onPressed;
  final Widget child;
  final double? width;
  final double borderRadiusValue;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        fixedSize: Size(width ?? MediaQuery.of(context).size.width, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
        ),
      ),
      child: child,
    );
  }
}
