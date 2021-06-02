import 'dart:async';

import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_home/presentation/bloc/communication/communication_cubit.dart';
import 'package:e_home/screens/Screen_Chatroom/components/mobile_message_layout.dart';
//import 'package:e_home/presentation/pages/widget/message_layout.dart';
import 'package:intl/intl.dart';
import 'package:responsive_builder/responsive_builder.dart';

class ChatroomPage extends StatefulWidget {
  final String uid;
  final String userName;

  const ChatroomPage({Key key, this.uid, this.userName}) : super(key: key);

  @override
  _ChatroomPageState createState() => _ChatroomPageState();
}

class _ChatroomPageState extends State<ChatroomPage> {
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController=ScrollController();
  @override
  void initState() {
    BlocProvider.of<CommunicationCubit>(context).getTextMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunicationCubit,CommunicationState>(
      builder: (context,state){
        if (state is CommunicationLoaded){
          return _bodyWidget(state);
        }
        return _loadingWidget();
      },
    );
  }
  Widget _bodyWidget(CommunicationLoaded messages) {
    return Scaffold(
      body: Stack(
        children: [

          Column(
            children: [
              _headerWidget(),
              _listMessagesWidget(messages),
              _sendTextMessageWidget(),
            ],
          ),
        ],
      ),
    );
  }
  Widget _loadingWidget(){
    return Scaffold(
      body: Stack(
        children: [

          Column(
            children: [
              _headerWidget(),
              Expanded(child: Center(child: CircularProgressIndicator(),)),
              _sendTextMessageWidget(),
            ],
          ),
        ],
      ),
    );
  }
  Widget _headerWidget() {
    return Container(
      padding: EdgeInsets.only(left: 15,right: 15,top: 20),
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.indigo[400],
              Colors.blue[300],
            ],
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [

              Text(
                "Chat Room",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            "${widget.userName}",
            style: TextStyle(
              fontSize: 22,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  Widget _listMessagesWidget(CommunicationLoaded messages) {
    Timer(
        Duration(milliseconds: 100),
            () => _scrollController
            .jumpTo(_scrollController.position.maxScrollExtent));
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: messages.messages.length,
          itemBuilder: (_, index) {
            return messages.messages[index].senderId ==
                widget.uid
                ? MobileMessageLayout(
              type: messages.messages[index].type,
              senderId: messages.messages[index].senderId,
              senderName:
              messages.messages[index].senderName,
              text: messages.messages[index].message,
              time: DateFormat('hh:mm a').format(
                  messages.messages[index].time.toDate()),
              color: Colors.green[300],
              align: TextAlign.left,
              nip: BubbleNip.rightTop,
              boxAlignment: CrossAxisAlignment.end,
              boxMainAxisAlignment: MainAxisAlignment.end,
              uid: widget.uid,)
                : MobileMessageLayout(
              type: messages.messages[index].type,
              senderName:
              messages.messages[index].senderName,
              text: messages.messages[index].message,
              time: DateFormat('hh:mm a').format(
                  messages.messages[index].time.toDate()),
              color: Colors.blue,
              align: TextAlign.left,
              nip: BubbleNip.leftTop,
              boxAlignment: CrossAxisAlignment.start,
              boxMainAxisAlignment: MainAxisAlignment.start,
            );
          },
        ),
      ),
    );
  }

  Widget _sendTextMessageWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(0.0)),
            border: Border.all(color: Colors.black.withOpacity(.4), width: 2)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                _emojiWidget(),
                SizedBox(
                  width: 8,
                ),
                _textFieldWidget(),
              ],
            ),
            Row(
              children: [
                _micWidget(),
                SizedBox(
                  width: 8,
                ),
                _sendMessageButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  _emojiWidget() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: Icon(
        Icons.emoji_symbols,
        color: Colors.white,
      ),
    );
  }

  _micWidget() {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
          color: Colors.black.withOpacity(.2),
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: Icon(
        Icons.mic,
        color: Colors.white,
      ),
    );
  }

  _textFieldWidget() {
    return ResponsiveBuilder(
      builder: (_, sizingInformation) {
        return Container(
          width: sizingInformation.screenSize.width * 0.40,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 60,
            ),
            child: Scrollbar(
              child: TextField(
                controller: _messageController,
                maxLines: null,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Type Here Dude ..."),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sendMessageButton() {
    return InkWell(
      onTap: () {
        if (_messageController.text.isNotEmpty) {
          _sendTextMessage();
          _messageController.clear();
        }
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }

  void _sendTextMessage() {
    BlocProvider.of<CommunicationCubit>(context).sendTextMsg(
        uid: widget.uid,
        name: widget.userName,
        message: _messageController.text);
  }
}
