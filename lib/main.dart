import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterappburak/studen_Add.dart';
import 'package:flutterappburak/student.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() => runApp(MyApps());

class MyApps extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: darkBlue),
        home: HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var formKey = GlobalKey<FormState>();
  static int sayac = 0;

  List<Student> students = [
    Student.withId(1, "Ahmet", "Tanpınar", 100),
    Student.withId(2, "Orhan", "Can", 70),
    Student.withId(3, "Selim", "Korkmaz", 12)
  ];

  Student selectedStudent = Student.withId(0, "firstName", "lastName", 2);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Öğrenci Takip Sistemi"),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: students.length,
            itemBuilder: _listeElemanlariniOlustur,
          ),
        ),
        Text(" Seçili öğrenci " + selectedStudent.firstName),
        Row(
          children: <Widget>[
            Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: RaisedButton(
                  color: Colors.blueAccent,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 0.5,
                      ),
                      Text(
                        "Yeni Öğrenci",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      )
                    ],
                  ),
                  onPressed: () {
                    _navigateAndDisplaySelection(context);
                  },
                )),
            Flexible(
                fit: FlexFit.tight,
                flex: 2,
                child: RaisedButton(
                  color: Colors.yellowAccent,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      Text(
                        "Öğrenci Güncelle ",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      )
                    ],
                  ),
                  onPressed: () {
                    print("Öğrenci Güncelle");
                  },
                )),
            Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: RaisedButton(
                  color: Colors.greenAccent,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.add,
                        color: Colors.black,
                      ),
                      Text(
                        "Sil",
                        style: TextStyle(color: Colors.black, fontSize: 10),
                      )
                    ],
                  ),
                  onPressed: () {
                    print("SİL");
                  },
                ))
          ],
        )
      ],
    );
  }

  Widget buildStatusIcon(int grade) {
    if (grade >= 50) {
      return Icon(Icons.done);
    } else if (grade >= 40) {
      return Icon(Icons.album);
    } else {
      return Icon(Icons.clear);
    }
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => StudentAdd(students)),
    ).then((value) {
      setState(() {
        this.selectedStudent = students[students.length];
      });
    });

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(
          elevation: 60, content: Text("Öğrenci kaydı başarılı ${result[1]}")));
  }

  Widget _listeElemanlariniOlustur(BuildContext context, int index) {
    sayac++;
    return Dismissible(
      key: Key(sayac.toString()),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        setState(() {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("${students[index].firstName} adlı öğrenci silindi")));
          students.removeAt(index);
        });

      },
      background: Container(alignment: Alignment.centerLeft, padding: EdgeInsets.only(left: 20),
        child:Icon(Icons.delete,),color: Colors.red,),
      child: Container(
        child: ListTile(
          key: Key(index.toString()),
          title:
              Text(students[index].firstName + " " + students[index].lastName),
          subtitle: Text("Sınavdan aldığı not : " +
              "" +
              students[index].grade.toString() +
              "[" +
              students[index].getStatus +
              "]"),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://tmssl.akamaized.net/images/portrait/header/7362-1542662588.png?lm=1542662602"),
          ),
          trailing: buildStatusIcon(students[index].grade),
          onTap: () {
            setState(() {
              this.selectedStudent = students[index];
            });

            print(selectedStudent.firstName);
          },
          onLongPress: () {
            print("Uzun Basıldı");
          },
        ),
      ),
    );
  }
}
