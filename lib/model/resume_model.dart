class Resume {
  final int? id;
  final String? name;
  final String? gender;
  final int? age;
  final String? currentCTC;
  final String? expectedCTC;
  final String? image;
  final String? resumePdf;
  final String? skils;
  final DateTime? createdTime;
  Resume(
      {this.id,
      this.name,
      this.age,
      this.createdTime,
      this.gender,
      this.skils,
      this.image,
      this.currentCTC,
      this.expectedCTC,
      this.resumePdf});

  factory Resume.fromJson(Map<String, dynamic> json) => Resume(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        gender: json["gender"],
        createdTime: DateTime.parse(json["createTime"]),
        currentCTC: json["currentCTC"],
        expectedCTC: json["expectedCTC"],
        resumePdf: json["resumePdf"],
        image: json["image"],
        skils: json['skills'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gender": gender,
        "age": age,
        "currentCTC": currentCTC,
        "expectedCTC": expectedCTC,
        "image": image,
        "resumePdf": resumePdf,
        "skills": skils,
        "createTime": createdTime.toString(),
      };
}
