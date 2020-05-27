import 'package:flutter/foundation.dart';
import 'package:todo/models/task.dart';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
List<String> data=[];
class Taskdata extends ChangeNotifier {
 List<Task> _tasks=[

  ];
  int length;


void addtask(String newtasktitle) {
  try{

       
    _tasks.add(Task(name:newtasktitle));
    notifyListeners();

         
     }catch(e){
     }   // we cant update the values without this function as it auto rebuild again the widgets who are listening
                   // to this property according to it's updated value.
}
void getdata()async {
   await _firestore.collection("tasks").getDocuments().then((querySnapshot) {
    querySnapshot.documents.forEach((result) {
       data.add(result.data['title']);
       
       
    });
 return data;
  });
  
  
}


int get taskcount{
 
  return data.length;
}
List<Task> returnlist(){
  return _tasks;
}

 UnmodifiableListView<Task> get tasks {
   getdata();
   print(taskcount);
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

