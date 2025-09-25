import 'package:flutter/material.dart';
import 'challanges/physics_playground/physics_playground.dart';
import 'challanges/squensial_loading_dot/squensial_loading_dots.dart';
import 'challanges/taskmanager/task_manager.dart';

class BaseApp extends StatelessWidget {
  const BaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UI Chanllenges"),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
          children: [
            ChallengeCard(
              title: 'Physics Playground',
              icon: Icons.science,
              color: Colors.blue,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PhysicsPlayground(),
                  ),
                );
              },
            ),
            ChallengeCard(
              title: 'Sequential Loading Dots',
              icon: Icons.more_horiz,
              color: Colors.deepPurple,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => SquensialLoadingDots(),
                  ),
                );
              },
            ),
            ChallengeCard(
              title: 'Task Manager',
              icon: Icons.check_circle_outline,
              color: Colors.green,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => TaskManager(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

 // Card widget for challenge grid
class ChallengeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const ChallengeCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Color? swatch700;
    if (color is MaterialColor) {
      swatch700 = (color as MaterialColor)[700];
    }
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: color,
              radius: 28,
              child: Icon(icon, color: Colors.white, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: swatch700 ?? color),
            ),
          ],
        ),
      ),
    );
  }
}