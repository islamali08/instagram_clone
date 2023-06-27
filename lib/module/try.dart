import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class scondscreen extends StatefulWidget {
  final DocumentSnapshot snapshot ;

  scondscreen(this.snapshot);

  @override
  State<scondscreen> createState() => _scondscreenState();
}

class _scondscreenState extends State<scondscreen> {
  final firestor = FirebaseFirestore.instance ;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:  Column(

        children: [

                   Padding(
                     padding: const EdgeInsets.only(left: 10,top: 30),
                     child: Column(
                       children: [
                         Row(
                           children: [
                             IconButton(onPressed: (){
                               Navigator.pop(context);
                             }, icon: Icon(Icons.arrow_back)),
                             SizedBox(width: 10,),
                             Text('comment',
                               style: TextStyle(
                                 fontSize: 20,
                                 fontWeight: FontWeight.bold
                               ),
                             )
                           ],
                         )
                       ],
                     ),
                   ),
          Expanded(
            child: Container(
              
    child: CommentBox(

    userImage:
    widget.snapshot['ppic'],
            child: commentChild( firestor.collection('post').snapshots()),
            labelText: 'Write a comment...',

            withBorder: false,
            errorText: 'Comment cannot be blank',
            sendButtonMethod: () {
              if (formKey.currentState!.validate()) {
                print(commentController.text);
                setState(() {
                  firestor.collection('coment').add({
                    'coment':commentController.text,
                    'image':widget.snapshot['ppic'],
                    'name':widget.snapshot['name'],
                  });
                });
                commentController.clear();
              } else {
                print("Not validated");
              }
            },
            formKey: formKey,
            commentController: commentController,
            backgroundColor: Colors.white12,
            textColor: Colors.black,
            sendWidget: Text('send',
              style: TextStyle(
                color: Colors.black38

              ),
            ),
    ),
    ),
          ),
        ],
      ),
     
      backgroundColor: Colors.white,
    );
  }
  Widget commentChild(data) {


    return  StreamBuilder<QuerySnapshot>(
      stream: firestor.collection('coment').snapshots(),
      builder: (context,snapshot){
        return snapshot.hasData?

        ListView.builder(

            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount:snapshot.data!.docs.length ,
            itemBuilder: (context,index){

              return  Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage:
                      NetworkImage(snapshot.data!.docs[index]['image']),
                    ),
                    SizedBox(width: 5,),
                    Flexible(
                      child: Container(
                        height: 30,
                        child: Text('${snapshot.data!.docs[index]['name']}  ${snapshot.data!.docs[index]['coment']}',
                          overflow: TextOverflow.visible,


                        ),
                      ),
                    )

                  ],
                ),
              );
            }
        ) : snapshot.hasError?
        Center(child: Text('Eror')):
        CircularProgressIndicator.adaptive();
      },
    );

  }

}
