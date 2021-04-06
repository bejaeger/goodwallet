// PODO for non-profit organization

class Organization {
  final String name;
  final String url;

  Organization({this.name, this.url});

  Map<String, dynamic> toJson() {
    var returnJson = {
      'name': name,
      'url': url,
    };
    return returnJson;
  }

  static Organization fromMap(Map<String, dynamic> map) {
    var data = Organization(
      name: map["name"],
      url: map["url"],
    );
    return data;
  }
}
