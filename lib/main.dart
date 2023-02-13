import 'package:flutter/material.dart';
import 'package:task_manager_project/screen/emailVerificationScreen.dart';
import 'package:task_manager_project/screen/loginScreen.dart';
import 'package:task_manager_project/screen/newTaskList.dart';
import 'package:task_manager_project/screen/pinVerificationScreen.dart';
import 'package:task_manager_project/screen/registrationScreen.dart';
import 'package:task_manager_project/screen/setPasswordScreen.dart';
import 'package:task_manager_project/screen/homeScreen.dart';
import 'package:task_manager_project/screen/splashScreen.dart';
import 'package:task_manager_project/screen/taskCreateScreen.dart';
import 'package:task_manager_project/utility/Utility.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await ReadUserData('token');

  if (token!= null){
    runApp(TaskManager("/"));
  }
  else{
    runApp(TaskManager('/login'));
  }

}

class TaskManager extends StatelessWidget {
  final String firstRoute;
  const TaskManager(this.firstRoute,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Task Manager",
      initialRoute: firstRoute,
      routes: {
        '/':(context)=> HomeScreen(),
        '/login':(context)=> loginScreen(),
        '/registration':(context)=>registrationScreen(),
        '/emailVerification':(context)=>emailVerificationScreen(),
        '/pinVerification':(context)=>pinVerificationScreen(),
        '/setPassword':(context)=>setPasswordScreen(),
        '/taskCreate':(context)=> taskCreateScreen()


      },
    );
  }
}

