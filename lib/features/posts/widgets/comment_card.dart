import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone/models/comment_model.dart';
import 'package:reddit_clone/responsive/reponsive.dart';
import 'package:routemaster/routemaster.dart';

class CommentCard extends ConsumerWidget {
  final Comment comment;
  const CommentCard({
    super.key,
    required this.comment,
  });

  void navigateToUserProfile(BuildContext context) {
    Routemaster.of(context).push('/u/${comment.userID}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Responsive(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 4,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => navigateToUserProfile(context),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      comment.profilePic,
                    ),
                    radius: 18,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'u/${comment.username}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(comment.text)
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.reply),
                ),
                const Text('Reply'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
