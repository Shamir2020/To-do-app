
import 'package:flutter/material.dart';
import 'package:task_manager_project/style/style.dart';
import 'package:task_manager_project/utility/Utility.dart';

AppBar TaskAppBar(context,ProfileData){
  return AppBar(
    backgroundColor: colorGreen,
    flexibleSpace: Container(
      margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 24,
            child: ClipOval(
              // child: Image.memory(ShowBase64Image(ProfileData['photo']))
              child: Image.asset("assets/images/User.PNG"),

            ),
          ),
          SizedBox(width: 10,),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${ProfileData['firstName']} ${ProfileData['lastName']}",style: Head6Text(colorWhite),),
              Text(ProfileData['email'],style: Head6Text(colorWhite),)
            ],
          )
        ],
      ),
    ),
    actions: [
      IconButton(onPressed: (){
        Navigator.pushNamed(context, '/taskCreate');
      }, icon: Icon(Icons.add_circle_outline)),
      IconButton(onPressed: () async{
        await RemoveToken();
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
      }, icon: Icon(Icons.output))
    ],
  );
}