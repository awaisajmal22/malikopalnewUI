import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:malikopal/bloc/dash_board_bloc.dart';
import 'package:malikopal/model/MessageHistoryResponse_model.dart';
import 'package:malikopal/model/requestbody/SaveMessageReqBody_model.dart';
import 'package:malikopal/networking/ApiResponse.dart';
import 'package:malikopal/screens/setting/components/setting.widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:malikopal/utils/shared_pref.dart';

import '../widgets/loading_dialog.dart';
import 'components/messagecomponent/chat_modal.dart';

class MessageScreen extends StatefulWidget {
  MessageScreen({Key? key, this.chatmodels, this.sourchat}) : super(key: key);
  static const routeName = '/Message-screen';
  final ChatModel? chatmodels;
  final ChatModel? sourchat;

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  bool show = false;
  FocusNode focusNode = FocusNode();
  bool sendButton = false;
  // List<MessageModel> getmessageList = [];
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();

  SessionData dataa = SessionData();

  // late List<MessageModel> chatLoad;

  // void sendMessage(String message, int sourceId, int targetId) {
  //   setMessage("source", message);
  //   // socket.emit("message",
  //   //     {"message": message, "sourceId": sourceId, "targetId": targetId});
  // }

  // loadSharedPrefs() async {
  //   try {
  //     List<MessageModel> chatModel = await dataa.read("chat");
  //     print("ChatModel Dataa_-->>$chatModel");
  //     if (chatModel.isNotEmpty) {
  //       setState(() {
  //         getmessageList = chatModel;
  //       });
  //       print("get Message List---> $getmessageList.length");

  //       print(chatModel.length);
  //     } else {
  //       print("List empty");
  //     }
  //   } catch (Excepetion) {
  //     print("Nothing Found ");
  //   }
  // }

  // void setMessage(String type, String message) async {
  //   var time = DateTime.now().toString().substring(10, 16);
  //   MessageModel messageModel =
  //       MessageModel(message: message, type: type, time: time);
  //   dataa.save("chat", messageModel);
  //   print("Saved----->$messageModel");
  //   setState(() {
  //     getmessageList.add(messageModel);
  //   });
  // }

