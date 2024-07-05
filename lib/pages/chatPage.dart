import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hey_app/services/auth/authService.dart';
import 'package:hey_app/services/chat/chatService.dart';

import '../appColors.dart';

class ChatPage extends StatefulWidget {
  final String recieverEmail;
  final String recieverId;

  ChatPage({super.key, required this.recieverEmail, required this.recieverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // String chatName= recieverEmail;
  final TextEditingController _messageController = TextEditingController();

// chat and auth services
  final ChatService _chatService = ChatService();

  final AuthService _authService = AuthService();

  //textfield focus
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(
          Duration(milliseconds: 500),
          () => scrollDown(),
        );
      }
    });

    Future.delayed(Duration(milliseconds: 500),

            () => scrollDown()
    );

  }

  @override
  void dispose() {
    focusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller

  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(_scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds:50),curve:Easing.legacy );
  }

// send messages
  void sendMessages() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.recieverId, _messageController.text);
      _messageController.clear();
    }
    scrollDown();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appbar,
        title: Text(
          widget.recieverEmail.substring(0, widget.recieverEmail.indexOf('@')),
          style: TextStyle(color: AppColors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: AppColors.white),
        toolbarHeight: 70,
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          Container(
              color: AppColors.appbar,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Row(
                children: [
                  InkWell(
                    child: Icon(
                      Icons.add,
                      color: AppColors.white,
                      size: 24,
                    ),
                    onTap: () {},
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Container(
                      child: TextField(cursorColor: AppColors.black,
                        focusNode: focusNode,
                        controller: _messageController,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        minLines: 1,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Type your message here",
                          hintMaxLines: 1,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          hintStyle: const TextStyle(fontSize: 16),
                          fillColor: AppColors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: AppColors.white,
                              width: 0.2,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                              color: AppColors.white,
                              width: 0.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: InkWell(
                        child: const Icon(
                          Icons.send,
                          color: AppColors.white,
                          size: 24,
                        ),
                        onTap: sendMessages

                        //// () {
                        //   // if (_messageController.text.length != 0) {
                        //   //   setState(() {
                        //   //     chat.add(chatModel(text.text, myName));
                        //   //   });
                        //   //   text.text = "";
                        //   // }
                        // },
                        ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: _chatService.getMessages(widget.recieverId, senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text(
            "error",
            style: TextStyle(fontSize: 20, color: AppColors.white),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Column(
            children: [Center(
              child: CircularProgressIndicator(),
        ),
              Text(
                "Loading",
                style: TextStyle(fontSize: 20, color: AppColors.white),
              ),
            ],
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListView(
            controller: _scrollController,
            children:
                snapshot.data!.docs.map((doc) => _buildMessageItem(doc)).toList(),
          ),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    //bool isCurrentUser= data['senderID'] == _authService.getCurrentUser()?

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: BubbleSpecialThree(
        constraints: BoxConstraints(minHeight: 25, minWidth: 25),
        isSender:
            data['senderID'] == _authService.getCurrentUser()?.uid ? true : false,
        text: data["message"],
        color: data["senderID"] == _authService.getCurrentUser()?.uid
            ? AppColors.sender
            : AppColors.receiver,
        tail: true,
        textStyle: TextStyle(color: Colors.white, fontSize: 19),
      ),
    );
  }
}
