import 'package:flutter/cupertino.dart';
import 'package:rock_paper_scissors_game/utils/game_object.dart';
import '../utils/isOffsetInsideWidget.dart';
import 'game_object_widget.dart';

class DraggableObject extends StatefulWidget {
  final GameObject object;
  final Function(GameObject) onDrop;
  final GlobalKey expandedContainerKey;// Use BuildContext here
  DraggableObject({required this.object, required this.onDrop,required this.expandedContainerKey});

  @override
  _DraggableObjectState createState() => _DraggableObjectState();
}

class _DraggableObjectState extends State<DraggableObject> {
  bool isDragged = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<GameObject>(
      onAccept: (draggedObject) {
        setState(() {
          isDragged = false;
        });

      },
      builder: (context, candidateData, rejectedData) {
        return Draggable(
          data: widget.object,
          feedback:  GameObjectWidget(widget.object),
          childWhenDragging: Container(),
          onDraggableCanceled: (velocity, offset) {
            if (isOffsetInsideWidget(widget.expandedContainerKey, offset)) {
              widget.object.x = offset.dx;
              widget.object.y = offset.dy;
              widget.onDrop(widget.object);
            }
          },

          child: isDragged
              ? Container()
              : GameObjectWidget(widget.object),
        );
      },
    );
  }
}