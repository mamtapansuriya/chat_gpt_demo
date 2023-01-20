import 'package:demo/controller/chat_controller.dart';
import 'package:demo/model/message_model.dart';
import 'package:demo/screen/treedots.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

final ChatController _controller = Get.put(ChatController());

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Chat GPT"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Expanded(child: Obx(() {
                return ListView.separated(
                  reverse: true,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: _controller.messageList.length,
                  itemBuilder: (context, index) {
                    return Align(
                      alignment: _controller.messageList[index].isBot == true
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        margin: _controller.messageList[index].isBot == true
                            ? const EdgeInsets.only(right: 20)
                            : const EdgeInsets.only(left: 20),
                        decoration: BoxDecoration(
                            color: _controller.messageList[index].isBot == true
                                ? Colors.blue.withOpacity(0.20)
                                : Colors.blue.withOpacity(0.70),
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Text(_controller.messageList[index].message
                              .toString()),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                );
              })),
              Obx(
                () => _controller.isLoading.value
                    ? const ThreeDots()
                    : const SizedBox(),
              ),
              const SizedBox(
                width: 1,
              ),
              const Divider(
                height: 7,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 8,
                    child: TextFormField(
                      controller: _controller.textController,
                      decoration: const InputDecoration(
                        labelText: "Any Text",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 3,
                          ),
                        ), //normal border
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(
                            color: Colors.blue,
                            width: 3,
                          ),
                        ), //enabled border
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Colors.greenAccent,
                            width: 3,
                          ),
                        ), //focused border
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 55,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue),
                      child: IconButton(
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _controller.messageList.insert(
                              0,
                              MessageModel(
                                  isBot: false,
                                  message:
                                      _controller.textController.text.trim()));
                          _controller
                              .sendMessage(_controller.textController.text);
                        },
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
