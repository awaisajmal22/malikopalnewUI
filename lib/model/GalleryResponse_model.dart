class GalleryResponseModel {
  List<GalleryResponseDataModel>? data;
  String? message;
  List<String>? errorList;

  GalleryResponseModel({this.data, this.message, this.errorList});

  GalleryResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['Data'] != null) {
      data = <GalleryResponseDataModel>[];
      json['Data'].forEach((v) {
        data!.add(new GalleryResponseDataModel.fromJson(v));
      });
    }
    message = json['Message'];
    errorList = json['ErrorList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['Message'] = this.message;
    data['ErrorList'] = this.errorList;
    return data;
  }
}

class GalleryResponseDataModel {
  num? id;
  String? title;
  String? description;
  String? date;
  bool? pined;
  List<ImagesModel>? images;

  GalleryResponseDataModel(
      {this.id,
      this.title,
      this.description,
      this.date,
      this.pined,
      this.images});

  GalleryResponseDataModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    title = json['Title'];
    description = json['Description'];
    date = json['Date'];
    pined = json['Pined'];
    if (json['Images'] != null) {
      images = <ImagesModel>[];
      json['Images'].forEach((v) {
        images!.add(new ImagesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Title'] = this.title;
    data['Description'] = this.description;
    data['Date'] = this.date;
    data['Pined'] = this.pined;
    if (this.images != null) {
      data['Images'] = this.images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImagesModel {
  num? id;
  String? path;

  ImagesModel({this.id, this.path});

  ImagesModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    path = json['Path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Path'] = this.path;
    return data;
  }
}
