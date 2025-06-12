class CategoryModel {
  String? message;
  bool? status;
  List<Data>? data;

  CategoryModel({this.message, this.status, this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? idss;
  String? catname;
  String? catdescription;
  String? image;

  Data({this.idss, this.catname, this.catdescription, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    idss = json['idss'];
    catname = json['catname'];
    catdescription = json['catdescription'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idss'] = this.idss;
    data['catname'] = this.catname;
    data['catdescription'] = this.catdescription;
    data['image'] = this.image;
    return data;
  }
}
