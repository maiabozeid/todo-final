import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_final/database/my_database.dart';
import '../../database/task.dart';

import '../../dialoge_utils.dart';
import '../../my_theme_data.dart';

class TaskWidget extends StatelessWidget {

  Task task;


  TaskWidget(this.task);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8),
        child: Slidable(
        startActionPane: ActionPane(
        motion: DrawerMotion(),
    children: [
    SlidableAction(onPressed: (_){
     MyDatabase.deleteTask(task).
      then((value) {

        ShowMessage(context , 'Task Deleted Successfully',
        posActionName :'Ok');
})
        .onError((error, stackTrace) {
  ShowMessage(context , 'SomeThing went wrong , please try again later',
      posActionName :'Ok');
}).
    timeout(Duration(seconds: 5),
onTimeout: ()
{
  ShowMessage(context, 'Data delete locally',
      posActionName: 'Ok');
});

},


    icon: Icons.delete,
    backgroundColor: MyTheme.red,
    label: 'Delete',
    borderRadius: BorderRadius.only(topLeft:Radius.circular(12) ,
    bottomLeft: Radius.circular(12)),
        ),
    ]
        ),
    child:Container(
        decoration: BoxDecoration(
        color: Colors.white,
        // borderRadius: BorderRadius.circular(12),
    ),

    padding: EdgeInsets.all(24),
    child: Row(
    children: [
      Container(
        width: 8,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),

    ),
    SizedBox(width: 20,),
      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.title?? " ",
                style :Theme.of(context).textTheme.titleMedium),
            SizedBox(height:8,),
            Row(
              children: [
                Icon(Icons.access_time,),
                SizedBox(width: 10,),
                Text(task.description?? " ", style: Theme.of(context).textTheme.titleMedium),

              ],
            ),
          ],
        ),
      ),

    Container(
    padding: EdgeInsets.symmetric(vertical: 8,horizontal:24 ),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    color:Theme.of(context).primaryColor,
    ),
    child: Icon(Icons.check,color: Colors.white,),
    ),

    ],
    ),
    ),
    ),
    );



  }
}
