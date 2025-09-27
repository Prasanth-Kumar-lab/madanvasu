class CategoriesModel {
  final bool status;
  final List<CategoryData> data;

  CategoriesModel({required this.status, required this.data});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => CategoryData.fromJson(item))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class CategoryData {
  final String id;
  final String propertyCategoryTitle;
  final String propertyCategoryicon;


  CategoryData({required this.id, required this.propertyCategoryTitle,required this.propertyCategoryicon});

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'] ?? '',
      propertyCategoryTitle: json['property_category_title'] ?? '',
      propertyCategoryicon: json['property_category_icon'] ?? '',

    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'property_category_title': propertyCategoryTitle,
      'property_category_icon' : propertyCategoryicon,
    };
  }
}





