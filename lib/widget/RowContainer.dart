import 'package:flutter/material.dart';
import '../GameObject.dart';
import 'DraggableObject.dart';

class RowContainer extends StatefulWidget {
  final ObjectType objectType;
  final int itemCount;

  RowContainer({required this.objectType, this.itemCount = 5});

  @override
  _RowContainerState createState() => _RowContainerState();
}

class _RowContainerState extends State<RowContainer> {
  late List<GameObject> objects;

  @override
  void initState() {
    super.initState();
    objects = List.generate(widget.itemCount, (index) => GameObject(widget.objectType));
    print(objects.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
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
            return DraggableObject(objects[index]);
          },
        ),
      );
  }
}
