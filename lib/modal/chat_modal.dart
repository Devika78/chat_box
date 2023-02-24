import 'package:chat_box/modal/user_modal.dart';

class ChatModal {
  int id;
  String? name;
  String chatType;
  UserModal sender;
  UserModal receiver;

  int createdAt;
  String? chatIconUrl;

  ChatModal(this.id, this.name, this.chatType, this.createdAt, this.chatIconUrl,
      this.sender, this.receiver);

  ChatModal.fromJson(json)
      : id = json['id'],
        name = json['name'],
        chatType = json['chatType'],
        sender = UserModal.fromJson(json['sender']),
        receiver = UserModal.fromJson(json['receiver']),
        createdAt = json['createdAt'],
        chatIconUrl = json['chatIconUrl'];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "chatType": chatType,
      "sender": sender.toJson(),
      "receiver": receiver.toJson(),
      "createdAt": createdAt,
      "chatIconUrl": chatIconUrl
    };
  }
}
