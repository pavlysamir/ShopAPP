class CategoriesModel{
  bool? status;
  dynamic? message;
  CategoriesDataModel? data;

  CategoriesModel.fromjson(Map<String , dynamic> json){
    status = json['status'];
    message = json['message'];
    data = CategoriesDataModel.fromjson(json['data']);
  }
}



class CategoriesDataModel{
  int? currentPage;
  List<DataModel>? data = [];

  CategoriesDataModel.fromjson(Map<String , dynamic> json){
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data!.add(DataModel.fromjson(element));
    });
  }

}

class DataModel{
  int? id;
  String? name;
  String? image;

  DataModel.fromjson(Map<String , dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }

}