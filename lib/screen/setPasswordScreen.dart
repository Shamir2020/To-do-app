import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/restapi/RestClient.dart';
import 'package:task_manager_project/utility/Utility.dart';

import '../style/style.dart';

class setPasswordScreen extends StatefulWidget {
  const setPasswordScreen({Key? key}) : super(key: key);

  @override
  State<setPasswordScreen> createState() => _setPasswordScreenState();
}

class _setPasswordScreenState extends State<setPasswordScreen> {

  Map<String,String> FormValues = {"email":"","OTP":"","password":"","cpassword":""};
  bool loading = false;

  @override
  void initState() {
    // TODO: implement initState
    CallStoreData();
    super.initState();
  }
  CallStoreData() async{
    String? OTP = await ReadUserData("OTPVerification");
    String? Email = await ReadUserData("EmailVerification");
    InputOnChange('email',Email);
    InputOnChange("OTP",OTP);

  }
  InputOnChange(MapKey,MapValue){
    setState(() {
      FormValues.update(MapKey, (value) => MapValue);
    });
  }

  FromOnSubmit()async {
    if (FormValues['password'] == ""){
      ErrorToast("Password Required!");
    }
    else if (FormValues['password'] != FormValues['cpassword']){
      ErrorToast("Password do not match!");
    }
    else{
      setState(() {
        loading = true;
      });
      bool res = await SetPasswordRequest(FormValues);
      if (res){
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
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
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Set Password",style: Head1Text(colorDarkBlue),),
                SizedBox(height: 1,),
                Text("Minimum length of password has to be 8 with both letters and numbers",style: Head6Text(colorLightGrey),),
                SizedBox(height: 20,),
                TextFormField(decoration: AppInputDecoration("Password"),),
                SizedBox(height: 20,),
                TextFormField(decoration: AppInputDecoration("Confirm Password"),),
                SizedBox(height: 20,),
                Container(
                  child: ElevatedButton(
                    style: AppButtonStyle(),
                    child: SuccessButtonChild("Confirm"),
                    onPressed: (){},
                  ),
                )


              ],
            ),
          )
        ],
      ),
    );;
  }
}
