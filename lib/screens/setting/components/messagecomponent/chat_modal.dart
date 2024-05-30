class ChatModel {
  String name = "Name";
  String icon = "assets/images/users.png";
  String time = "";
  String? currentMessage;
  String? status;
  bool select;
  int id = 0;
  ChatModel({
    required this.name,
    required this.icon,
    required this.time,
    this.currentMessage,
    this.status,
    this.select = false,
    required this.id,
  });
}
