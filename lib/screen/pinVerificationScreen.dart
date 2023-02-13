import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager_project/restapi/RestClient.dart';
import 'package:task_manager_project/style/style.dart';
import 'package:task_manager_project/utility/Utility.dart';

class pinVerificationScreen extends StatefulWidget {
  const pinVerificationScreen({Key? key}) : super(key: key);

  @override
  State<pinVerificationScreen> createState() => _pinVerificationScreenState();
}

class _pinVerificationScreenState extends State<pinVerificationScreen> {
  Map<String,String> FormValues = {"otp":""};
  bool loading = false;

  InputOnChange(MapKey, MapValue){
    setState(() {
      FormValues.update(MapKey, (value) => MapValue);
    });
  }
  FormOnSubmit() async{
    if (FormValues['otp']!.length != 6){
      ErrorToast("PIN Required!");
    }
    else{
      setState(() {
        loading = true;
      });
      String? email = await ReadUserData('EmailVerification');
      bool res = await VerifyOTPRequest(email, FormValues['otp']);

      if (res){
        Navigator.pushNamed(context, '/setPassword');

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
            alignment: Alignment.center,
            padding: EdgeInsets.all(30),
            child: loading?(Center(child: CircularProgressIndicator(),)):(Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("PIN Verification",style: Head1Text(colorDarkBlue),),
                SizedBox(height: 10,),
                Text("A 4 digit pin  has been sent to your phone number",style: Head6Text(colorLightGrey),),
                SizedBox(height: 20,),
                PinCodeTextField(appContext: context,
                    length: 4,
                    pinTheme: AppOTPStyle(),
                    animationType: AnimationType.fade,
                    animationDuration: Duration(microseconds: 300),
                    enableActiveFill: true,
                    onCompleted: (v){

                    },
                    onChanged: (value){

                    }
                ),
                Container(
                  child: ElevatedButton(
                    style: AppButtonStyle(),
                    child: SuccessButtonChild("Verify"),
                    onPressed: (){
                      FormOnSubmit();
                    },
                  ),
                )
              ],
            )
            )
          )
        ],
      ),
    );
  }
}
