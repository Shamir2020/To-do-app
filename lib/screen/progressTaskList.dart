import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../restapi/RestClient.dart';
import '../style/style.dart';
import 'TaskList.dart';

class ProgressTaskList extends StatefulWidget {
  const ProgressTaskList({Key? key}) : super(key: key);

  @override
  State<ProgressTaskList> createState() => _ProgressTaskListState();
}

class _ProgressTaskListState extends State<ProgressTaskList> {
  List TaskLists = [];
  bool loading = true;
  String Status = "Progress";

  CallData() async{
    var data = await TaskListRequest("Progress");
    setState(() {
      loading = false;
      TaskLists = data;
    });

  }
  DeleteItem(id) async{
    showDialog(context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Delete!!"),
            content: Text("Are you sure to delete?"),
            actions: [
              OutlinedButton(onPressed: ()async{
                Navigator.pop(context);
                setState(() {
                  loading = true;
                });
                await TaskDeleteRequest(id);
                await CallData();
              }, child: Text("Yes")),
              OutlinedButton(onPressed: (){Navigator.pop(context);}, child: Text("No"))
            ],
          );
        }
    );
  }

  ChangeStatus(id) async{
    showModalBottomSheet(context: context,
        builder: (context){
          return StatefulBuilder(
              builder: (BuildContext context,StateSetter setState){
                return Container(
                  padding: EdgeInsets.all(30),
                  height: 400,
                  child: Column(
                    children: [
                      RadioListTile(title:Text("New"),value: "New", groupValue: Status,
                          onChanged: (value){
                            setState((){
                              Status = value.toString();
                            });
                          }),
                      RadioListTile(title:Text("Progress"),value: "Progress", groupValue: Status,
                          onChanged: (value){
                            setState((){
                              Status = value.toString();
                            });
                          }),

                      RadioListTile(title:Text("Completed"),value: "Completed", groupValue: Status,
                          onChanged: (value){
                            setState((){
                              Status = value.toString();
                            });
                          }),

                      RadioListTile(title:Text("Canceled"),value: "Canceled", groupValue: Status,
                          onChanged: (value){
                            setState((){
                              Status = value.toString();
                            });
                          }),
                      Container(
                        child: ElevatedButton(
                          child: SuccessButtonChild("Confirm"),
                          onPressed: (){
                            Navigator.pop(context);
                            setState((){
                              loading = true;
                            });
                            TaskUpdateRequest(id, Status);
                            CallData();
                            setState((){
                              Status = "Progress";
                            });

                          },
                        ),
                      )

                    ],
                  ),
                );
              }
          );

        }
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    CallData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading?(Center(child: CircularProgressIndicator(),)):(RefreshIndicator(onRefresh:()async{await CallData();},
        child: TaskList(TaskLists,DeleteItem,ChangeStatus)));
  }
}
