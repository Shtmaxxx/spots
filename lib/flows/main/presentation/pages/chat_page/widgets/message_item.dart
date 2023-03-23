import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    required this.message,
    required this.time,
    required this.sentByUser,
    super.key,
  });

  final String message;
  final String time;
  final bool sentByUser;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Align(
      alignment: sentByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(
          top: 5,
          left: sentByUser ? width * 0.2 : 10,
          right: sentByUser ? 10 : width * 0.2,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color:
                sentByUser ? Theme.of(context).primaryColorLight : Colors.white,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: Text(
                    message,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5, right: 10),
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: 12,
                    color: sentByUser
                        ? Theme.of(context).primaryColorDark
                        : Theme.of(context).hintColor,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
