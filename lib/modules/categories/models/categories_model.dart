List<CategoryModel> categoriesResponseFromJson(dynamic json) =>
    List<CategoryModel>.from(json.map((x) => CategoryModel.fromJson(x)));

class CategoryModel {
  String slug;
  String name;
  String url;

  CategoryModel({
    required this.slug,
    required this.name,
    required this.url,
  });

  factory CategoryModel.empty() {
    return CategoryModel(slug: '', name: '', url: '');
  }
  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        slug: json["slug"],
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "slug": slug,
        "name": name,
        "url": url,
      };
}
