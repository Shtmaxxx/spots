import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:spots/flows/main/data/models/chat_model.dart';

@injectable
class FirestoreChats {
  FirestoreChats(this.firebaseFirestore)
      : _chatsCollection = firebaseFirestore.collection('chats'),
        _usersCollection = firebaseFirestore.collection('users');

  final FirebaseFirestore firebaseFirestore;

  final CollectionReference<Map<String, dynamic>> _chatsCollection;
  final CollectionReference<Map<String, dynamic>> _usersCollection;

  Stream<List<ChatModel>> getUsersChats(String userId) {
    final currentUserRef = _usersCollection.doc(userId);
    final result = _chatsCollection
        .where(
          'participantsRefs',
          arrayContains: currentUserRef,
        )
        .snapshots();

    final chats = result.asyncMap(
      (c) => Future.wait(
        c.docs.map((item) async {
          final chatData = item.data();
          final List<DocumentReference> participantsRefs =
              chatData['participantsRefs']
                      ?.cast<DocumentReference<Map<String, dynamic>>>()
                      .toList() ??
                  List<DocumentReference>.empty;
          final chatUserRef =
              participantsRefs.firstWhere((u) => u != currentUserRef);
          final chatTitle = (await chatUserRef.get()).get('email');

          return ChatModel(
            id: item.id,
            participantsRefs: chatData['participantsRefs']
                    ?.cast<DocumentReference<Map<String, dynamic>>>()
                    .toList() ??
                List<String>.empty,
            title: chatTitle,
            recentMessage: chatData['recentMessage'],
            recentMessageDateTime: chatData['recentMessageDateTime'].toDate(),
          );
        }).toList(),
      ),
    );

    // final chats = Future.wait(
    //   result.docs.map((item) async {
    //     final chatData = item.data();
    //     final List<DocumentReference> participantsRefs =
    //         chatData['participantsRefs']
    //                 ?.cast<DocumentReference<Map<String, dynamic>>>()
    //                 .toList() ??
    //             List<DocumentReference>.empty;
    //     final chatUserRef =
    //         participantsRefs.firstWhere((u) => u != currentUserRef);
    //     final chatTitle = (await chatUserRef.get()).get('email');

    //     return ChatModel(
    //       id: item.id,
    //       participantsRefs: chatData['participantsRefs']
    //               ?.cast<DocumentReference<Map<String, dynamic>>>()
    //               .toList() ??
    //           List<String>.empty,
    //       title: chatTitle,
    //       recentMessage: chatData['recentMessage'],
    //       recentMessageDateTime: chatData['recentMessageDateTime'].toDate(),
    //     );
    //   }).toList(),
    // );

    return chats;
  }
}
