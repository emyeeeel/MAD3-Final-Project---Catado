import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widgets/reels_item.dart';

class ReelsScreen extends StatefulWidget {
  static const String route = '/reels';
  static const String name = "Reels Screen";

  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: StreamBuilder(
          stream: _firestore
              .collection('reels')
              .where('user', isNotEqualTo: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid))
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
                        return const CircularProgressIndicator(); 
                      }
                      List<DocumentSnapshot> sortedDocs = snapshot.data!.docs.toList()
                      ..sort((a, b) => b.get('time').compareTo(a.get('time')));
            return PageView.builder(
              scrollDirection: Axis.vertical,
              controller: PageController(initialPage: 0, viewportFraction: 1),
              itemCount: sortedDocs.length,
              itemBuilder: (context, index) {
                return ReelsItem(snapshot.data!.docs[index].data());
              },
            );
          },
        ),
      ),
    );
  }
}
