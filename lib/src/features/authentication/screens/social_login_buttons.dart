import 'package:flutter/material.dart';
import 'package:mark_it/src/repository/authentication_repository/authenitication_repo.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color(0xFFE8ECF4),
              ),
            ),
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network('https://static-00.iconduck.com/assets.00/facebook-icon-512x512-seb542ju.png'),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: (){
              // AuthenticationRepository.instance.signInWithGoogle();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color(0xFFE8ECF4),
                ),
              ),
              height: 60,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network('https://static-00.iconduck.com/assets.00/google-icon-2048x2048-czn3g8x8.png'),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Color(0xFFE8ECF4),
              ),
            ),
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRDdgb7IwsMis5BNINsGjUcdAPrwZe_apikw&usqp=CAU'),
            ),
          ),
        ),
      ],
    );
  }
}
