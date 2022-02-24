import 'package:flutter/material.dart';

/// A single draggable note widget containing some
/// text content with a post-it style decoration.
class Note extends StatelessWidget {
  /// Text content for current note
  final String content;

  const Note({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Draggable<String>(
        data: content,
        child: Container(
          child: Center(child: Text(content)),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/post-it.png"),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        feedback: Container(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/waste-paper-icon.png"),
              fit: BoxFit.scaleDown,
            ),
          ),
        ),
        childWhenDragging: SizedBox(),
      ),
    );
  }
}
