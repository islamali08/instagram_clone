import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../module/first_screen.dart';
import '../module/profil_screen.dart';
import '../module/search.dart';
import '../module/shop_screen.dart';
import 'dart:io';

import '../shard/bloc/cubit.dart';
import '../shard/bloc/state.dart';


class homescreen extends StatelessWidget {




  @override
  Widget build(BuildContext context) {



    return BlocProvider(

      create: (BuildContext context) =>appcubit(),

      child: BlocConsumer<appcubit,appstate>(
        listener: (context,state){},
        builder: (context,state){
          var cubet = appcubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body:cubet. screens.elementAt(cubet.selectindex) ,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex:cubet. selectindex,
              backgroundColor: Colors.white,
              onTap:cubet. ontap,
              selectedItemColor: Colors.black87,
              type: BottomNavigationBarType.fixed,


              items: [
                BottomNavigationBarItem(

                  label: '',
                  icon: CircleAvatar(
                      radius: 17,
                      backgroundImage:
                      NetworkImage('https://media.gettyimages.com/photos/cheerful-fashionable-adult-man-in-city-setting-picture-id1310533180?s=612x612')

                  ),
                ),




                BottomNavigationBarItem(
                    label: '',
                    icon: Icon(Icons.shopping_bag_outlined,
                      color: Colors.black,
                      size: 30,
                    )),
                BottomNavigationBarItem(

                  label: '',
                  icon: Icon(Icons.smart_display_outlined,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
                BottomNavigationBarItem(
                    label: '',
                    icon: Icon(Icons.search_rounded,
                      color: Colors.black,
                      size: 30,
                    )),
                BottomNavigationBarItem(
                    label: '',
                    icon: Icon(Icons.home,
                      color: Colors.black,
                      size: 30,
                    )),
              ],

            ),
          ) ;
        },
      ),
    );
  }


}








