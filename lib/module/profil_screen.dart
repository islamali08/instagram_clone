import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instgram_project/module/update_page.dart';

class profilescreen extends StatelessWidget {
  updatepage up = updatepage();
  final firestor = FirebaseFirestore.instance ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  StreamBuilder<QuerySnapshot>(
          stream:firestor.collection('profile').snapshots() ,
          builder: (context,snapshot){


            return snapshot.hasData?

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                  child: Row(


                    children: [
                      Text(snapshot.data!.docs[0]['username'],
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold

                        ),
                      ),

                      PopupMenuButton(
                          icon: Icon(Icons.expand_more,
                            color: Colors.black,
                          ),
                          itemBuilder: (context)=>[
                            PopupMenuItem(child:
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 17),
                                      child: Text('folow'),
                                    ),
                                    Spacer(),
                                    Icon(Icons.group,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                                Divider(thickness: 1,),
                                Row(
                                  children: [
                                    Text('favoret'),
                                    Spacer(),
                                    Icon(Icons.star,
                                      color: Colors.black,
                                    )
                                  ],
                                ),
                              ],
                            ))
                          ]
                      ),
                      Spacer(),
                      IconButton(onPressed: (){}, icon: Icon(Icons.add_box_outlined,
                        size: 30,
                      )),

                      IconButton(onPressed: (){}, icon: Icon(Icons.menu,
                        size: 30,
                      )),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                              radius: 45,
                              backgroundImage:snapshot.data!.docs[0]['image']!=null? Image.network(

                                snapshot.data!.docs[0]['image'],

                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                                  return Text('Your error widget...');
                                },

                              ).image:
                              NetworkImage('https://img.freepik.com/premium-photo/young-handsome-man-with-beard-isolated-keeping-arms-crossed-frontal-position_1368-132662.jpg?w=2000')),
                          SizedBox(height: 5,),

                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('10',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10,),

                          Text('Posts',
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 20
                            ),
                          ),

                        ],),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('50',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10,),

                          Text('Followers',
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 20
                            ),
                          )

                        ],),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('70',
                            style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 10,),

                          Text('Follow',
                            style: TextStyle(
                                color: Colors.black38,
                                fontSize: 20
                            ),
                          )

                        ],)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9),
                  child: Text(snapshot.data!.docs[0]['name'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9),
                  child: Text(snapshot.data!.docs[0]['pio'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context){
                            return updatepage();
                          }));
                    },
                    child: Container(
                      child: Center(child: Text('update profile',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),
                      )),
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10)

                      ),
                    ),
                  ),
                ),
              ],
            ):snapshot.hasError?Text('eror'):CircularProgressIndicator();

          },
        )



    );
  }
}
