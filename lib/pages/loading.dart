import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}



class _LoadingState extends State<Loading> {

  void setWorldTime() async{

    WorldTime instance = WorldTime(location: "Seoul", flag: 'https://flagsapi.com/BE/flat/64.png', url:"Asia/Seoul");
    await instance.getData();

    Navigator.pushReplacementNamed(context, '/home', arguments: {
      "location": instance.location,
      "flag": instance.flag,
      "time": instance.time,
      "isDaytime": instance.isDaytime,
    });

    // setState(() {
    //   time = instance.time;
    // });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setWorldTime();
    // getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: const Center(
        child: SpinKitSpinningLines(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
