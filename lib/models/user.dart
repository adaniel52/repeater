import 'dart:convert';

class User {
  String? name;
  int? page;

  User({this.name, this.page});

  String toJson() => json.encode({
        'name': name,
        'page': page,
      });

  factory User.fromJson(String source) {
    final data = json.decode(source);
    return User(
      name: data['name'],
      page: data['page'],
    );
  }
}
