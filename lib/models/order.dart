class order {
  String? id;
  String? created;
  String? updated;
  String? status;
  List<Map<String, dynamic>>? productsList; // تغيير هنا
  String? total;
  String? email;
  String? phone;
  String? address;
  String? paymentMethod;
  int? user;

  order({
    this.id,
    this.created,
    this.updated,
    this.status,
    this.productsList,
    this.total,
    this.email,
    this.phone,
    this.address,
    this.paymentMethod,
    this.user,
  });

  order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    updated = json['updated'];
    status = json['Status'];
    if (json['products_list'] != null) {
      productsList = List<Map<String, dynamic>>.from(json['products_list']);
    }
    total = json['total'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    paymentMethod = json['payment_method'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created'] = created;
    data['updated'] = updated;
    data['Status'] = status;
    if (productsList != null) {
      data['products_list'] = productsList;
    }
    data['total'] = total;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['payment_method'] = paymentMethod;
    data['user'] = user;
    return data;
  }
}
