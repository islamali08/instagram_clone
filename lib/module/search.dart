import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'dart:io';

import 'package:instgram_project/shard/bloc/cubit.dart';
import 'package:instgram_project/shard/bloc/state.dart';


class seearch extends StatelessWidget {

  final firestor = FirebaseFirestore.instance ;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<appcubit,appstate>(
      listener: (BuildContext context, Object? state) {  },


      builder: (BuildContext context, state) {
        var bloce=appcubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          body: bloce.pa==1?
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40,right: 10),
                child: Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(

                      Icons.person_add_alt_outlined,
                      size: 30,
                    )),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextFormField(

                          onTap: (){
                            bloce.two1();
                          },

                          maxLines: 1,
                          minLines: 1,
                          autofocus: false,
                          style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.black12,
                            hintStyle:TextStyle(
                                fontSize: 17
                            ) ,
                            hintText: 'search',
                            prefixIcon: Icon(Icons.search_rounded,
                              color: Colors.black,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),









                        ),
                      ),
                    )

                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: firestor.collection('post').snapshots(),
                builder: (context,snapshot){
                  return snapshot.hasData?
                  Expanded(
                    child: MasonryGridView.builder(
                        crossAxisSpacing: 2,
                        mainAxisSpacing: 2,
                        gridDelegate:SliverSimpleGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3) ,
                        itemCount: snapshot.data!.docs.length ,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context,index){
                          return snapshot.data!.docs[index]['pic'].toString().startsWith('http')? Image(image: NetworkImage(snapshot.data!.docs[index]['pic'])):Image.file(


                              File(snapshot.data!.docs[index]['pic'])) ;
                        }
                    ),
                  ) : snapshot.hasError?
                  Center(child: Text('Eror')):
                  CircularProgressIndicator.adaptive();
                },
              ),
            ],
          ):

          SingleChildScrollView(

            child: SizedBox(
              height: MediaQuery.of(context).size.height,

              child: Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40,left: 10),
                    child: Row(
                      children: [

                        Expanded(
                          child: Container(
                            height: 50,
                            child: TextFormField(
                              onChanged: bloce.onc,
                              onTap: (){
                              },

                              maxLines: 1,
                              minLines: 1,
                              autofocus: false,
                              style: TextStyle(fontSize: 22.0, color: Color(0xFFbdc6cf)),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.black12,
                                hintStyle:TextStyle(
                                    fontSize: 17
                                ) ,
                                hintText: 'search',
                                prefixIcon: Icon(Icons.search_rounded,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),









                            ),
                          ),
                        ),
                        IconButton(onPressed: (){

                          bloce.one1();

                        }, icon: Icon(

                          Icons.arrow_forward,
                          size: 30,
                        )),

                      ],
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: firestor.collection('post').snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
                      return snapshot.hasData?
                      Expanded(

                        child: ListView.builder(

                            physics: ScrollPhysics(), // to disable GridView's scrolling

                            scrollDirection:Axis.vertical ,
                            shrinkWrap: true,

                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int index) {

                              return bloce.va.isEmpty ?Container():snapshot.data!.docs[index]['name'].toString().toLowerCase().replaceAll(' ', '').contains(bloce.va.toLowerCase())?
                              ListTile(
                                subtitle:Text(snapshot.data!.docs[index]['cty']) ,
                                title: Text(snapshot.data!.docs[index]['name']),
                                leading: CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(snapshot.data!.docs[index]['ppic'])),
                              ):
                              Container();
                            }
                        ),
                      ) :
                      snapshot.hasError?Text('Eror'):Center(child: CircularProgressIndicator())  ;
                    },

                  ),
                ],
              ),
            ),
          ),
        ) ;
      },
    );
  }
}
