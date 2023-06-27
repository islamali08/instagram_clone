
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instgram_project/shard/bloc/state.dart';

import '../../module/add_post.dart';
import '../../module/first_screen.dart';
import '../../module/profil_screen.dart';
import '../../module/search.dart';
import '../../module/shop_screen.dart';

class appcubit extends Cubit<appstate>{

appcubit() : super(inshialstate());
static appcubit  get(context)=> BlocProvider.of(context);

int selectindex =4;
void ontap(int index){
    selectindex=index;
    emit(botomnb());
}

List<Widget> screens =[
  profilescreen(),


  shopscreen(),
  Center(child: Text('vidio')),
  seearch(),
  firstscreen(),
];

final firestor = FirebaseFirestore.instance;

 update(var snapshot,int index){

   firestor
       .collection('post')
       .doc(snapshot
       .data!.docs[index].id)
       .update({'chec': true});


   emit(like());

 }


 update2(var snapshot ,int index){

   firestor
       .collection('post')
       .doc(
       snapshot.data!.docs[index].id)
       .update({'chec2': false});
   Future.delayed(Duration(seconds: 2),
           () {
           firestor
               .collection('post')
               .doc(snapshot
               .data!.docs[index].id)
               .update({'chec2': true});
       });

   emit(hard());
 }


 add(var desctption,var imgurl ){

   firestor.collection('post').add(
       {
         'com': desctption.text,
         'pic':imgurl,
         'name':'islam',
         'chec':false,
         'ppic':'https://images.unsplash.com/photo-1600804889194-e6fbf08ddb39?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8aGFuZHNvbWUlMjBtYW58ZW58MHx8MHx8&w=1000&q=80',
         'cty':'egypt',
         'chec': false,
         'chec2':true
       }

   );

   emit(addw());
 }

 navig(var context){

   Navigator.push(context, MaterialPageRoute(builder: (context){

     return addpost();
   }));

   emit(nav());
 }

String imgurl ='';

 picimage()  async {

   ImagePicker imagepicker = ImagePicker();
   XFile? file = await imagepicker.pickImage(source: ImageSource.gallery)  ;

   print('${file!.path}');
   if(file.path==null) return ;

   String unicfilename = DateTime.now().millisecondsSinceEpoch.toString();

   Reference referncrroot = FirebaseStorage.instance.ref();
   Reference  refrancedirimage = referncrroot.child('images');
   Reference refranceimagetouplod =refrancedirimage.child(unicfilename);
   emit(uplod());
   try{
     await  refranceimagetouplod.putFile(File(file.path));

     imgurl=await refranceimagetouplod.getDownloadURL() ;
       imgurl ;
       emit(imagepic());
       print(imgurl);
   }catch (eror){

   }
 }

int pa =1;
one1(){

  pa=1 ;
  emit(one());
}
two1(){

  pa=0 ;
  emit(two());
}
String va ='';

onc(valu){
va=valu ;
emit(serch());
}

String imgurl2 ='';
picimage2()  async {

  ImagePicker imagepicker = ImagePicker();
  XFile? file = await imagepicker.pickImage(source: ImageSource.gallery)  ;

  print('${file!.path}');
  if(file.path==null) return ;

  String unicfilename = DateTime.now().millisecondsSinceEpoch.toString();

  Reference referncrroot = FirebaseStorage.instance.ref();
  Reference  refrancedirimage = referncrroot.child('images');
  Reference refranceimagetouplod =refrancedirimage.child(unicfilename);
  emit(uplod());
  try{
    await  refranceimagetouplod.putFile(File(file.path));

    imgurl2=await refranceimagetouplod.getDownloadURL() ;
    imgurl2 ;
    emit(imagepic());
    print(imgurl2);
  }catch (eror){

  }
}


int pag =0;
inc1(){
  pag=1;
  emit(inc());

}



inv2(){
  pag=2;
  emit(inc());

}
inc3(){
  pag=3 ;
  emit(inc());

}


inzer(){
  pag=0;
  emit(inc());

}
}