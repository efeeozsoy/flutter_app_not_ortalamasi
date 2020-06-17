import 'package:flutter/material.dart';
import 'package:flutterappburak/student.dart';


// ignore: must_be_immutable
class StudentAdd extends StatefulWidget {

  List<Student> students;
  //StudentAdd(List<Student> students){
  //  this.students = students;

  //}
  StudentAdd(this.students);
  @override
  State<StatefulWidget> createState() {
    return _StudentAddState();

  }


}

class _StudentAddState extends State<StudentAdd> {
  var formKey = GlobalKey<FormState>();
  Student student = Student("", "", 0);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Yeni Öğrenci "),
        ),
        body: Container(
          margin: EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                buildFirstNameField(),
                buildLastNameField(),
                buildGradeNameField(),
                buildSubmitButton()
              ],
            ),
          ),
        ));
  }

  Widget buildFirstNameField() {
    return TextFormField(

      decoration: InputDecoration(labelText: "Öğrenci adı", hintText: "İsiminizi giriniz"),
      onSaved: (String value) {
        student.firstName = value;
      },
    );
  }

  Widget buildLastNameField() {
    return TextFormField(
      decoration:
      InputDecoration(labelText: "Öğrenci soyaadı", hintText: "Soyadınızı giriniz:"),
      onSaved: (String value) {
        student.lastName = value;
      },
    );
  }

  Widget buildGradeNameField() {
    return TextFormField(
      decoration:
      InputDecoration(labelText: "Öğrenci aldığı not ", hintText: "65"),
      onSaved: (String value) {
        student.grade = int.parse(value);
      },
    );
  }

  Widget buildSubmitButton() {
    return RaisedButton(
      child: Text("Kaydet"),
      onPressed: () {
        setState(() {
          formKey.currentState.save();
          widget.students.add(student);
          Navigator.pop(context,widget.students);
        });
      },
    );
  }
}
