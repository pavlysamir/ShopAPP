class HomeModel {
  bool? status;
  Data? data;

  HomeModel({this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['status'] = this.status;
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   return data;
  // }
}

class Data {
  List<Banners>? banners;
  List<Products>? products;
  dynamic? ad;

  Data({this.banners, this.products, this.ad});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['banners'] != null) {
      banners = <Banners>[];
      json['banners'].forEach((v) {
        banners!.add(new Banners.fromJson(v));
      });
    }
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    ad = json['ad'] as String;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   if (this.banners != null) {
  //     data['banners'] = this.banners!.map((v) => v.toJson()).toList();
  //   }
  //   if (this.products != null) {
  //     data['products'] = this.products!.map((v) => v.toJson()).toList();
  //   }
  //   data['ad'] = this.ad;
  //   return data;
  // }
}

class Banners {
  int? id;
  dynamic? image;
  dynamic category;
  dynamic product;

  Banners({this.id, this.image, this.category, this.product});

  Banners.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'] as String;
    category = json['category'];
    product = json['product'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = this.id;
  //   data['image'] = this.image;
  //   data['category'] = this.category;
  //   data['product'] = this.product;
  //   return data;
  // }
}

class Products {
  int? id;
  num? price;
  num? oldPrice;
  num? discount;
  dynamic? image;
  dynamic? name;
  dynamic? description;
  List<dynamic>? images;
  bool? inFavorites;
  bool? inCart;

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'] as String;
    name = json['name'] as String;
    description = json['description'] as String;
    images = json['images'].cast<String>() ;
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['id'] = this.id;
  //   data['price'] = this.price;
  //   data['old_price'] = this.oldPrice;
  //   data['discount'] = this.discount;
  //   data['image'] = this.image;
  //   data['name'] = this.name;
  //   data['description'] = this.description;
  //   data['images'] = this.images;
  //   data['in_favorites'] = this.inFavorites;
  //   data['in_cart'] = this.inCart;
  //   return data;
  // }
}