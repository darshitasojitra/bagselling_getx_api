class ProductModel {
  String? message;
  bool? status;
  List<ProductData>? data;

  ProductModel({this.message, this.status, this.data});

  ProductModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <ProductData>[];
      json['data'].forEach((v) {
        data!.add(new ProductData.fromJson(v));
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

class ProductData {
  String? id;
  String? catid;
  String? subcatid;
  String? productname;
  String? productdescription;
  String? originalprice;
  String? sellingprice;
  String? option;
  String? image;

  ProductData(
      {this.id,
        this.catid,
        this.subcatid,
        this.productname,
        this.productdescription,
        this.originalprice,
        this.sellingprice,
        this.option,
        this.image});

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    catid = json['catid'];
    subcatid = json['subcatid'];
    productname = json['productname'];
    productdescription = json['productdescription'];
    originalprice = json['originalprice'];
    sellingprice = json['sellingprice'];
    option = json['option'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['catid'] = this.catid;
    data['subcatid'] = this.subcatid;
    data['productname'] = this.productname;
    data['productdescription'] = this.productdescription;
    data['originalprice'] = this.originalprice;
    data['sellingprice'] = this.sellingprice;
    data['option'] = this.option;
    data['image'] = this.image;
    return data;
  }
}
