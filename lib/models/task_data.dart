import 'package:flutter/foundation.dart';
import 'package:todo/models/task.dart';
import 'dart:collection';
import 'package:flutter/material.dart';

List<String> data=[];
class Taskdata extends ChangeNotifier {
 List<Task> _tasks=[

  ];
  int length;


void addtask(String newtasktitle) async{
  try{
   
    _tasks.add(Task(name:newtasktitle));
    notifyListeners();
         
     }catch(e){
     }   // we cant update the values without this function as it auto rebuild again the widgets who are listening
                   // to this property according to it's updated value.
}

int get taskcount{
  return _tasks.length;
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
}

}

