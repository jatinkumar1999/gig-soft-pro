import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gig_soft_pro/model/auth_detail.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Data>? _auth = [];


  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var box = await Hive.openBox('authDetail');

      var dataIS = await box.get('usersData');
      if (dataIS != null) {
        UserAuthModel? userModel;
        print("data is ==>$dataIS");
        ;
        userModel = UserAuthModel.fromJson(json.decode(dataIS.toString()));
        _auth = userModel.data;
        setState(() {});

        print('data is ===>>${userModel.data?.length}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(color:Colors.transparent,


      child:ListView.builder(
          itemCount: _auth?.length??0,
          itemBuilder: (context,index){
            return ListTile(
              title: Text(_auth?[index].name??"",style:TextStyle(
                fontWeight: FontWeight.w500,
              )),
              subtitle: Text(_auth?[index].pass??"",style:TextStyle(
                fontWeight: FontWeight.w300,
              )),

            );




      })
      ),

    );
  }
}
