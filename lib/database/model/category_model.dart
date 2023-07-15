class CategoryModel {
  String? category;

  CategoryModel({this.category});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['category'] = category;
    return data;
  }
}
