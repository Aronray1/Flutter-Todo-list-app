import 'package:flutter/foundation.dart';
import 'package:todo/models/task.dart';
//import 'package:todo/screens/tasks_screen.dart';
//import 'package:todo/widgets/tasks_list.dart';
import 'dart:collection';
//import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final  taskref =Firestore.instance.collection('tasks').document('list');
bool check =false;
var count;
  List dblist;
class Taskdata extends ChangeNotifier {
 List<Task> _tasks=[

  ];
 
void addtask(String newtasktitle) async{
  try{
    DocumentSnapshot doc=await taskref.get();
dblist=doc.data['list'];
  if(dblist.contains(newtasktitle)==false){
      taskref.updateData(
{
  'list':FieldValue.arrayUnion([newtasktitle]),
}
      );
  }
    _tasks.add(Task(name:newtasktitle));
    notifyListeners();
      }catch(e){
     }   // we cant update the values without this function as it auto rebuild again the widgets who are listening
              // to this property according to it's updated value.
}

int get taskcount{
   count=_tasks.length;
  notifyListeners();
  return count;
}

void showdata()async{
  DocumentSnapshot doc=await taskref.get();
dblist=doc.data['list'];

  for(var i in dblist){
    if(i!=null){
    if(_tasks.contains(Task(name:i))==false){
    _tasks.add(Task(name:i.toString()));
    notifyListeners();
    }
    } 
  }  
}

 UnmodifiableListView<Task> get tasks {
  return UnmodifiableListView(_tasks);
}

void updateTask(Task task){
  task.toggleDone();
  notifyListeners();
}

void deletetask(Task task){
  _tasks.remove(task);
   notifyListeners();
  taskref.updateData({
    'list':FieldValue.arrayRemove([task.name]),
    });
}
}

