import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/restapi/RestClient.dart';
import 'package:task_manager_project/style/style.dart';

class registrationScreen extends StatefulWidget {
  const registrationScreen({Key? key}) : super(key: key);

  @override
  State<registrationScreen> createState() => _registrationScreenState();
}

class _registrationScreenState extends State<registrationScreen> {
  Map<String,String> FormValues = {"email":"","firstName":"","lastName":"","mobile":"","password":"","photo":"","cpassword":""};
  bool loading = false;

  InputOnChange(MapKey,TextValue){
    setState(() {
      FormValues.update(MapKey, (value) => TextValue);
    });

  }

  FormOnSubmit() async{
    if (FormValues['email'] == ""){
      ErrorToast("Email required!");
    }
    else if (FormValues['firstName']==""){
      ErrorToast("First Name required!");
    }
    else if (FormValues['lastName']==""){
      ErrorToast("Last Name required!");
    }
    else if (FormValues['mobile']==""){
      ErrorToast("Mobile required!");
    }
    else if (FormValues['password']!=FormValues['cpassword']){
      ErrorToast("Password do not match!");
    }
    else if (FormValues['photo']==""){
      ErrorToast("Photo required!");
    }
    else{
      setState(() {
        loading = true;
      });
      bool res = await RegistrationRequest(FormValues);
      if (res == true){
        Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
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
      body: Stack(
        children: [
          ScreenBackground(context),
          SingleChildScrollView(
            child: loading?(Center(child: CircularProgressIndicator(),)):(
                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Join With Us",style: Head1Text(colorDarkBlue),),
                      SizedBox(height: 1,),
                      Text("Learn with Rabbil Hasan",style: Head6Text(colorLightGrey),),
                      SizedBox(height: 20,),
                      TextFormField(decoration: AppInputDecoration("Email Address"),
                        onChanged: (value){
                          InputOnChange("email", value);
                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(decoration: AppInputDecoration("First Name"),
                        onChanged: (value){
                          InputOnChange("firstName", value);
                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(decoration: AppInputDecoration("Last Name"),
                        onChanged: (value){
                          InputOnChange("lastName", value);
                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(decoration: AppInputDecoration("Mobile"),
                        onChanged: (value){
                          InputOnChange("mobile", value);
                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(decoration: AppInputDecoration("Photo"),
                        onChanged: (value){
                          InputOnChange("photo", value);
                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(decoration: AppInputDecoration("Password"),
                        onChanged: (value){
                          InputOnChange("password", value);
                        },
                      ),
                      SizedBox(height: 20,),
                      TextFormField(decoration: AppInputDecoration("Confirm Password"),
                        onChanged: (value){
                          InputOnChange("cpassword", value);
                        },
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: ElevatedButton(
                          style: AppButtonStyle(),
                          child: SuccessButtonChild("Register"),
                          onPressed: (){
                            FormOnSubmit();
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already Have an account?",style: Head6Text(colorDarkBlue),),
                          SizedBox(width: 10,),
                          InkWell(
                            onTap: (){
                              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
                            },
                            child: Text("Sign In",style: Head6Text(colorGreen),),
                          )
                        ],
                      )


                    ],
                  ),
                )
            ),
          )
        ],
      ),
    );
  }
}
