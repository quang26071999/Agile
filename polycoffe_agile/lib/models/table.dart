class Table {
  String maBan, trangThai, maHDT;

  Table(this.maBan, this.trangThai, this.maHDT);

  Map<String, dynamic> toJson() =>
      {
        "maBan": maBan,
        "trangThai": trangThai,
        "maHDT": maHDT,
      };

  factory Table.fromJson(Map<String, dynamic> json){
    return Table(json["maBan".toString()], json["trangThai".toString()],
        json["maHDT".toString()]);
  }
}