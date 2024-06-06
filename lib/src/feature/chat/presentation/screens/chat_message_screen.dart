import 'package:ayna_ws_assignment/src/app/theme/theme.dart';
import 'package:ayna_ws_assignment/src/feature/chat/data/repository/websocket_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/service/service_locator.dart';
import '../bloc/message/message_bloc.dart';
import 'widget/chat_bubble.dart';
import 'widget/send_text_tile.dart';

class ChatMessageScreen extends StatefulWidget {
  final String id;

  const ChatMessageScreen({
    super.key,
    required this.id,
  });

  @override
  State<ChatMessageScreen> createState() => _ChatMessageScreenState();
}

class _ChatMessageScreenState extends State<ChatMessageScreen> {
  late TextEditingController _messageController;
  late ScrollController _scrollController;
  late Size _screenSize;

  @override
  void initState() {
    _messageController = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _screenSize = MediaQuery.sizeOf(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      }
    });

    return BlocProvider(
      create: (context) => MessageBloc(
        widget.id,
        sl<WebsocketRepository>(),
      ),
      child: BlocBuilder<MessageBloc, MessageState>(
        builder: (context, state) {
          switch (state) {
            case WebsocketConnecting():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case WebsocketConnected(messageList: final messageList):
              return Scaffold(
                appBar: AppBar(
                  toolbarHeight: 48,
                  backgroundColor: AppTheme.kPurpleColor,
                  bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(0),
                    child: Divider(
                      height: 1,
                      color: Colors.black87,
                    ),
                  ),
                  title: Text('Chat Message ${widget.id}'),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height:
                                MediaQuery.of(context).viewInsets.bottom == 0
                                    ? _screenSize.height * 0.8
                                    : _screenSize.height * 0.4,
                            child: ListView.builder(
                              itemCount: messageList.length,
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              physics: const ClampingScrollPhysics(),
                              controller: _scrollController,
                              reverse: true,
                              itemBuilder: (context, i) => ChatBubble(
                                message: messageList[messageList.length - 1 - i]
                                    .message,
                                sendByMe:
                                    messageList[messageList.length - 1 - i]
                                        .sendByMe,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SendTextTile(
                      controller: _messageController,
                      focusNode: FocusNode(),
                      onSend: () {
                        context.read<MessageBloc>().add(
                              SendMessageEvent(
                                message: _messageController.text.trim(),
                              ),
                            );
                        _messageController.clear();
                      },
                    )
                  ],
                ),
              );
          }
        },
      ),
    );
  }
}
