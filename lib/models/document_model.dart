import 'dart:convert';

DocumentModel documentModelFromJson(String str) => DocumentModel.fromJson(json.decode(str));

String documentModelToJson(DocumentModel data) => json.encode(data.toJson());

class DocumentModel {
  String type;
  String content;

  DocumentModel({
    this.type = 'PLAIN_TEXT',
    this.content = 'Joanne Rowling, who writes under the pen names J. K. Rowling and Robert Galbraith, is a British novelist and screenwriter who wrote the Harry Potter fantasy series.',
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) => DocumentModel(
    type: json["type"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "content": content,
  };
}