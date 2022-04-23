import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_version/screens/home_screen/home_screen.dart';
import 'package:mobile_version/widgets/animated_page_route.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  final String description =
      """This is a practicing app which I decided to design and develop from scrath. For this project, I use MongoDB as database, Falcon Framework for Rest API, Next.JS for the Web version and Flutter for the Mobile and Desktop Version.""";

  @override
  Widget build(BuildContext context) {
    final bool isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage(isPortrait
                ? './assets/images/welcome2.jpg'
                : './assets/images/welcome4.jpg'),
            fit: BoxFit.fill,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
          child: Container(
            color: Colors.black.withOpacity(0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      color: Colors.black.withOpacity(0.6),
                      child: Text(
                        description,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 16,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      AnimatedPageRoute(
                        widget: const HomeScreen(),
                        alignment: Alignment.bottomCenter,
                      ),
                    ),
                    child: const Text("Enter"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).colorScheme.secondary),
                      elevation: MaterialStateProperty.all(50),
                      shadowColor: MaterialStateProperty.all(Colors.deepPurple),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                    ),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
