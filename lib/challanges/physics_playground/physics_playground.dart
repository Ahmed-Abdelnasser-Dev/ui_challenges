import 'package:flutter/material.dart';

class PhysicsPlayground extends StatefulWidget {
  const PhysicsPlayground({super.key});

  @override
  State<PhysicsPlayground> createState() => _PhysicsPlaygroundState();
}

class _PhysicsPlaygroundState extends State<PhysicsPlayground> {
  final List<Color> colors = [Colors.blue, Colors.red, Colors.green];
  final double boxsideWidth = 4;
  final size = 40.0;
  late List<bool> isDropped;

  @override
  void initState() {
    super.initState();
    isDropped = List<bool>.filled(colors.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Physics Playground"),
        elevation: 2,
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // filled color circles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (var color in colors)
                Draggable<Color>(
                  data: color,
                  feedback: Container(
                     width: size * 1.4,
                    height: size * 1.4,
                    decoration: BoxDecoration(
                      boxShadow:  [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),

                  childWhenDragging: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.3),
                      shape: BoxShape.circle,
                      
                    ),
                    
                  ),

                  child: Container(
                    width: size,
                    height: size,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),

          // bordered squares
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(colors.length, (index) {
              final color = colors[index];
              return DragTarget<Color>(
                builder: (context, candidateData, __) {

                  return Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: color, width: boxsideWidth),
                      borderRadius: BorderRadius.circular(8),
                      color: isDropped[index] ? color : color.withOpacity(0.3),
                    ),
                    child: Center(
                      child: isDropped[index]
                          ? Icon(Icons.check, color: Colors.white, size: 32)
                          : Icon( Icons.arrow_downward, color: candidateData.isNotEmpty ?  Colors.white : Colors.transparent, size: 32)
                    )
                  );
                },

                // when the draggable is hovering over the target
                
                
                // When draggable is dropped correctly
                onAccept: (receivedColor) {
                  if (receivedColor == color) {
                    setState(() {
                      isDropped[index] = true;
                    });
                  }
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
