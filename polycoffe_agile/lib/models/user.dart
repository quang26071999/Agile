class User{
  String username,password,hoTen;
  int role,gioiTinh;
  String diaChi,avatar;
  String ngaySinh;
  int phone;


  User(this.username, this.password, this.hoTen, this.role, this.gioiTinh,
      this.diaChi, this.avatar, this.ngaySinh, this.phone);

  Map<String,dynamic> toJson() =>{
    "username" : username,
    "password" : password,
    "hoTen" : hoTen,
    "role" : role,
    "gioiTinh" : gioiTinh,
    "diaChi" : diaChi,
    "avatar" : avatar,
    "ngaySinh" : ngaySinh,
    "phone" : phone
  };

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      json["username".toString()],
      json["password".toString()],
      json["hoTen".toString()],
      int.parse(json["role"].toString()),
      int.parse(json["gioiTinh"].toString()),
      json["diaChi".toString()],
      json["avatar".toString()],
      json["ngaySinh".toString()],
      int.parse(json["phone"].toString())
    );
  }
}