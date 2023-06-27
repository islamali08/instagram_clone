import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../layout/home_sceen.dart';

class spalsh extends StatefulWidget {
  const spalsh({Key? key}) : super(key: key);

  @override
  State<spalsh> createState() => _spalshState();
}

class _spalshState extends State<spalsh> {
  navigat(){
    Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return homescreen();
        })
    );
  }
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), navigat);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          height: 100,
          image: AssetImage('assets/md_5b321ca31d522__1_-removebg-preview.png',

          ),
        ),
      ),
    );
  }
}
