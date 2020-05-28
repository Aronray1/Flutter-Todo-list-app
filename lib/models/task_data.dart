import 'package:flutter/foundation.dart';
import 'package:todo/models/task.dart';
//import 'package:todo/widgets/tasks_list.dart';
import 'dart:collection';
//import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final  taskref =Firestore.instance.collection('tasks').document('list');
bool check =false;
  List dblist;

class Taskdata extends ChangeNotifier {
 List<Task> _tasks=[

  ];
 
int get taskcount{
  return _tasks.length;
}
void getdata() async{
DocumentSnapshot doc=await taskref.get();
dblist=doc.data['list'];
}

void addtask(String newtasktitle){
  try{
     getdata();
  
  if(dblist.contains(newtasktitle)==false){
      taskref.updateData(
{
  'list':FieldValue.arrayUnion([newtasktitle]),
}

      );
      getdata();
  }
  
      }catch(e){
     }   // we cant update the values without this function as it auto rebuild again the widgets who are listening
                   // to this property according to it's updated value.
}

void showdata()
{
   
   var len=dblist.length;
   for(var i=0;i<len;i++){
        _tasks.add(Task(name:dblist[i]));
        notifyListeners();
   }
 

}

 UnmodifiableListView<Task> get tasks {
   getdata();
   showdata();
  return UnmodifiableListView(_tasks);
}



void updateTask(Task task){
  task.toggleDone();
  notifyListeners();
}

void deletetask(Task task){
  _tasks.remove(task);
  notifyListeners();
}

}

