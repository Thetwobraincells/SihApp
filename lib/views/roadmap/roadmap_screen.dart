import 'package:flutter/material.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Career Roadmap'),
      ),
      body: const Center(
        child: Text('Roadmap Screen'),
      ),
    );
  }
}
