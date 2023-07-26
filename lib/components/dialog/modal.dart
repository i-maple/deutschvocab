import 'package:deutschvocab/services/text_to_speech.dart';
import 'package:flutter/material.dart';

class Modal extends StatelessWidget {
  final String title;
  final String message;
  final Function()? onConfirm;
  final Function()? onCancel;

  const Modal({
    super.key,
    required this.title,
    required this.message,
    this.onConfirm,
    this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(message),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onCancel != null)
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if (onCancel != null) onCancel!();
                    },
                    child: Text('Cancel'),
                  ),
                if (onConfirm != null)
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if (onConfirm != null) onConfirm!();
                    },
                    child: Text('Confirm'),
                  ),
              ],
            ),
            IconButton(
                onPressed: () {
                  TextToSpeech _tts = TextToSpeech();
                  _tts.speak(message, TextToSpeech.languages['german']);
                },
                icon: Icon(Icons.speaker))
          ],
        ),
      ),
    );
  }
}
