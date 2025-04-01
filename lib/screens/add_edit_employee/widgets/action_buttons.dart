import 'package:flutter/material.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const ActionButtons({super.key, required this.onCancel, required this.onSave});

  @override
  Widget build(BuildContext context) {
    final buttonHeight = 44.0;
    final borderRadius = BorderRadius.circular(8);
    final blueColor = const Color(0xff1da1f2);

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            style: OutlinedButton.styleFrom(
              foregroundColor: blueColor,
              side: BorderSide(color: blueColor),
              minimumSize: Size(0, buttonHeight),
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
            ),
            child: const Text('Cancel'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: blueColor,
              foregroundColor: Colors.white,
              minimumSize: Size(0, buttonHeight),
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
            ),
            child: const Text('Save'),
          ),
        ),
      ],
    );
  }
}
