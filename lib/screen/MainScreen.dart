import 'package:flutter/material.dart';
import 'package:rock_paper_scissors_game/screen/GamePanel.dart';

import '../GameObject.dart';
import '../widget/RowContainer.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game'),
      ),
      body: Column(
        children: [
          RowContainer(objectType: ObjectType.Rock, itemCount: 5),
          const SizedBox(height: 5),
          RowContainer(objectType: ObjectType.Paper, itemCount: 5),
          const SizedBox(height: 5),
          RowContainer(objectType: ObjectType.Scissors, itemCount: 5),
          const SizedBox(height: 5),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
              ),
              margin: const EdgeInsets.all(10),
              child: const GamePanel(

              ),
            ),
          ),
        ],
      ),
    );
  }
}