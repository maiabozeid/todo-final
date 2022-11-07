import 'package:flutter/material.dart';
import 'package:todo_final/home/settings_tab/settings_tab.dart';


import 'add_task_bottom_sheet.dart';
import 'tasks_list/tasks_list_tab.dart';

class HomeScreen extends StatefulWidget {
static const String routeName='home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
int selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('To Do List'),
      ),

bottomNavigationBar:
BottomAppBar(
    shape: CircularNotchedRectangle(),
    notchMargin: 8,
    child: BottomNavigationBar(

    currentIndex:selectedIndex,
    onTap:(index){

    setState((){
      selectedIndex=index;});
    },
        showUnselectedLabels: false,
        showSelectedLabels: false,
        items: [
        BottomNavigationBarItem(icon:Icon(Icons.list),
        label: 'Menu'),

        BottomNavigationBarItem(
          icon:Icon(Icons.settings),
        backgroundColor:Colors.white,
          label: 'Settings'),
      ]
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerDocked,

      floatingActionButton: FloatingActionButton(
    shape: StadiumBorder(
    side: BorderSide(
    color:Colors.white,width: 4)
    ),
    onPressed: () {
      showAddTaskBottomSheet();
    },
    child:Icon(Icons.add),
    ),




body:tabs[selectedIndex],
    );
  }


var tabs = [TasksListTab(),SettingTab()];

  void showAddTaskBottomSheet(){
    showModalBottomSheet(context: context, builder: (buildContext)
    {
      return AddTaskBottomSheet();
    },isScrollControlled: true,
    );
}
}