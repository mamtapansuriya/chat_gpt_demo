import 'dart:async';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:demo/model/message_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  final apiKey = "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";
  RxBool isLoading = false.obs;
  TextEditingController textController = TextEditingController();

  StreamSubscription? subscription;
  late ChatGPT openAi;
  RxList<MessageModel> messageList = <MessageModel>[].obs;

  @override
  void onInit() {
    openAi = ChatGPT.instance.builder(apiKey);
    super.onInit();
  }

  sendMessage(String str) async {
    isLoading.value = true;
    final request = CompleteReq(
      prompt: str,
      model: kTranslateModelV3,
      max_tokens: 2000,
    );
    final result = await openAi.onCompleteText(request: request);

    messageList.insert(
      0,
      MessageModel(
        isBot: true,
        message: result?.choices.last.text.trim(),
      ),
    );
    textController.clear();
    isLoading.value = false;
  }

// Future<void> apiResponse(String text) async {
//   try {
//     isLoading.value = true;

//     final response = await http.post(
//       Uri.parse("https://api.openai.com/v1/completions"),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization':
//             ' Bearer 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',
//       },
//       body: jsonEncode(
//         {
//           "model": "text-davinci-003",
//           "prompt": "Say this is a test",
//           "max_tokens": 7,
//           "temperature": 0
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       responseData.value = welcomeFromJson(response.body);
//     } else {}

//     isLoading.value = false;
//   } catch (e) {
//     print("error in response---$e");
//   }
// }
}
