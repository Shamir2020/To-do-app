
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:task_manager_project/style/style.dart';


ListView TaskList(TaskItems,DeleteItem,ChangeStatus){
  return ListView.builder(
      itemCount: TaskItems.length,
      itemBuilder: (context,index){
        Color statusColor = colorGreen;
        if (TaskItems[index]['status'] == "New"){
          statusColor = colorBlue;
        }
        else if (TaskItems[index]['status'] == "Progress"){
          statusColor = colorOrange;
        }
        else if (TaskItems[index]['status'] == "Canceled"){
          statusColor = colorRed;
        }

        return Card(
          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          child: ItemSizeBox(
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(TaskItems[index]['title'],style: Head6Text(colorDarkBlue),),
                Text(TaskItems[index]['description'],style: Head6Text(colorLightGrey),),
                Text(TaskItems[index]['createdDate'],style: Head7Text(colorDarkBlue),),
                SizedBox(height: 10,),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StatusChild(TaskItems[index]['status'], statusColor),
                      Row(
                        children: [
                          SizedBox(width: 50,height: 30,child: ElevatedButton(child: Icon(Icons.edit_location_alt_outlined,size: 16,),onPressed: (){
                            ChangeStatus(TaskItems[index]['_id']);
                          },),),
                          SizedBox(width: 10,),
                          SizedBox(width: 50,height: 30,child: ElevatedButton(child: Icon(Icons.delete_outlined,size: 16,),style: ElevatedButton.styleFrom(
                            backgroundColor: colorRed
                          ),
                            onPressed: (){
                            DeleteItem(TaskItems[index]['_id']);
                            },),)
                        ],
                      )

                    ],
                  ),
                )
              
              ],
            )
          ),
        );
      }
  );
}