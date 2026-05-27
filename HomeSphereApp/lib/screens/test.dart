import 'package:flutter/material.dart';

class PronunciationTrainer extends StatefulWidget {
  const PronunciationTrainer({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ScreenState createState() => _ScreenState();
}

class _ScreenState extends State<PronunciationTrainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(16), child: SizedBox(height: 12)),
    );
  }
}
