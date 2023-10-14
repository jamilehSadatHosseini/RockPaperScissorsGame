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

  @override
  Widget build(BuildContext context) {

        return Draggable(
          data: widget.object,
          feedback:  GameObjectWidget(widget.object),
          childWhenDragging: Container(),
            onDragStarted: () {
              print('Drag started');
            },
          onDragEnd: (details) {
            if (isOffsetInsideWidget(widget.expandedContainerKey, details.offset)) {
              widget.object.x = details.offset.dx;
              widget.object.y = details.offset.dy;
              widget.onDrop(widget.object);
            }
          },

          child: GameObjectWidget(widget.object)
              // : ,
        );
  }
}