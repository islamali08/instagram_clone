import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgram_project/model/story_model.dart';
import 'package:instgram_project/module/search.dart';
import 'package:instgram_project/module/try.dart';
import 'package:instgram_project/shard/bloc/cubit.dart';
import 'package:like_button/like_button.dart';
import 'dart:io';

import '../model/post_model.dart';
import '../shard/bloc/state.dart';
import 'add_post.dart';

class firstscreen extends StatelessWidget {






  bool showArrow = false;


  ScrollController _controller = new ScrollController();

  late final data;








  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit,appstate>(

      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var bloce = appcubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: Row(
                  children: [
                    Text(
                      'Instagram',
                      style: TextStyle(
                          fontSize: 40,
                          color: Colors.black,
                          fontFamily: 'Billabong'),
                    ),
                    PopupMenuButton(
                        icon: Icon(
                          Icons.expand_more,
                          color: Colors.black,
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 17),
                                        child: Text('follow'),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.group,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                  Divider(
                                    thickness: 1,
                                  ),
                                  Row(
                                    children: [
                                      Text('favoret'),
                                      Spacer(),
                                      Icon(
                                        Icons.star,
                                        color: Colors.black,
                                      )
                                    ],
                                  ),
                                ],
                              ))
                        ])
                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: ()  {







                      bloce.navig(context);
                      },
                      icon: Icon(
                        Icons.add_box_outlined,
                        color: Colors.black,
                        size: 30,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        size: 30,
                        color: Colors.black,
                      )),
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.maps_ugc_outlined,
                        size: 30,
                        color: Colors.black,
                      ))
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: bloce.firestor.collection('story').snapshots(),
                        builder: (context, snapshot) {
                          return snapshot.hasData
                              ? ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        child: CircleAvatar(
                                          radius: 32,
                                          backgroundColor: Colors.white,
                                          child: CircleAvatar(
                                            radius: 29,
                                            backgroundImage: NetworkImage(
                                                '${snapshot.data!.docs[index]['url']}'),
                                          ),
                                        ),
                                        radius: 35,
                                        backgroundImage: NetworkImage(
                                            'https://upload.wikimedia.org/wikipedia/commons/thumb/5/51/Color_circle_%28hue-sat%29.png/310px-Color_circle_%28hue-sat%29.png'),
                                      ),
                                      SizedBox(height: 2),
                                      Text(snapshot.data!.docs[index]['name'])
                                    ],
                                  ),
                                );
                              })
                              : snapshot.hasError
                              ? Center(child: Text('Eror'))
                              : CircularProgressIndicator.adaptive();
                        },
                      ),
                      height: 110,
                    ),
                    Divider(),
                    StreamBuilder<QuerySnapshot>(
                      stream: bloce.firestor.collection('post').snapshots(),
                      builder: (context, snapshot) {
                        return snapshot.hasData
                            ? ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            controller: _controller,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentsnapshot =
                              snapshot.data!.docs[index];

                              return Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 7,
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                snapshot.data!.docs[index]
                                                ['ppic']),
                                            radius: 23,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                snapshot.data!.docs[index]
                                                ['name'],
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.w500),
                                              ),
                                              SizedBox(height: 1),
                                              Text(
                                                snapshot.data!.docs[index]
                                                ['cty'],
                                                style: TextStyle(
                                                    color: Colors.black54),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.more_vert))
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    GestureDetector(
                                      child: Stack(children: [
                                        Container(

                                          child: Image(

                                            image: NetworkImage(

                                              snapshot
                                                  .data!
                                                  .docs[index]['pic'],
                                            ),
                                            fit: BoxFit.fill,
                                          ),
                                          width: double.infinity,
                                          height: 260,
                                        ),

                                        Positioned(
                                          child: snapshot.data!.docs[index]
                                          ['chec2'] ==
                                              false
                                              ? Icon(
                                            Icons.favorite_outlined,
                                            color: Colors.red,
                                            size: 100,
                                          )
                                              : Container(),
                                          bottom: 40,
                                          left: 120,
                                        )
                                      ]),
                                      onDoubleTap: () {


                                        if(snapshot.data!.docs[index]['chec']==false){
                                          bloce.update(snapshot, index);
                                        }





                                        bloce.update2(snapshot, index);

                                        // Anything else you want

                                      },
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.bookmark_border)),
                                        Spacer(),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.send)),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.mode_comment_outlined,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              print(
                                                  '${snapshot.data!.docs[index]['chec']} 1');
                                              if (snapshot.data!.docs[index]
                                              ['chec'] ==
                                                  false) {
                                                bloce. firestor
                                                    .collection('post')
                                                    .doc(snapshot
                                                    .data!.docs[index].id)
                                                    .update({'chec': true});
                                              }

                                              print(
                                                  '${snapshot.data!.docs[index]['chec']} 1');

                                              print(
                                                  '${snapshot.data!.docs[index]['chec']} 1');
                                              if (snapshot.data!.docs[index]
                                              ['chec'] ==
                                                  true) {
                                                bloce. firestor
                                                    .collection('post')
                                                    .doc(snapshot
                                                    .data!.docs[index].id)
                                                    .update({'chec': false});
                                              }
                                            },
                                            icon: snapshot.data!.docs[index]
                                            ['chec'] ==
                                                false
                                                ? Icon(Icons.favorite_outline)
                                                : Icon(
                                              Icons.favorite_outlined,
                                              color: Colors.red,
                                            ))
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7, bottom: 3),
                                      child: Text(
                                        '5 Likes',
                                        style: TextStyle(
                                            fontSize: 15.5,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7, bottom: 3),
                                      child: Row(
                                        children: [
                                          Text(
                                            '${snapshot.data!.docs[index]['name']}',
                                            style: TextStyle(
                                                fontSize: 15.5,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            snapshot.data!.docs[index]['com'],
                                            style: TextStyle(fontSize: 15),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 7),
                                      child: GestureDetector(
                                        child: Text(
                                          'view all 7 coment',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black45),
                                        ),
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                                    return scondscreen(
                                                        documentsnapshot);
                                                  }));
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 7, top: 9),
                                      child: Text(
                                        '1 Day Ago',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black45),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            })
                            : snapshot.hasError
                            ? Center(child: Text('Eror'))
                            : CircularProgressIndicator.adaptive();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ) ;
      },
    );
  }
}

