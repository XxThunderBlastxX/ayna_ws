import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../../app/common/widget/styled_field.dart';
import '../../../../../app/theme/theme.dart';

AppBar chatHomeAppBar({
  required TextEditingController usernameController,
  required BuildContext context,
  required void Function() onLogout,
  required void Function() onNewChat,
}) {
  return AppBar(
    toolbarHeight: 68,
    backgroundColor: AppTheme.kLightBlueColor,
    bottom: const PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: Divider(
        height: 0,
        thickness: 1,
        color: Colors.black87,
      ),
    ),
    actions: [
      ElevatedButton(
        onPressed: () => showDialog(
          context: context,
          builder: (_) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: const BorderSide(
                color: Colors.black87,
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('New Chat'),
                  const Gap(10),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    child: StyledField(
                      label: 'Enter Username',
                      controller: usernameController,
                    ),
                  ),
                  const Gap(12),
                  ElevatedButton(
                    onPressed: onNewChat,
                    child: Text(
                      'Start Chat',
                      style: AppTheme.theme.textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(12.0),
        ),
        child: Text(
          'New Chat',
          style: AppTheme.theme.textTheme.labelMedium,
        ),
      ),
      const Gap(12),
      IconButton(
        icon: const Icon(Icons.logout),
        onPressed: onLogout,
      ),
    ],
    title: Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Text('Chat', style: AppTheme.theme.textTheme.labelLarge),
    ),
    centerTitle: false,
  );
}
