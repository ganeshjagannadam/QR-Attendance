
class Users{
  String name,rollNumber;

  Users(this.name, this.rollNumber);

  Users.fromJson(  Map<String,dynamic> json) : name = json['name'],
        rollNumber = json['rollNumber'];
  Map<String,dynamic> toJson(Map<String, dynamic> jsondetails)=>{
    'name':name,
    'rollNumber':rollNumber,
  };
}

class Loc{
  String location;

  Loc(this.location);
  Loc.fromJson( Map<String,dynamic> json) : location = json['location'];
  Map<String,dynamic> toJson(Map<String, dynamic> jsondetails)=>{
    'location':location,
  };
}

class Course{
  String course;

  Course(this.course);
  Course.fromJson(Map<String,dynamic> json):course = json['course'];
  Map<String,dynamic> toJson(Map<String, dynamic> jsondetails)=>{
    'course':course,
  };
}
