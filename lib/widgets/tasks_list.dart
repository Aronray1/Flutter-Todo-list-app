import 'package:flutter/material.dart';
import 'package:todo/widgets/tasks_tile.dart';  
import 'package:provider/provider.dart';
import 'package:todo/models/task_data.dart';
//import 'package:provider/provider.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// var brews;
class TaskList extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    
  
    return Consumer<Taskdata>(
      builder: (context,taskdata,child){
        
        return  ListView.builder(itemBuilder: (context,index){
               return TaskTile(taskTitle:taskdata.tasks[index].name ,ischecked:taskdata.tasks[index].isDone,
               checkboxcallback:(checkboxstate){
                 taskdata.updateTask(taskdata.tasks[index]);
               },
               longpresscallback: (){
taskdata.deletetask(taskdata.tasks[index]);
Scaffold.of(context).showSnackBar(
SnackBar(content: Text('Deleted one task'))
);

    },
               );


      },
      itemCount: taskdata.taskcount,
      
      );
      },
          
    );
  }
}