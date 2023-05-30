import 'package:flutter/material.dart';
import 'package:google_signin/FrontEnd/GamesScreens/maze_runner.dart';
import 'package:lottie/lottie.dart';

class ImageScreen extends StatefulWidget {
  const ImageScreen({Key? key}) : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            GestureDetector(
              onTap: () => {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const MazeRunner(),
                  ),
                ),
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 6,
                  bottom: 8,
                  left: 4,
                  right: 4,
                ),
                child: Column(
                  children: [
                    Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Image.asset(
                        'assets/images/mazee.jpg',
                        fit: BoxFit.fill,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.white30,
                      ),
                      child: const Center(
                        child: Text(
                          'Maze Runner',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_lzpnnin5.json'),
          ],
        ),
      )),
    );
  }
}
