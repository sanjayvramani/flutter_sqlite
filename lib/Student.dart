class Student
{
  int studentId;
  String studentName,studentMobileNumber;
  Student(this.studentName,this.studentMobileNumber,{this.studentId});
  int get getStudentId => studentId;
  String get getStudentName => studentName;
  String get getStudentMobileNumber=> studentMobileNumber;

  set setStudentName(String studentName)
  {
    this.studentName=studentName;
  }

  set setStudentMobileNumber(String studentMobileNumber)
  {
    this.studentMobileNumber=studentMobileNumber;
  }

  Map<String,dynamic> toMap()
  {
    return {
      "studentName":studentName,
      "studentMobileNumber":studentMobileNumber
    };
  }

/* Student.fromMap(Map<String,dynamic> map)
  {
    studentId=map["studentId"];
    studentName=map["studentName"];
    studentMobileNumber=map["studentMobileNumber"];
} */

 Student.fromMap(Map<String,dynamic> map)
 {
   studentId=map["studentId"];
   studentName=map["studentName"];
   studentMobileNumber=map["studentMobileNumber"];
 }



}