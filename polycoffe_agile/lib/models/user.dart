class User{
  String password,hoTen;
  String role,gioiTinh;
  String diaChi,avatar;
  String ngaySinh;
  String username;


  User(this.username, this.password, this.hoTen, this.role, this.gioiTinh,
      this.diaChi, this.avatar, this.ngaySinh);

  Map<String,dynamic> toJson() =>{
    "username" : username,
    "password" : password,
    "hoTen" : hoTen,
    "role" : role,
    "gioiTinh" : gioiTinh,
    "diaChi" : diaChi,
    "avatar" : avatar,
    "ngaySinh" : ngaySinh,

  };

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      json["username"].toString(),
      json["password".toString()],
      json["hoTen".toString()],
      json["role".toString()],
      json["gioiTinh".toString()],
      json["diaChi".toString()],
      json["avatar".toString()],
      json["ngaySinh".toString()],

    );
  }
}