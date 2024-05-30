class ProfilePicReqDataModel {
  String publicKey = '';
  String imageType = '';
  String fileName = '';
  String base64Image = '';

  ProfilePicReqDataModel(
      {required this.publicKey,
      required this.imageType,
      required this.fileName,
      required this.base64Image});

  ProfilePicReqDataModel.fromJson(Map<String, dynamic> json) {
    publicKey = json['publicKey'];
    imageType = json['imageType'];
    fileName = json['fileName'];
    base64Image = json['base64Image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publicKey'] = this.publicKey;
    data['imageType'] = this.imageType;
    data['fileName'] = this.fileName;
    data['base64Image'] = this.base64Image;
    return data;
  }
}
