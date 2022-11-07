
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:provider/provider.dart';
import '../../database/my_database.dart';
import '../../database/task.dart';
import '../providers/tasks_provider.dart';
import 'task_widget.dart';



class TasksListTab extends StatefulWidget {
  @override
  State<TasksListTab> createState() => _TasksListTabState();
}

class _TasksListTabState extends State<TasksListTab> {
DateTime selectedDate= DateTime.now();
late TasksProvider provider;

@override
void initState(){
  super.initState();
  provider.refreshTasks(selectedDate);
}

  @override
  Widget build(BuildContext context) {
    TasksProvider provider= Provider.of<TasksProvider>(context);

    return Container(
        child: Column(
          children: [
            CalendarTimeline(
              showYears:true,
              initialDate: selectedDate,
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              lastDate: DateTime.now().add(Duration(days: 365)),

              onDateSelected: ((date) {
                if(selectedDate==null)return;
                setState((){
                  selectedDate = date;
                  provider.refreshTasks(selectedDate);
                });

              }
              ),
              leftMargin: 20,
              monthColor: Colors.black,
              dayColor: Colors.black,
              activeDayColor: Theme.of(context).primaryColor,
              activeBackgroundDayColor: Colors.white,
              dotsColor:Theme.of(context).primaryColor,
              selectableDayPredicate: (date) => true,
              locale: 'en_ISO',
            ),
            Expanded(
        child: ListView.builder(
          itemBuilder: (buildContext , index){
            return TaskWidget(provider.tasks[index]);
          },itemCount: provider.tasks.length ,),





            ),

    ],
        ),
    );


  }
}
