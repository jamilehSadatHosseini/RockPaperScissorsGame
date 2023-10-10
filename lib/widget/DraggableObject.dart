import 'package:flutter/cupertino.dart';
import 'package:rock_paper_scissors_game/GameObject.dart';
import 'GameObjectWidget.dart';

class DraggableObject extends StatefulWidget {
  final GameObject object;
  final Function(GameObject) onDrop;
  final Function() getGamePanelRenderBox;// Use BuildContext here
  DraggableObject({required this.object, required this.onDrop,required this.getGamePanelRenderBox});

  @override
  _DraggableObjectState createState() => _DraggableObjectState();
}

class _DraggableObjectState extends State<DraggableObject> {
  bool isDragged = false;

  @override
  Widget build(BuildContext context) {
    return DragTarget<GameObject>(
      onAccept: (draggedObject) {
        print("Drag onAccept");
        setState(() {
          print("Drag onAccept setState");
          isDragged = false;
        });

      },
      builder: (context, candidateData, rejectedData) {
        return Draggable(
          data: widget.object,
          feedback: SizedBox(
            width: 35,
            height: 35,
            child: GameObjectWidget(widget.object),
          ),
          childWhenDragging: Container(),
          onDraggableCanceled: (velocity, offset) {
            print("Drag Canceled");
            final renderBox = widget.getGamePanelRenderBox.call(); // از تابع استفاده شده در prop getGamePanelRenderBox
            if (renderBox != null) {
              Offset dropPosition = renderBox.globalToLocal(offset);
              if (renderBox.paintBounds.contains(dropPosition)) {
                // شیء در داخل پنل بازی قرار گرفته است
                widget.onDrop(widget.object);
              }
            }
          },
          child: isDragged
              ? Container()
              : SizedBox(
            width: 35,
            height: 35,
            child: GameObjectWidget(widget.object),
          ),
        );
      },
    );
  }
}