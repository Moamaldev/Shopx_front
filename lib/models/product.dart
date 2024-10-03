class Product {
  String? id;
  String? created;
  String? updated;
  String? titel;
  String? data;
  String? img;
  int? purchasingPrice;
  int? sellingPrice;
  String? description;
  Catagory? catagory;
  bool? favorit;

  Product(
      {this.id,
      this.created,
      this.updated,
      this.titel,
      this.data,
      this.img,
      this.purchasingPrice,
      this.sellingPrice,
      this.description,
      this.catagory,
      this.favorit});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    updated = json['updated'];
    titel = json['titel'];
    data = json['data'];
    img = json['img'];
    purchasingPrice = json['purchasing_price'];
    sellingPrice = json['selling_price'];
    description = json['description'];
    catagory = json['catagory'] != null
        ? new Catagory.fromJson(json['catagory'])
        : null;
    favorit = json['favorit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['titel'] = this.titel;
    data['data'] = this.data;
    data['img'] = this.img;
    data['purchasing_price'] = this.purchasingPrice;
    data['selling_price'] = this.sellingPrice;
    data['description'] = this.description;
    if (this.catagory != null) {
      data['catagory'] = this.catagory!.toJson();
    }
    data['favorit'] = this.favorit;
    return data;
  }
}

class Catagory {
  String? id;
  String? created;
  String? updated;
  String? titel;
  String? image;
  String? data;

  Catagory(
      {this.id, this.created, this.updated, this.titel, this.image, this.data});

  Catagory.fromJson(Map<String, dynamic> json) {
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
