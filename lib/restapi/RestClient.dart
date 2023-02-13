import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:task_manager_project/style/style.dart';
import 'package:task_manager_project/utility/Utility.dart';

var BaseURL = "https://task.teamrabbil.com/api/v1";
var RequestHeader = {"Content-Type":"application/json"};

Future<bool> LoginRequest(FormValues) async{
  var URL = Uri.parse("${BaseURL}/login");
  var postBody = json.encode(FormValues);
  var response = await http.post(URL,headers: RequestHeader,body: postBody);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (ResultCode == 200 && ResultBody["status"]=="success"){
    SuccessToast("Request Success");
    await WriteUserData(ResultBody);
    return true;
  }
  else{
    ErrorToast("Request fail. Try again !!!");
    return false;
  }
}

Future<bool> RegistrationRequest (FormValues) async{
  var URL = Uri.parse("${BaseURL}/registration");
  var postBody = json.encode(FormValues);
  var response = await http.post(URL,headers: RequestHeader,body: postBody);

  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (ResultCode == 200 && ResultBody['status'] == "success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail! Try again!");
    return false;
  }
}

Future<bool> VerifyEmailRequest(Email) async{
  var URL = Uri.parse("${BaseURL}/RecoverVerifyEmail/${Email}");

  var response = await http.get(URL,headers: RequestHeader);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (ResultCode == 200 && ResultBody["status"]=="success"){
    await WriteEmailVerification(Email);
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail. Try again !!!");
    return false;
  }
}

Future<bool> VerifyOTPRequest(Email,OTP) async{
  var URL = Uri.parse("${BaseURL}/RecoverVerifyOTP/${Email}/${OTP}");

  var response = await http.get(URL,headers: RequestHeader);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (ResultCode == 200 && ResultBody["status"]=="success"){
    await WriteOTPVerification(OTP);
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail. Try again !!!");
    return false;
  }

}

Future<bool> SetPasswordRequest(FormValues) async{
  var URL = Uri.parse("${BaseURL}/RecoverResetPass");
  var postBody = json.encode(FormValues);
  var response = await http.post(URL,headers: RequestHeader,body: postBody);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (ResultCode == 200 && ResultBody["status"]=="success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail. Try again !!!");
    return false;
  }
}

Future<List> TaskListRequest(status) async{
  var URL = Uri.parse("${BaseURL}/listTaskByStatus/${status}");

  String? token = await ReadUserData("token");
  var RequestHeaderWithToken = {"Content-Type":"application/json","token":"${token}"};
  var response = await http.get(URL,headers: RequestHeaderWithToken);

  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (ResultCode == 200 && ResultBody['status'] == "success"){
    SuccessToast("Request Success");
    return ResultBody['data'];
  }
  else{
    ErrorToast("Request fail! Try again");
    return [];
  }

}



Future<bool> TaskCreateRequest(FormValues) async{
  var URL = Uri.parse("${BaseURL}/createTask");

  String? token = await ReadUserData("token");
  var RequestHeaderWithToken = {"Content-Type":"application/json","token":"${token}"};
  var postBody = json.encode(FormValues);

  var response = await http.post(URL,headers: RequestHeaderWithToken,body: postBody);

  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (ResultCode == 200 && ResultBody['status'] == "success"){
    SuccessToast("Request Success");
    return true;
  }
  else{
    ErrorToast("Request fail! Try again");
    return false;
  }

}

Future<bool> TaskDeleteRequest(id) async{
  var URL = Uri.parse("${BaseURL}/deleteTask/${id}");
  String? token = await ReadUserData('token');
  var RequestHeaderWithToken = {"Content-Type":"application/json","token":"${token}"};
  var response = await http.get(URL,headers: RequestHeaderWithToken);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (ResultCode == 200 && ResultBody['status'] == "success"){
    SuccessToast("Request Success!");
    return true;
  }
  else{
    ErrorToast("Request fail! Try again!");
    return false;
  }
}
Future<bool> TaskUpdateRequest(id,status) async{
  var URL = Uri.parse("${BaseURL}/UpdateTaskStatus/${id}/${status}");
  String? token = await ReadUserData('token');
  var RequestHeaderWithToken = {"Content-Type":"application/json","token":"${token}"};
  var response = await http.get(URL,headers: RequestHeaderWithToken);
  var ResultCode = response.statusCode;
  var ResultBody = json.decode(response.body);

  if (ResultCode == 200 && ResultBody['status'] == "success"){
    SuccessToast("Request Success!");
    return true;
  }
  else{
    ErrorToast("Request fail! Try again!");
    return false;
  }
}