import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/roadmap_controller.dart';
import '../../models/roadmap_model.dart';

class SimpleRoadmapScreen extends StatelessWidget {
  const SimpleRoadmapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Career Roadmap'),
      ),
      body: Consumer<RoadmapController>(
        builder: (context, controller, _) {
          if (controller.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage != null) {
            return Center(
              child: Text(
                controller.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          final roadmap = controller.currentRoadmap;
          if (roadmap == null) {
            return const Center(child: Text('No roadmap data available'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: roadmap.jobs.length,
            itemBuilder: (context, index) {
              final job = roadmap.jobs[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16.0),
                child: ListTile(
                  title: Text(job.title),
                  subtitle: Text(job.description),
                  trailing: Text(job.salaryRange),
                  onTap: () => controller.selectJob(job),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
