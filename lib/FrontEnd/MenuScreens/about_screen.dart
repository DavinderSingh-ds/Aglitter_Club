import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        child: ListView(
          shrinkWrap: true,
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 5.0, bottom: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'About ClubHouse',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 20.0, top: 10.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "A very Secure and Cool App. It provides messaging Facillity without interfering third party person or even developer team.You can play games and listen Music.Very Secure reliable and cooling features app including Fun Activities.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.black87, fontSize: 16.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 20.0, top: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Hope You Like this app',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.lightBlue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 30.0, top: 10.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Developer1 : - Davinder Singh \nBtech. IT-6th \n 1907608\nFrom :- Binjon',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 30.0, top: 10.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Developer2 : - Amandeep Singh \nBtech. IT-6th \n 1907605\nFrom :- Hoshiarpur',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.indigoAccent,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
