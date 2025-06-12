class SubcategoryModel {
  String? message;
  bool? status;
  List<Subcatdata>? data;

  SubcategoryModel({this.message, this.status, this.data});

  SubcategoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Subcatdata>[];
      json['data'].forEach((v) {
        data!.add(new Subcatdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcatdata {
  String? id;
  String? catid;
  String? subcatname;
  String? subcatdescription;
  String? image;

  Subcatdata(
      {this.id,
        this.catid,
        this.subcatname,
        this.subcatdescription,
        this.image});

  Subcatdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catid = json['catid'];
    subcatname = json['subcatname'];
    subcatdescription = json['subcatdescription'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['catid'] = this.catid;
    data['subcatname'] = this.subcatname;
    data['subcatdescription'] = this.subcatdescription;
    data['image'] = this.image;
    return data;
  }
}
