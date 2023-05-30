import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maze/maze.dart';

class MazeRunner extends StatefulWidget {
  const MazeRunner({Key? key}) : super(key: key);

  @override
  State<MazeRunner> createState() => _MazeRunnerState();
}

class _MazeRunnerState extends State<MazeRunner> {
  createAlertDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text(
              'Winner Winner! Chicken Dinner!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),
            content: Container(
              child: Lottie.network(
                  'https://assets3.lottiefiles.com/packages/lf20_lzpnnin5.json'),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maze Runner'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SafeArea(
        child: Maze(
          player: MazeItem(
            'assets/images/ds.jpg',
            ImageType.asset,
          ),
          columns: 16,
          rows: 25,
          wallThickness: 4.0,
          wallColor: Theme.of(context).primaryColor,
          finish: MazeItem('assets/images/ds.jpg', ImageType.asset),
          onFinish: () => createAlertDialog(context),
        ),
      ),
    );
  }
}
