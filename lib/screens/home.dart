import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'camera.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'GreenSense',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 46, 104, 49),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Add your background image here
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.local_florist, size: 100, color: Colors.white),
              SizedBox(height: 20),
              Text(
                'Detect Plant Diseases',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(height: 20),
              OpenContainer(
                transitionType: ContainerTransitionType.fade,
                openBuilder: (context, _) => CameraScreen(),
                closedElevation: 0,
                closedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                closedColor: Colors.green[700]!,
                closedBuilder: (context, openContainer) => ElevatedButton.icon(
                  icon: Icon(Icons.camera_alt, color: Colors.white), // Icon color changed to white
                  label: Text('Open Camera', style: TextStyle(color: Colors.white)), // Text color changed to white
                  onPressed: openContainer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        selectedItemColor: Colors.green[700],
      ),
    );
  }
}
