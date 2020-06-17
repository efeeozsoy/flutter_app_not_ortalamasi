class Student {
  int id;
  String firstName;
  String lastName;
  int grade;
  String status;

  Student(String ogrfirstName, String ogrlastName, int ogrgrade) {
    this.firstName = ogrfirstName;
    this.lastName = ogrlastName;
    this.grade = ogrgrade;
  }

  // Dart dilinde named constructor
  Student.withId(int id, String ogrfirstName, String ogrlastName, int ogrgrade) {
    this.id = id;
    this.firstName = ogrfirstName;
    this.lastName = ogrlastName;
    this.grade = ogrgrade;
  }
  String get getStatus {
    String message = "";
    if (this.grade >= 50) {
      message = "Geçti ";
    } else if (this.grade >= 40) {
      message = "Bütünlemeye Kaldı";
    } else {
      message = "Kaldı";
    }
    this.status = message;
    return this.status;
  }
}
