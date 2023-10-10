import 'package:flutter/material.dart';
import '../GameObject.dart';
import '../screen/GamePanel.dart';
import 'DraggableObject.dart';

class RowContainer extends StatefulWidget {
  final ObjectType objectType;
  final int itemCount;
  final Function(GameObject) onDrop;
  final Function() getGamePanelRenderBox;

  RowContainer({
    required this.objectType,
    required this.itemCount ,
    required this.onDrop,
    required this.getGamePanelRenderBox,  });

  @override
  _RowContainerState createState() => _RowContainerState();
}

class _RowContainerState extends State<RowContainer> {
  late List<GameObject> objects;

  @override
  void initState() {
    super.initState();
    objects = List.generate(
      widget.itemCount,
          (index) => GameObject(
        type: widget.objectType,
        x: 0, // Provide an initial x value
        y: 0, // Provide an initial y value
      ),
    );
    print(objects.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: objects.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              DraggableObject(
                object: objects[index],
                onDrop: (draggedObject) {
                  setState(() {
                    objects.remove(draggedObject);
                  });
                  widget.onDrop(draggedObject);
                },
                getGamePanelRenderBox: widget.getGamePanelRenderBox,
              ),
              if (index < objects.length - 1)
                const SizedBox(width: 10), // Adjust the width as needed.
            ],
          );
        },
      ),
    );
  }
}
