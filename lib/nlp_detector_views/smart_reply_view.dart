import 'package:flutter/material.dart';
import 'package:google_mlkit_smart_reply/google_mlkit_smart_reply.dart';

import '../colors.dart';
import '../utils/custom_textfield.dart';
import '../utils/elevated_btn.dart';

class SmartReplyView extends StatefulWidget {
  @override
  State<SmartReplyView> createState() => _SmartReplyViewState();
}

class _SmartReplyViewState extends State<SmartReplyView> {
  final _localUserController = TextEditingController();
  final _remoteUserController = TextEditingController();
  SmartReplySuggestionResult? _suggestions;

  final SmartReply _smartReply = SmartReply();

  @override
  void dispose() {
    _smartReply.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Smart Reply'),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                SizedBox(height: 30),
                Text('Local User'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child:
                  Container(
                    height: 45,
                    child: TextFormFieldCustom(
                      controller: _localUserController,
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                ElevatedBtn(
                    onPressed: () => _addMessage(_localUserController, true),
                    text: 'Add message to conversation',color: downloadColor),
                SizedBox(height: 26),
                Text('Remote User'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child:
                  Container(
                    height: 45,
                    child: TextFormFieldCustom(
                      controller: _remoteUserController,
                    ),
                  ),
                ),
                ElevatedBtn(
                    onPressed: () =>
                        _addMessage(_remoteUserController, false),
                    text: 'Add message to conversation',color: readColor),
                SizedBox(height: 30),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (_smartReply.conversation.isNotEmpty)
                        ElevatedButton(
                            onPressed: () {
                              _smartReply.clearConversation();
                              setState(() {
                                _suggestions = null;
                              });
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(clearColor!),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ))),
                            child: Text('Clear conversation')),
                      ElevatedButton(
                          onPressed: _suggestReplies,
                          style: ButtonStyle(
                            //  backgroundColor: MaterialStateProperty.all<Color>(color!),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ))),
                          child: Text('Get Suggest Replies')),
                    ]),
                SizedBox(height: 30),
                if (_suggestions != null)
                  Text('Status: ${_suggestions!.status.name}'),
                if (_suggestions != null &&
                    _suggestions!.suggestions.isNotEmpty)
                  for (final suggestion in _suggestions!.suggestions)
                    Text('\t $suggestion'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addMessage(TextEditingController controller, bool localUser) {
    FocusScope.of(context).unfocus();
    if (controller.text.isNotEmpty) {
      if (localUser) {
        _smartReply.addMessageToConversationFromLocalUser(
            controller.text, DateTime.now().millisecondsSinceEpoch);
      } else {
        _smartReply.addMessageToConversationFromRemoteUser(
            controller.text, DateTime.now().millisecondsSinceEpoch, 'userZ');
      }
      controller.text = '';
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Message added to the conversation')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Message can\'t be empty')));
    }
  }

  Future<void> _suggestReplies() async {
    FocusScope.of(context).unfocus();
    final result = await _smartReply.suggestReplies();
    setState(() {
      _suggestions = result;
    });
  }
}