  late DashBoardBloc _bloc;
  List<MessageHistoryResponseDataModel>? data;
  @override
  void initState() {
    _bloc = DashBoardBloc();
    _bloc..GetMessageHistoryData();

    _bloc.SaveMessageStream.listen((event) {
      if (event.status == Status.COMPLETED) {
        DialogBuilder(context).hideLoader();
        print("Data Saved-->");
      } else if (event.status == Status.ERROR) {
        DialogBuilder(context).hideLoader();
        print("Failed to Saved-->");

        // showSnackBar(context, event.message, true);
      } else if (event.status == Status.LOADING) {
        DialogBuilder(context).showLoader();
      }
    });

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var shortestSide = MediaQuery.of(context).size.shortestSide;

// Determine if we should use mobile layout or not, 600 here is
// a common breakpoint for a typical 7-inch tablet.
    final bool useMobileLayout = shortestSide < 600;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            CustomTopBar(topbartitle: 'Messaging'),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ClampingScrollPhysics(),
              child: Container(
                height: useMobileLayout ? size.height * 0.8 : size.height * 0.9,
                width: size.width,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(0.4),
                      blurRadius: 5.h,
                      spreadRadius: 3.w,
                      offset: Offset(1.h, 4.w),
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(
                  horizontal: 12,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15.0,
                      ),
                      child: ListTile(
                        leading: SvgPicture.asset(
                          'assets/svg/usericon.svg',
                          height: 50.h,
                          width: 50.h,
                        ),
                        title: Text(
                          '100143',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 13.sp,
                                    color: Color(0xffEB2027),
                                    fontWeight: FontWeight.w300,
                                  ),
                        ),
                        subtitle: Text(
                          'Junaid Bhutt',
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 300,
                        color: Colors.grey.shade100,
                        child: StreamBuilder<
                                ApiResponse<List<MessageHistoryResponseDataModel>>>(
                            stream: _bloc.GetMessageHistoryStream,
                            builder: (context,
                                AsyncSnapshot<
                                        ApiResponse<
                                            List<MessageHistoryResponseDataModel>>>
                                    snapshot) {
                              if (!snapshot.hasData) print("List Empty");
                              var items = snapshot.data?.data;

                              return ListView.builder(
                                shrinkWrap: true,
                                controller: _scrollController,
                                itemCount: items?.length,
                                itemBuilder: (context, index) {
                                  if (index == items?.length) {
                                    return Container(
                                      height: 70,
                                    );
                                  }
                                  ;
                                  // if (items?[index].sentBy == "sender")
                                  if (index % 3 == 0) {
                                    return OwnMessageCard(
                                      text: items?[index].text ?? "Sender",
                                      entry_date: items?[index].entryDate ?? "",
                                      sentBy: "sender",
                                      viewed: false,
                                    );
                                  } else {
                                    return ReplyCard(
                                      text: items?[index].text ?? "Receiver",
                                      entry_date: items?[index].entryDate ?? "",
                                      sentBy: "receiver",
                                    );
                                  }
                                },
                              );
                            }),
                      ),
                    ),
                    // BuildInputField(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: KeyboardVisibilityBuilder(
                          builder: (context, visible) {
                        return Container(
                          height: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              FittedBox(
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width -
                                          60,
                                      child: Card(
                                        margin: EdgeInsets.only(
                                            left: 2, right: 2, bottom: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                        child: TextFormField(
                                          controller: _controller,
                                          focusNode: focusNode,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 5,
                                          minLines: 1,
                                          onChanged: (value) {
                                            if (value.length > 0) {
                                              setState(() {
                                                sendButton = true;
                                              });
                                            } else {
                                              setState(() {
                                                sendButton = false;
                                              });
                                            }
                                          },
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            hintText: "Type a message",
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            prefixIcon: IconButton(
                                              icon: Icon(
                                                show
                                                    ? Icons.keyboard
                                                    : Icons
                                                        .emoji_emotions_outlined,
                                              ),
                                              onPressed: () {
                                                if (!show) {
                                                  focusNode.unfocus();
                                                  focusNode.canRequestFocus =
                                                      false;
                                                }
                                                setState(() {
                                                  show = !show;
                                                });
                                              },
                                            ),
                                            // suffixIcon: Row(
                                            //   mainAxisSize: MainAxisSize.min,
                                            //   children: [
                                            //     // IconButton(
                                            //     //   icon:
                                            //     //       Icon(Icons.attach_file),
                                            //     //   onPressed: () {
                                            //     //     showModalBottomSheet(
                                            //     //         backgroundColor:
                                            //     //             Colors
                                            //     //                 .transparent,
                                            //     //         context: context,
                                            //     //         builder: (builder) =>
                                            //     //             bottomSheet());
                                            //     //   },
                                            //     // ),
                                            //   ],
                                            // ),
                                            // contentPadding: EdgeInsets.all(5),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8,
                                        right: 2,
                                        left: 2,
                                      ),
                                      child: CircleAvatar(
                                        radius: 25,
                                        backgroundColor: sendButton
                                            ? Color(0xFF128C7E)
                                            : Colors.grey.withOpacity(0.6),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.send,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            var time = DateTime.now()
                                                .toString()
                                                .substring(10, 16);
                                            if (sendButton) {
                                              if (_controller.text.isNotEmpty) {
                                                var dataa =
                                                    SaveMessageReqBodyDataModel(
                                                        iD: 1,
                                                        entryDate: time,
                                                        profileID: 1,
                                                        sentBy: "User",
                                                        text: _controller.text,
                                                        viewDate: time,
                                                        viewed: false);
                                                _bloc.SaveMessageData(dataa);
                                              }
                                              _controller.clear();
                                              setState(() {
                                                sendButton = false;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // show ? emojiSelect() : Container(),
                            ],
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 278,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.all(18.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      Icons.insert_drive_file, Colors.indigo, "Document"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.camera_alt, Colors.pink, "Camera"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(
                      Icons.insert_photo,
                      Color(0xff254180),
                      // Colors.purple,
                      "Gallery"),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(Icons.headset, Colors.orange, "Audio"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.location_pin, Colors.teal, "Location"),
                  SizedBox(
                    width: 40,
                  ),
                  iconCreation(Icons.person, Colors.blue, "Contact"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(IconData icons, Color color, String text) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icons,
              // semanticLabel: "Help",
              size: 29,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              // fontWeight: FontWeight.w100,
            ),
          )
        ],
      ),
    );
  }
}

class BuildInputField extends StatefulWidget {
  const BuildInputField({Key? key}) : super(key: key);

  @override
  State<BuildInputField> createState() => _BuildInputFieldState();
}

class _BuildInputFieldState extends State<BuildInputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Edit text
          Flexible(
            child: Container(
              child: TextField(
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15.0),
                // controller: textEditingController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Start Type Here',
                  hintStyle: Theme.of(context).textTheme.subtitle1!.copyWith(
                        fontSize: 13.sp,
                        color: Color(0xff707070),
                        fontWeight: FontWeight.w300,
                      ),
                ),
                // focusNode: focusNode,
              ),
            ),
          ),
          Material(
            child: new Container(
              margin: new EdgeInsets.symmetric(horizontal: 20.0),
              child: new SvgPicture.asset(
                'assets/svg/send.svg',
                height: 22.h,
                width: 22.h,
              ),
            ),
            color: Colors.white,
          ),
          // color: Colors.white,
        ],
      ),
      width: double.infinity,
      height: 55.h,
      decoration: new BoxDecoration(
          border: new Border(top: new BorderSide(width: 0.5)),
          color: Colors.white),
    );
  }
}

class OwnMessageCard extends StatelessWidget {
  const OwnMessageCard(
      {Key? key,
      this.Id,
      this.profileId,
      required this.sentBy,
      this.viewed_Data,
      required this.viewed,
      required this.text,
      required this.entry_date})
      : super(key: key);
  final int? Id;
  final int? profileId;
  final String text;
  final String sentBy;
  final String? viewed_Data;
  final bool viewed;
  final String? entry_date;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Color(0xffdcf8c6),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 30,
                  top: 5,
                  bottom: 24,
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        entry_date!,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        viewed ? Icons.done_all : Icons.done,
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReplyCard extends StatelessWidget {
  const ReplyCard(
      {Key? key,
      this.Id,
      this.profileId,
      required this.sentBy,
      required this.text,
      required this.entry_date})
      : super(key: key);
  final int? Id;
  final int? profileId;
  final String text;
  final String sentBy;
  final String? entry_date;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
        ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          // color: Color(0xffdcf8c6),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 50,
                  top: 5,
                  bottom: 10,
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(
                  entry_date!,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
