import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';
import 'Student.dart';
class DBHelper
{

  Database _database;

  Future openDB() async
  {
    if(_database==null)
      {
        var path = join(await getDatabasesPath(),"mystudent.db");
        _database = await openDatabase(path,version: 1,onCreate: (database,version) async{
          await database.execute("CREATE TABLE studentMaster(studentId integer primary key autoincrement,studentName text,studentMobileNumber text)");
        });
      }
  }



  Future<int> insertStudent(Student student) async
  {
    await openDB();
    return await _database.insert("studentMaster", student.toMap());
  }

  Future<int> updateStudent(Student student) async
  {
    await openDB();
    return await _database.update("studentMaster",student.toMap(),where: "studentId=?",whereArgs: [student.getStudentId]);
  }

  Future<int> deleteStudent(int studentId) async
  {
    await openDB();
    return await _database.delete("studentMaster",where: "studentId=$studentId");
  }

  Future<List<Student>> getAllStudent() async
  {
    await openDB();
    var lst = await _database.rawQuery("select * from studentMaster");
    //var lst = await _database.query("studentMaster");
    List<Student> lstStudent = List<Student>();
    for(int i = 0;i<lst.length;i++)
      {
        lstStudent.add(Student.fromMap(lst[i]));
      }
    return lstStudent;
  }
}