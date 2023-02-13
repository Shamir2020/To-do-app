import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/restapi/RestClient.dart';
import 'package:task_manager_project/style/style.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  Map<String,String> FormValues = {"email":"","password":""};
  bool loading = false;

  InputOnChange(Mapkey,Mapvalue){
    setState(() {
      FormValues.update(Mapkey, (value) => Mapvalue);
    });
  }

  FormOnSubmit() async{
    //Form Validation
    if (FormValues['Email'] == ""){
      ErrorToast('Email cannot be empty!!');

    }
    else if (FormValues['password'] == ""){
      ErrorToast("password");

    }
    else{
      setState(() {
        loading = true;
      });
      bool res = await LoginRequest(FormValues);

      if (res){
        //Navigate to Dashboard Page
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }


      setState(() {
        loading = false;
      });
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Get Started With",style: Head1Text(colorDarkBlue),),
                SizedBox(height: 1,),
                Text("Learn with Rabbil Hasan",style: Head6Text(colorLightGrey),),
                SizedBox(height: 20,),
                TextFormField(decoration: AppInputDecoration("Email Address"),
                  onChanged: (value){
                  InputOnChange("email", value);
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(decoration: AppInputDecoration("Password"),
                  onChanged: (value){
                  InputOnChange("password", value);
                  },
                ),
                SizedBox(height: 20,),
                Container(
                  child: ElevatedButton(
                    style: AppButtonStyle(),
                    child: SuccessButtonChild("Login"),
                    onPressed: (){
                      FormOnSubmit();
                    },
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/emailVerification');
                        },
                        child: Text("Forget Password?",style: Head6Text(colorLightGrey),),
                      ),
                      SizedBox(height: 15,),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, '/registration');
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? ",style: Head6Text(colorDarkBlue),),
                            Text("Sign Up",style: Head6Text(colorGreen),)
                          ],
                        ),
                      )
                    ],
                  ),
                )

                
              ],
            ),
          )
        ],
      ),
    );
  }
}
