import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget{
   const CustomButton({
  this.child,
  this.color,
  this.borderRadius=4.0,
  this.onPressed,
 });
 @required final Widget? child;
 @required final Color? color;
 @required final double borderRadius;
 @required final VoidCallback? onPressed;
 final height=50.0;

 @override
  Widget build(BuildContext context){
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed, 
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(borderRadius)
                ),
               ),
          ),
          backgroundColor: WidgetStatePropertyAll(color),
        ),
        child: child,
        ),
    );
  }
}