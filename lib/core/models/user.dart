class User {
  String name;
  String companyName;
  String email;
  String phone;

  User({
    this.name,
    this.companyName,
    this.email,
    this.phone,
  });

  static User fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      companyName: json['companyName'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['companyName'] = this.companyName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
