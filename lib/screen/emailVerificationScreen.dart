import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../restapi/RestClient.dart';
import '../style/style.dart';

class emailVerificationScreen extends StatefulWidget {
  const emailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<emailVerificationScreen> createState() => _emailVerificationScreenState();
}

class _emailVerificationScreenState extends State<emailVerificationScreen> {
  Map <String,String> FormValues = {"email":""};
  bool loading = false;

  InputOnChange(MapKey, MapValue){
    setState(() {
      FormValues.update(MapKey, (value) => MapValue);
    });
  }

  FormOnSubmit() async{
    if (FormValues['email'] == ""){
      ErrorToast("Email Required!");
    }
    else{
      setState(() {
        loading = true;
      });
      bool res = await VerifyEmailRequest(FormValues['email']);
      if (res){
        Navigator.pushNamed(context, '/pinVerification');
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
            child: loading?(Center(child: CircularProgressIndicator(),)):(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Email Address",style: Head1Text(colorDarkBlue),),
                    SizedBox(height: 1,),
                    Text("A 6 digit verification code will be sent to your email address",style: Head6Text(colorLightGrey),),
                    SizedBox(height: 20,),
                    TextFormField(decoration: AppInputDecoration("Email Address"),
                      onChanged: (value){
                        InputOnChange("email", value);
                      },
                    ),
                    SizedBox(height: 20,),
                    Container(
                      child: ElevatedButton(
                        style: AppButtonStyle(),
                        child: SuccessButtonChild("Next"),
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
    );;
  }
}
