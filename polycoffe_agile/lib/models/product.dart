class Product{
  String maSP,tenSP,hinhAnh;
  int gia;
  int maLoai;

  Product(this.maSP, this.tenSP, this.hinhAnh, this.gia, this.maLoai);

  Map<String,dynamic> toJson() =>{
    "masp": maSP,
    "tensp": tenSP,
    "hinhanh": hinhAnh,
    //Image.file(base64Decode(anhdaidien)) => widget ImageProvider
    // file la lay thang file
    // network la lay url
    "gia": gia,
    "maloai": maLoai
  };

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
       json['masp'].toString(), json['tensp'].toString(),json['hinhanh'].toString(), int.parse(json['gia'].toString()),int.parse(json['maloai'].toString())
    );
  }

}