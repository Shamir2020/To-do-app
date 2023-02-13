import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/restapi/RestClient.dart';
import 'package:task_manager_project/style/style.dart';

class taskCreateScreen extends StatefulWidget {
  const taskCreateScreen({Key? key}) : super(key: key);

  @override
  State<taskCreateScreen> createState() => _taskCreateScreenState();
}

class _taskCreateScreenState extends State<taskCreateScreen> {
  Map<String,String> FormValues = {"title":"","description":"","status":"New"};
  bool loading = false;

  InputOnChange(MapKey,MapValue) {
    setState(() {
      FormValues.update(MapKey, (value) => MapValue);
    });

  }
  FormOnSubmit() async{
    if (FormValues['title'] == ""){
      ErrorToast("title required!");
    }
    else if (FormValues['description']==""){
      ErrorToast("Description required!");
    }
    else{
      setState(() {
        loading = true;
      });
      bool res = await TaskCreateRequest(FormValues);
      if (res == true){
        Navigator.pushNamedAndRemoveUntil(context, "/", (route) => false);
      }
      else{
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create New Task",style: Head6Text(colorDarkBlue),),
        backgroundColor: colorGreen,
      ),
      body: loading?(Center(child: CircularProgressIndicator(),)):(SingleChildScrollView(
        child: Stack(
          children: [
            ScreenBackground(context),
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add New Task",style: Head1Text(colorDarkBlue),),
                  SizedBox(height: 10,),
                  TextFormField(decoration: AppInputDecoration("Task Name"),
                    onChanged: (value){
                      InputOnChange("title", value);
                    },
                  ),
                  SizedBox(height: 20,),
                  TextFormField(decoration: AppInputDecoration("Task Description"),
                    onChanged: (value){
                      InputOnChange("description", value);
                    },
                    maxLines: 10,
                  ),
                  SizedBox(height: 20,),
                  Container(
                    child: ElevatedButton(
                      style: AppButtonStyle(),
                      child: SuccessButtonChild("Create"),
                      onPressed: (){
                        FormOnSubmit();
                      },
                    ),
                  ),




                ],
              ),
            )
          ],
        ),
      ))

    );
  }
}
