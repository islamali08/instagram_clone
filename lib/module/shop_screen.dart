import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class shopscreen extends StatelessWidget {
  final firestore = FirebaseFirestore.instance ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,

            backgroundColor: Colors.white,
            title: Text('Store',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24


              ),
            ),
            actions: [
              IconButton(onPressed: (){}, icon: Icon(Icons.bookmark_border,
                color: Colors.black,
                size: 30,
              )),
              IconButton(onPressed: (){
                showModalBottomSheet(context: context,
                    builder: (context){
                      return SizedBox(
                        height: 250,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,

                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 23),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,bottom: 15),
                                  child: Text('your acount',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(onPressed: (){}, icon:Icon( Icons.notifications)),
                                    Text('shopping activity',
                                      style: TextStyle(
                                          fontSize: 17
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12,),
                                Divider(
                                  thickness:2,

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10,bottom: 15,top: 10),
                                  child: Text('instagram store',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text('vedios',
                                    style: TextStyle(
                                        fontSize: 17
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ) ;
                    }

                );
              }, icon: Icon(Icons.menu,
                color: Colors.black,
                size: 30,
              )),

            ],

          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 40,
                    child: TextFormField(

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
                        hintText: 'search for store',
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
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    child: Center(child: Text('videos',
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
                StreamBuilder<QuerySnapshot>(
                    stream: firestore.collection('store').snapshots(),
                    builder: (context,snapshot){
                      return snapshot.hasData?

                      SingleChildScrollView(
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(), // to disable GridView's scrolling

                            scrollDirection:Axis.vertical ,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.95,
                                mainAxisSpacing: 5,
                                crossAxisSpacing: 5



                            ),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context,index){
                              return Container(
                                  height: 100,

                                  child: Image(
                                      fit:BoxFit.fill ,
                                      image: NetworkImage(snapshot.data!.docs[index]['pic'])));
                            }
                        ),
                      ):
                      snapshot.hasError?
                      Center(child: Text('eror')):
                      CircularProgressIndicator();
                    }
                )

              ],
            ),
          )
        ],

      ),
    );
  }
}

