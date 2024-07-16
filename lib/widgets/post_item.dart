import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostItem extends StatefulWidget {
  final DocumentSnapshot<Object?> postSnapshot;
  final DocumentSnapshot<Object?> userSnapshot;

  const PostItem({
    super.key,
    required this.postSnapshot,
    required this.userSnapshot,
  });

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {

    String calculateTimeAgo() {
    Timestamp timestamp = widget.postSnapshot['time']; 
    DateTime postDateTime = timestamp.toDate();
    DateTime now = DateTime.now();

    Duration difference = now.difference(postDateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inDays < 365) {
      int months = (difference.inDays / 30).floor();
      return '${months} ${months == 1 ? 'month' : 'months'} ago';
    } else {
      int years = (difference.inDays / 365).floor();
      return '${years} ${years == 1 ? 'year' : 'years'} ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          const SizedBox(height: 20,),
          Row(
            children: [
              const SizedBox(width: 15),
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(widget.userSnapshot['profileImageUrl']),
              ),
              const SizedBox(width: 10),
              Text(widget.userSnapshot['displayName'], style: const TextStyle(fontSize: 18),),
              Spacer(),
              const Icon(Icons.circle, size: 7.5,),
              const SizedBox(width: 3),
              const Icon(Icons.circle, size: 7.5,),
              const SizedBox(width: 3),
              const Icon(Icons.circle, size: 7.5,),
              const SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 500,
            child: Image.network(
              widget.postSnapshot['photoUrl'],
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 20),
          const Row(
            children: [
              SizedBox(width: 15),
              Icon(Icons.favorite, size: 30,),
              SizedBox(width: 15),
              Icon(Icons.comment, size: 30,),
              SizedBox(width: 15),
              Icon(Icons.send, size: 30),
              Spacer(),
              Icon(Icons.save, size: 30,),
              SizedBox(width: 20),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(widget.userSnapshot['displayName'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              const SizedBox(width: 10),
              Text(widget.postSnapshot['caption'], style: const TextStyle(fontSize: 18),),
            ],
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const SizedBox(width: 20),
              Text(calculateTimeAgo(),),
            ],
          ),
          const SizedBox(height: 20,)
        ],
      ),
    );
  }
}
