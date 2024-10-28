class Review {
  String? id;
  String? created;
  String? updated;
  String? subject;
  String? commint;
  int? reviewPoint;
  int? user;
  String? product;

  Review(
      {this.id,
      this.created,
      this.updated,
      this.subject,
      this.commint,
      this.reviewPoint,
      this.user,
      this.product});

  Review.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    created = json['created'];
    updated = json['updated'];
    subject = json['subject'];
    commint = json['commint'];
    reviewPoint = json['review_point'];
    user = json['user'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created'] = this.created;
    data['updated'] = this.updated;
    data['subject'] = this.subject;
    data['commint'] = this.commint;
    data['review_point'] = this.reviewPoint;
    data['user'] = this.user;
    data['product'] = this.product;
    return data;
  }
}
