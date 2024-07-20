import 'package:flutter/material.dart';
import 'package:myapp/app/sign_in/custom_button.dart';

class SignInButton extends CustomButton{
  SignInButton({
    required String text,
    Color? color,
    Color? textcolor,
    VoidCallback? onPressed,
  }) : super(
    child: Text(text,
    style: TextStyle(color: textcolor,fontSize: 15.0),
    ),
    color: color,
    onPressed: onPressed,
  );
}