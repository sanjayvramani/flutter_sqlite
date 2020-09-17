import 'package:flutter/material.dart';
import 'Student.dart';
import 'DBHelper.dart';
import 'package:fluttertoast/fluttertoast.dart';
class DataEntry extends StatefulWidget {
  Student student;

  DataEntry({this.student});

  @override
  _DataEntryState createState() => _DataEntryState();
}

class _DataEntryState extends State<DataEntry> {
  GlobalKey<FormState> _formState = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtMobileNumber = TextEditingController();
  Student _student;
  DBHelper _dbHelper;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dbHelper=DBHelper();

    if(widget.student!=null)
      {
        _student=widget.student;
        txtName.text=_student.getStudentName;
        txtMobileNumber.text=_student.getStudentMobileNumber;
      }

  }

  void _saveRecord()
  {
    if(_formState.currentState.validate())
      {
        if(_student==null)
          {
            Student student= Student(txtName.text,txtMobileNumber.text);
            _dbHelper.insertStudent(student).then((value){
              if(value>0)
                {
                  Fluttertoast.showToast(msg: "Insert Succesfully");
                  Navigator.pop(context,value);
                }
            });

          }
        else
          {
            _student.setStudentName=txtName.text;
            _student.setStudentMobileNumber=txtMobileNumber.text;
            _dbHelper.updateStudent(_student).then((value){
              if(value>0)
              {
                Fluttertoast.showToast(msg: "Update Succesfully");
                Navigator.pop(context,value);
              }
            });

          }
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Entry"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formState,
          child: Column(
          children: <Widget>[

            TextFormField(
              controller: txtName,
              decoration: InputDecoration(hintText: "Name"),
              validator: (value){ return value.isEmpty==true?"can not be blank":null; },
            ),
            TextFormField(
              controller: txtMobileNumber,
              decoration: InputDecoration(hintText: "Mobile Number"),
              keyboardType: TextInputType.phone,
              validator: (value){ return value.isEmpty==true?"can not be blank":null; },
            ),
            RaisedButton(onPressed: (){
              _saveRecord();
            }, child: Text("Save"),)
          ],
        )),
      ),
    );
  }
}
