
import 'package:flutter/material.dart';
import 'package:todo/screens/add_task.dart';
import 'package:todo/widgets/tasks_list.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/task_data.dart';


 var taskcount=0;
 var check=false;
class TasksScreen extends StatefulWidget {

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState(){
    super.initState();
   Taskdata().initdevice();
  }

  Widget build(BuildContext context) {
   // taskcountfun(); 
   Taskdata notifier=Provider.of<Taskdata>(context);
   taskcount=notifier.taskcount;
    return Scaffold(
      backgroundColor: Colors.teal[400],
      floatingActionButton: FloatingActionButton(onPressed: (){
    showModalBottomSheet(context: context, 
    isScrollControlled: true,
    builder: (context)=> SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(bottom:MediaQuery.of(context).viewInsets.bottom),// making keyboard to appear just below the add button.
        
        child: Addtaskscreen(
        ))
        
      )
      
      );
      
      },
      backgroundColor:Colors.teal[400] ,
      child:Icon(Icons.add)
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
padding: EdgeInsets.only(top:60.0, left:30.0, right: 30.0, bottom:30.0 ),
child:Column(
crossAxisAlignment: CrossAxisAlignment.start,
children:<Widget>[
CircleAvatar(child: Icon(Icons.list,
color:Colors.teal[400],
size:30.0
),
backgroundColor: Colors.white,
radius:30.0,
),

SizedBox(
height:10.0,

),
Text('Todo',
style: TextStyle(
color: Colors.white,
fontSize: 50.0,
fontWeight: FontWeight.w700,
),
),

Textcount(taskcount),
SizedBox(
  height:10.0
),

  FlatButton(onPressed: () {
    if(check==false){
    // Provider.of<Taskdata>(context).addtask('Hi there!');
      Provider.of<Taskdata>(context).showdata();
    check=true;
    }
  },
   child: Text('View Tasks',
   style:TextStyle(
     color:Colors.teal[400],
   )
   ),
   color:Colors.white,
  
  
  )

]
 
)          
  ),
          Expanded(
  child:   Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    decoration:BoxDecoration(color:Colors.white,
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(20.0),
    topRight: Radius.circular(20.0),
  
    )
  
     ),
  
    child:
  TaskList(),
      
  
  ),
),

        ],
      ),
    );
  }
}

class Textcount extends StatelessWidget {
 Textcount(this.count);
 final int count;

  @override
  Widget build(BuildContext context) {
    return     Text(
    
      '$count Tasks',
    
    
    
      style:TextStyle(
    
    color:Colors.white,
    
    fontSize:18.0
    
    
    
      )
    
    );
  }
}


