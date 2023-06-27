

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgram_project/shard/bloc/cubit.dart';

import '../shard/bloc/state.dart';

class updatepage extends StatelessWidget {
  var imagepicker ;
  var imagepath ;
//  Future<void> pickimage () async{
// XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
// if(file !=null){
//   imagepath=file.path ;
//
//
// }
// }
  final firestor = FirebaseFirestore.instance ;
  TextEditingController name = TextEditingController();
  TextEditingController pio = TextEditingController();
  TextEditingController username = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) =>appcubit(),

      child: BlocConsumer<appcubit,appstate>(


        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          var bloce = appcubit.get(context);
          return Scaffold(
              body: StreamBuilder<QuerySnapshot>(
                stream:firestor.collection('profile').snapshots() ,
                builder: (context,snapshot){


                  return snapshot.hasData?

                  bloce.pag==0?
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: () {



                                firestor.collection('profile').doc(
                                    snapshot.data!.docs[0].id).update(
                                    {
                                      'image': bloce.imgurl2
                                    }
                                );



                              }, icon: Icon(Icons.done,
                                size: 30,
                              )),
                              Text('update profile', style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold

                              ),
                              ),
                              IconButton(onPressed: () {
                                Navigator.pop(context);
                              }, icon: Icon(Icons.clear,
                                size: 30,
                              )),


                            ],
                          ),

                        ),
                        SizedBox(height: 5,),

                        CircleAvatar(
                            radius: 45,
                            backgroundImage:snapshot.data!.docs[0]['image']!=null?
                            Image.network(

                              snapshot.data!.docs[0]['image'],

                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                                return Text('Your error widget...');
                              },

                            ).image:NetworkImage('https://media.istockphoto.com/photos/mature-beautiful-woman-with-red-hair-picture-id1221755378?k=20&m=1221755378&s=612x612&w=0&h=rZkb0wrSR4-Qfl-MIDbD8_2L_V2KYWOf0P_EqUveAAA=')


                        ),
                        SizedBox(height: 5,),
                        TextButton(
                            style: TextButton.styleFrom(

                            ),
                            onPressed: () {
                              showModalBottomSheet(context: context,
                                  builder: (context) {
                                    return SizedBox(
                                      height: 250,
                                      child: Container(
                                        width: MediaQuery
                                            .of(context)
                                            .size
                                            .width,
                                        height: MediaQuery
                                            .of(context)
                                            .size
                                            .height,

                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 23),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10, bottom: 15),
                                                child: Text('change profile picture',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18
                                                  ),
                                                ),
                                              ),

                                              Divider(
                                                thickness: 2,

                                              ),
                                              TextButton(onPressed:()  {
                                                bloce.picimage2();
                                              } , child: Text('new profile picture',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: Colors.black
                                                ),
                                              ),),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 10),
                                                child: Text('from facebook',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                              );
                            }, child: Text('update profile picture',
                          style: TextStyle(
                              fontSize: 17
                          ),
                        )),
                        GestureDetector(
                          onTap: (){
                           bloce.inc1();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),

                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('name',
                                  style: TextStyle(
                                      color: Colors.black38
                                  ),
                                ),
                                SizedBox( height: 3),
                                Text(snapshot.data!.docs[0]['name']),
                                Divider(thickness: 1.2,)
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                           bloce.inv2();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('user name',
                                  style: TextStyle(
                                      color: Colors.black38
                                  ),
                                ),
                                SizedBox( height: 3),
                                Text(snapshot.data!.docs[0]['username']),
                                Divider(thickness: 1.2,)
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                           bloce.inc3();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 3),
                            child: Container(

                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('pio',
                                    style: TextStyle(
                                        color: Colors.black38
                                    ),
                                  ),
                                  SizedBox( height: 3),
                                  Text(snapshot.data!.docs[0]['pio']),
                                  Divider(thickness: 1.2,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ):
                  bloce.pag==1?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 10),
                          child: Row(
                            children: [
                              IconButton(onPressed: (){
                               bloce.inc1();
                              }, icon: Icon(Icons.clear,
                                size: 30,
                              )),
                              Text('name',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Spacer(),
                              IconButton(onPressed: (){
                                firestor.collection('profile').doc(
                                    snapshot.data!.docs[0].id).update(
                                    {
                                      'name': name.text
                                    }
                                );
                                bloce.inzer();
                              }, icon: Icon(Icons.done,
                                size: 30,
                              )),

                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text('name',
                              style: TextStyle(
                                  color: Colors.black38
                              ),
                            ),
                            Container(
                              height: 30,
                              child: TextFormField(
                                controller: name,
                                decoration: InputDecoration(

                                    hintText: snapshot.data!.docs[0]['name']
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ):
                  bloce.pag==2?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20,),
                          child: Row(
                            children: [
                              IconButton(onPressed: (){
                               bloce.inc1();
                              }, icon: Icon(Icons.clear,
                                size: 30,
                              )),
                              Text('user name',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Spacer(),
                              IconButton(onPressed: (){
                                firestor.collection('profile').doc(
                                    snapshot.data!.docs[0].id).update(
                                    {
                                      'username': username.text
                                    }
                                );
                                bloce.inzer();
                              }, icon: Icon(Icons.done,
                                size: 30,
                              )),

                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('user name',
                                style: TextStyle(
                                    color: Colors.black38
                                ),
                              ),
                              Container(
                                height: 30,
                                child: TextFormField(
                                  controller: username,
                                  decoration: InputDecoration(

                                      hintText: snapshot.data!.docs[0]['username']
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ):
                  bloce.pag==3?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20,),
                          child: Row(
                            children: [
                              IconButton(onPressed: (){
                               bloce.inc1();
                              }, icon: Icon(Icons.clear,
                                size: 30,
                              )),
                              Text('pio',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Spacer(),
                              IconButton(onPressed: (){
                                firestor.collection('profile').doc(
                                    snapshot.data!.docs[0].id).update(
                                    {
                                      'pio': pio.text
                                    }
                                );
                                bloce.inzer();
                              }, icon: Icon(Icons.done,
                                size: 30,
                              )),

                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('pio',
                                style: TextStyle(
                                    color: Colors.black38
                                ),
                              ),
                              Container(
                                height: 30,
                                child: TextFormField(
                                  controller: pio,
                                  decoration: InputDecoration(

                                      hintText: snapshot.data!.docs[0]['pio']
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ):
                  Container()
                      :
                  snapshot.hasError?
                  Text('eror'):
                  CircularProgressIndicator();

                },
              )




          );
        },
      ),
    );
  }



}
