import 'package:flutter/material.dart';

/// Utility widget that pops up a dialog box
/// for user to enter text input
class TextboxPopupButton extends StatelessWidget {
  /// Callback function on submit of input
  final Function onTextSubmit;

  /// Controller for text field pop up
  final TextEditingController controller;

  const TextboxPopupButton({
    Key? key,
    required this.onTextSubmit,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_circle),
      iconSize: 64,
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('Add note'),
          content: TextField(controller: controller,),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                Navigator.pop(context, 'OK'),
                onTextSubmit(),
              },
              child: const Text('Add'),
            ),
          ],
        ),
      ),
    );
  }
}
