// To parse this JSON data, do
//
//     final message2 = message2FromJson(jsonString);

import 'dart:convert';

class Message {
  Message({
    this.message,
  });

  String? message;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    message: json["message"] == null ? "" : json["message"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? "" : message,
  };
}

Message2 message2FromJson(String str) => Message2.fromJson(json.decode(str));

String message2ToJson(Message2 data) => json.encode(data.toJson());

class Message2 {
  String? appName;
  String? version;
  String? build;
  MessageDetail? response;

  Message2({
    this.appName,
    this.version,
    this.build,
    this.response,
  });

  factory Message2.fromJson(Map<String, dynamic> json) => Message2(
    appName: json["app_name"],
    version: json["version"],
    build: json["build"],
    response: json["response"] == null
        ? null
        : MessageDetail.fromJson(json["response"]),
  );

  Map<String, dynamic> toJson() => {
    "app_name": appName,
    "version": version,
    "build": build,
    "response": response?.toJson(),
  };
}

class MessageDetail {
  String? messageEn;
  String? messageId;

  MessageDetail({
    this.messageEn,
    this.messageId,
  });

  factory MessageDetail.fromJson(Map<String, dynamic> json) => MessageDetail(
    messageEn: json["message_en"],
    messageId: json["message_id"],
  );

  Map<String, dynamic> toJson() => {
    "message_en": messageEn,
    "message_id": messageId,
  };
}
