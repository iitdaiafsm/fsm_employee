class UserModel {
  String? name;
  String? email;
  String? profilePic;
  String? employeeType;
  String? mobile;

  UserModel(
      {this.name, this.email, this.profilePic, this.employeeType, this.mobile});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    profilePic = json['profile_pic'];
    employeeType = json['employee_type'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['profile_pic'] = profilePic;
    data['employee_type'] = employeeType;
    data['mobile'] = mobile;
    return data;
  }
}
