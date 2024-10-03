class Category {
  String? id;
  String? created;
  String? updated;
  String? titel;
  String? image;
  String? data;

  Category(
      {this.id, this.created, this.updated, this.titel, this.image, this.data});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    updated = json['updated'];
    titel = json['titel'];
    image = json['image'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['titel'] = this.titel;
    data['image'] = this.image;
    data['data'] = this.data;
    return data;
  }
}
