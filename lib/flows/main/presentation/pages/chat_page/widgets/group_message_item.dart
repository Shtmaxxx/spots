import 'package:flutter/material.dart';
import 'package:spots/widgets/default_user_avatar.dart';

class GroupMessageItem extends StatelessWidget {
  const GroupMessageItem({
    required this.message,
    required this.time,
    required this.senderName,
    required this.sentByUser,
    super.key,
  });

  final String message;
  final String time;
  final String senderName;
  final bool sentByUser;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    const messageTextStyle = TextStyle(
      fontSize: 16,
    );
    final timeTextStyle = TextStyle(
      fontSize: 12,
      color: sentByUser
          ? Theme.of(context).primaryColorDark
          : Theme.of(context).hintColor,
      fontStyle: FontStyle.italic,
    );
    final nameMaxSize = (TextPainter(
      text: TextSpan(
        children: [
          TextSpan(text: message),
          TextSpan(
            text: time,
            style: const TextStyle(
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
      textScaleFactor: MediaQuery.of(context).textScaleFactor,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout())
        .size;

    return Padding(
      padding: EdgeInsets.only(
        top: 5,
        left: 10,
        right: width * 0.2,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          DefaultUserAvatar(letter: senderName[0], size: 35, fontSize: 18),
          const SizedBox(width: 5),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: sentByUser
                    ? Theme.of(context).primaryColorLight
                    : Colors.white,
              ),
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: nameMaxSize.width,
                    child: Text(
                      senderName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff27b8d9),
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            message,
                            style: messageTextStyle
                          ),
                        ),
                      ),
                      Text(
                        time,
                        style: timeTextStyle,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
