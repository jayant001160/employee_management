import 'package:flutter/material.dart';

class EmptyPlaceholder extends StatelessWidget {
  const EmptyPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/empty.png", height: 150), // Replace with your asset
          const SizedBox(height: 20),
          const Text("No employee records found", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
