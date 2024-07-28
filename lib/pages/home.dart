import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final routeData = ModalRoute.of(context);
    if (data.isEmpty){
      if (routeData != null) {
        final args = routeData.settings.arguments;
        if (args != null && args is Map<String, dynamic>) {
          print("Received data in Home: $args");
          setState(() {
            data = args;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Set the background
    String bgImage = data['isDaytime'] == true ? 'day.jpg' : 'night.jpg';
    Color bgColor = data['isDaytime'] == true ? Colors.blue[600]! : Colors.indigo[900]!;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    final result = await Navigator.pushNamed(context, '/location') as Map<String, dynamic>?;
                    if (result != null) {
                      print("Received result from ChooseLocation: $result");
                      setState(() {
                        data = {
                          'time': result['time'] ?? 'Unknown',
                          'flag': result['flag'] ?? 'Unknown',
                          'location': result['location'] ?? 'Unknown',
                          'isDaytime': result['isDaytime'] ?? false,
                        };
                      });
                    }
                  },
                  icon: const Icon(Icons.edit_location),
                  label: const Text("Edit Location"),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'] ?? 'Location not set',
                      style: const TextStyle(
                        fontSize: 28,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  data['time'] ?? 'Time not set',
                  style: const TextStyle(
                    fontSize: 66,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
