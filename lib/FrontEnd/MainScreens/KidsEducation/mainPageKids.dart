// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:google_signin/FrontEnd/MainScreens/KidsEducation/colorScheme.dart';

import 'kidshomePage.dart';

class mainPageKids extends StatefulWidget {
  const mainPageKids({Key? key}) : super(key: key);

  @override
  _mainPageKidsState createState() => _mainPageKidsState();
}

class _mainPageKidsState extends State<mainPageKids> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBlue,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  image: DecorationImage(
                      image: AssetImage('assets/images/childstudy.jpg'),
                      fit: BoxFit.cover)),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "WHERE KIDS LOVE LEARNING And Entertinment",
                    style: TextStyle(fontSize: 12, fontFamily: 'circe'),
                  ),
                  const Text(
                    "Distant Learning & Home \nSchooling Made Easy",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'circe'),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Book Filtered Top Rated Professional \nTutors from the comfort \nOf your home in just a few clicks",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'circe'),
                    textAlign: TextAlign.center,
                  ),
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 15,
                            color: Colors.black.withOpacity(0.1),
                          )),
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: darkBlue,
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const KidsHomePage()));
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
