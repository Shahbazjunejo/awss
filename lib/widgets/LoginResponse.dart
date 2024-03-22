class LoginResponse {
  final String? name;
  final String? username;
  final String? email;
  final String? contact;
  final String? cnic;
  final String? address;
  final String? token;

  LoginResponse({
    this.name,
    this.username,
    this.email,
    this.contact,
    this.cnic,
    this.address,
    this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic>? json) {
    return LoginResponse(
      name: json?['schoolname'],
      username: json?['username'],
      email: json?['Email'],
      contact: json?['Contact'],
      cnic: json?['Cnic'],
      address: json?['address'],
    //  token: json['token'],
    );
  }
}



