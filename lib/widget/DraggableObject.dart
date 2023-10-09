import 'package:flutter/cupertino.dart';
import 'package:rock_paper_scissors_game/GameObject.dart';

import 'GameObjectWidget.dart';

class DraggableObject extends StatefulWidget {
  final GameObject object;
  DraggableObject(this.object);

  @override
  _DraggableObjectState createState() => _DraggableObjectState();
}

class _DraggableObjectState extends State<DraggableObject> {
  @override
  Widget build(BuildContext context) {
    return Draggable(
      data: widget.object,
      feedback: Container( // Wrap with a Container
        width: 35,
        height: 35,
        child: GameObjectWidget(widget.object),
      ),
      childWhenDragging: Container(),
      child: SizedBox( // Wrap with a Container
        width: 35,
        height: 35,
        child: GameObjectWidget(widget.object),
      ),
    )
    ;
  }
}
