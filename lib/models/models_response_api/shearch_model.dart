class SearchModel {
  bool? status;
  Null? message;
  DataBigger? data;

  SearchModel({this.status, this.message, this.data});

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new DataBigger.fromJson(json['data']) : null;
  }
}

class DataBigger {
  num? currentPage;
  List<Product>? data;
  String? firstPageUrl;
  num? from;
  num? lastPage;
  String? lastPageUrl;
  Null? nextPageUrl;
  String? path;
  num? perPage;
  Null? prevPageUrl;
  num? to;
  num? total;

  DataBigger.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(new Product.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class Product {
  num? id;
  num? price;
  num? oldPrice;
  num? discount;
  String? image;
  String? name;
  String? description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}
