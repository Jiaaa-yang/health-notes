import 'package:flutter/material.dart';

/// Trash can serving as a drag target
/// for disposal of notes
class TrashCan extends StatelessWidget {
  final Function onAccept;

  const TrashCan({Key? key, required this.onAccept}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget<String>(
      builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
          ) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bin.png"),
              fit: BoxFit.scaleDown,
            ),
          ),
          height: 100.0,
          width: 100.0,
        );
      },
      onAccept: (String data) {
        onAccept(data);
      },
    );
  }
}
