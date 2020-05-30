import 'package:flutter/foundation.dart';
import 'package:todo/models/task.dart';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_id/device_id.dart';


var count;
List dblist=['Hello, Hi there!'];
String deviceid;
String documentid;
class Taskdata extends ChangeNotifier {
 List<Task> _tasks=[];
 bool check1=false;
  void check(var deviceid) async{
   
try{ 
await Firestore.instance.collection('tasks').getDocuments().then((QuerySnapshot snapshot){
snapshot.documents.forEach((f){
if(f.documentID==deviceid){
  documentid=f.documentID;
  check1=true;
}
});
 });

if(check1==false){
  await Firestore.instance.collection('tasks').document(deviceid).setData({
    'list':dblist,
    'deviceid':deviceid,
  });
 
}
    }
    catch(e){}
  }


void addtask(String newtasktitle) async{
  
  final  taskref =Firestore.instance.collection('tasks').document(deviceid);
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

void showdata() async{
  
  final  taskref =Firestore.instance.collection('tasks').document(deviceid);
  DocumentSnapshot doc=await taskref.get();
dblist=doc.data['list'];
  for(var i in dblist){
    if(i!=null){
      print('i am in null statement');
      print(_tasks.contains(Task(name:i)));
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
  final  taskref =Firestore.instance.collection('tasks').document(deviceid);
  _tasks.remove(task);
   notifyListeners();
  taskref.updateData({
    'list':FieldValue.arrayRemove([task.name]),
    });
}

Future<void> initdevice() async{

String deviceid1;
deviceid1=await DeviceId.getID;
print('i am device id ');
deviceid=deviceid1;
print(deviceid1);
check(deviceid1);

}


}