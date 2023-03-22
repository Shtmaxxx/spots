import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spots/services/helpers/compare_dates.dart';
import 'package:spots/widgets/default_user_avatar.dart';

class ChatItem extends StatelessWidget {
  const ChatItem({
    required this.title,
    required this.recentMessage,
    required this.dateTime,
    required this.onPressed,
    super.key,
  });

  final String title;
  final String recentMessage;
  final DateTime dateTime;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: Ink(
          height: 75,
          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DefaultUserAvatar(
                letter: title[0].toUpperCase(),
                size: 50,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    recentMessage,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
              const Spacer(),
              if (dateTime.isToday()) ...{
                Text(
                  DateFormat.Hm().format(dateTime),
                ),
              } else ...{
                Text(
                  DateFormat('dd.MM').format(dateTime),
                ),
              },
            ],
          ),
        ),
      ),
    );
  }
}
