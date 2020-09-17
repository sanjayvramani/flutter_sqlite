import 'dart:io';

import 'package:flutter/material.dart';
import 'DataEntry.dart';
import 'DBHelper.dart';
import 'Student.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'SQLite Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<Student> _lstStudent = List<Student>();
  DBHelper _dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbHelper=DBHelper();
  }

  void showAllStudent()
  {
    _dbHelper.getAllStudent().then((list){
      setState(() {
        _lstStudent=list;
      });
    });
  }



  Future _openRecord({int index = -1}) async
  {

    print("index is $index");

        var result = await (index==-1)? Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DataEntry()))
        : Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DataEntry(student: _lstStudent[index],))) ;

        if(result!=null) {
          showAllStudent();
        }


  }

  void _deleteRecord(int index)
  {
    Student _student= _lstStudent[index];
    _dbHelper.deleteStudent(_student.getStudentId).then(
        (value)
            {
              if(value>0)
                {
                  Fluttertoast.showToast(msg: "Record Deleted");
                  setState(() {
                    _lstStudent.removeAt(index);
                  });
                }
            }
    );
  }


  Widget _studentRecord(int index)
  {
    Student _student= _lstStudent[index];

    return Card(
      child: Row(
        children: [

             Expanded(
               flex: 10,
               child:  Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Text(_student.getStudentName,style: TextStyle(fontSize: 24.0),),
                 Text(_student.getStudentMobileNumber,style: TextStyle(fontSize: 20.0),)
               ],
             ),),
              Expanded(
                flex: 4,
                child: Row(
                children: [
                  IconButton(icon: Icon(Icons.edit,color: Colors.blue,), onPressed: (){
                    _openRecord(index: index);
                  }),
                  IconButton(icon: Icon(Icons.delete,color: Colors.red,),onPressed: (){
                    _deleteRecord(index);
                  },)
                ],
              )
          ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {

    showAllStudent();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
       ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed: (){
            _openRecord();
          })
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          children: <Widget>[
            ListView.builder(
              shrinkWrap: true,
                itemCount: _lstStudent.length,
                itemBuilder: (context,index){
                  return _studentRecord(index);
                })
          ],
        ),
      ),
      drawer: ListView(
        children: <Widget>[
          RaisedButton(onPressed: (){},child: Text("Home"),)
        ],
      ),

    );

   /* bool isSelected = false;

  //  Platform.

    return Scaffold(
      *//*appBar: AppBar(
        title:  Text( "Other Demo"),
      ),*//*
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Image.asset("assets/google_logo.png",height: 150,width: 150,)
          ],
        ),
      ),
      drawer: Container(
        color: Colors.white,
        height: double.infinity,
        width: 250.0,
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: Image.network("http://rakshgroup.com/clientpanel/images/logo.png"),
              accountName: Text("Flutter Developer"),
              accountEmail: Text("developer@flutter.com"),
            ),
            ListTile(
              leading: Icon(Icons.home,color: Colors.blue,),
              title: Text("Home"),
              onTap: (){
                print("Home Clicked");
                Navigator.pop(context);
              },
              selected: true,

            ),
            ListTile(
              leading: Icon(Icons.add_alert,color: Colors.blue,),
              title: Text("Alert"),
              onTap: (){
                print("Alert");
                Navigator.pop(context);

              },
            )
          ],
        ),
      ),

    );*/

  }
}
