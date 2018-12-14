class User {

  // general data
  final String reqStatus;
  final String message;
  final String data;

  // user data
  final int id;
  final String name;
  final String email;
  final String phone;
  final String token;
  final int status;

  // constructor
  User({this.reqStatus, this.message, this.data, this.id, this.name, this.email, this.phone, this.token, this.status});

  // get data from response
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      
    );
  }
}