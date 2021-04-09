// PODO for non-profit organization

class Organization {
  final String? name;
  final String? url;

  Organization({this.name, this.url});

  Map<String, dynamic> toJson() {
    var returnJson = {
      'name': name,
      'url': url,
    };
    return returnJson;
  }
}
