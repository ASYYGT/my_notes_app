class NoteModel {
  dynamic id;
  dynamic title;
  dynamic value;
  dynamic materialityId;
  NoteModel({this.id, this.title, this.value, this.materialityId});
  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
        id: json["Id"],
        title: json["Title"],
        value: json["Value"],
        materialityId: json["MaterialityId"]);
  }
  Map<String, dynamic> toJson() => {
        "Id": id,
        "Title": title,
        "Value": value,
        "MaterialityId": materialityId
      };
}
