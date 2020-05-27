import 'package:flutter/foundation.dart';
import 'package:todo/models/task.dart';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore = Firestore.instance;
class Taskdata extends ChangeNotifier {
 List<Task> _tasks=[

  ];
  int length;
int get taskcount{
  return _tasks.length;
}

void addtask(String newtasktitle){
  try{
final task=Task(name: newtasktitle);
  _firestore.collection('tasks').add({
'title':newtasktitle,
  });
  _tasks.add(task);
  notifyListeners();
     }catch(e){
     }   // we cant update the values without this function as it auto rebuild again the widgets who are listening
                   // to this property according to it's updated value.
}
void getdata(){
  _firestore.collection("tasks").getDocuments().then((querySnapshot) {
    querySnapshot.documents.forEach((result) {
      _tasks.add(Task(name:result.data['title']));
    });
  });
   
}

int  getlength(){
return length;
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

