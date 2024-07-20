import 'package:flutter/material.dart';
import 'package:myapp/app/sign_in/sign_in_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title:const Text('Time Tracker'),
        backgroundColor: Colors.indigo,
        elevation: 100.0,
      ),
      body:_buildContent(), 
      backgroundColor: Colors.grey[200],
    );
  }
}

Widget _buildContent(){
  return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 48.0,),
             SignInButton(
                text: 'Sign in with Google',
                color: Colors.white,
                textcolor: Colors.black87,
                onPressed: (){},
                ), 
            const SizedBox(height: 8.0,),
             SignInButton(
                text: 'Sign in with Facebook',
                color: const Color(0xFF334D92),
                textcolor: Colors.white,
                onPressed: (){},
                ),
            const SizedBox(height: 8.0,),
             SignInButton(
                text: 'Sign in with email',
                color: Colors.teal[700],
                textcolor: Colors.white,
                onPressed: (){},
                ),
             const SizedBox(height: 8.0,),
             const Text(
              'or',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
             ),
             const SizedBox(height: 8.0,),
             SignInButton(
                text: 'Go Anonymous',
                color: Colors.lime[300],
                textcolor: Colors.black,
                onPressed: (){},
                ),
          ],
        ),
      );
}