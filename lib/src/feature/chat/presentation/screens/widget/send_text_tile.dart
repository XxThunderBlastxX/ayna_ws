import 'package:flutter/material.dart';

import '../../../../../app/theme/theme.dart';

class SendTextTile extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final VoidCallback? onSend;

  const SendTextTile({
    super.key,
    this.controller,
    this.focusNode,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: AppTheme.kPurpleColor,
            width: 1.2,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 8.0,
          left: 8.0,
          right: 8.0,
          top: 0.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width * 0.825,
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                keyboardType: TextInputType.text,
                maxLines: 3,
                minLines: 1,
                style: AppTheme.theme.textTheme.labelMedium,
                decoration: InputDecoration(
                  hintText: 'Type a message',
                  hintStyle: AppTheme.theme.textTheme.labelMedium,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: AppTheme.kPurpleColor,
                      width: 1.2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(
                      color: AppTheme.kPurpleColor,
                      width: 1.2,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  contentPadding: const EdgeInsets.all(12.0),
                ),
              ),
            ),
            IconButton(
              onPressed: onSend,
              icon: const Icon(
                Icons.send,
                color: AppTheme.kPurpleColor,
                size: 28.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
