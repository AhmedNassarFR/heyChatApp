import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hey_app/models/MessageModel.dart';
import 'package:hey_app/services/auth/authService.dart';

class ChatService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }

// send messages

  Future<void> sendMessage(String recieverID, message) async {
    final String currentUserID = _auth.currentUser!.uid;
    final String currentUserEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    // create message

    MessageModel newMessage = MessageModel(
        receiverId: recieverID,
        senderEmail: currentUserEmail,
        message: message,
        senderId: currentUserID,
        timestamp: timestamp);

    //create chatroom

    List<String> ids = [currentUserID, recieverID];
    ids.sort(); //sort the ids
    String chaRoomId = ids.join('_');

    //add new message to database
    await _firestore
        .collection("chatRooms")
        .doc(chaRoomId)
        .collection("messages")
        .add(newMessage.toMap());
  }


  //get messages


  Stream<QuerySnapshot> getMessages(String userId, String otherUserId, {DocumentSnapshot? lastDocument, int limit = 100}) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join('_');

    Query query = _firestore
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false) // Get messages in reverse order
        .limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    return query.snapshots();
  }





}
