import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgram_project/shard/bloc/cubit.dart';

import '../shard/bloc/state.dart';

class addpost extends StatelessWidget {
  final firestor = FirebaseFirestore.instance ;

  TextEditingController desctption =TextEditingController();



  dynamic file ;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(


      create: (BuildContext context) =>appcubit(),


      child: BlocConsumer<appcubit,appstate>(
        listener: (BuildContext context, Object? state) {  },

        builder: (BuildContext context, state) {
          var bloce = appcubit.get(context);
          return Scaffold(
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.clear,
                        size: 30,
                      )),
                      Text('add new post',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Spacer(),
                      IconButton(onPressed: (){
                        if(bloce.imgurl.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('please uplode image')));
                        }

                        bloce.add(desctption,bloce. imgurl);
                        Navigator.pop(context);
                      }, icon: Icon(Icons.done,
                        size: 30,
                      )),

                    ],
                  ),

                ),
                SizedBox(height: 15,),

                Container(
                  height: 100,
                  width: 100,
                  child:Image(
                    image:bloce.imgurl.isNotEmpty? NetworkImage(bloce.imgurl): NetworkImage('https://img.freepik.com/free-photo/portrait-successful-man-having-stubble-posing-with-broad-smile-keeping-arms-folded_171337-1267.jpg?w=2000'),

                  ),



                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child:   TextFormField(
                    controller: desctption,
                    decoration: InputDecoration(

                        hintText: 'add discription'

                    ),

                  ),
                ),

                ElevatedButton(onPressed: () async {
                  bloce.picimage();

                }, child: Text('add picture'))
              ],
            ),
          ) ;
        },
      ),
    );
  }

}

