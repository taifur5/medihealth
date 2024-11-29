import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String doctorId;

  const ChatScreen({super.key, required this.doctorId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? currentUserId;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    currentUserId = FirebaseAuth.instance.currentUser!.uid;
  }

  void sendMessage(String message) async {
    if (message.isEmpty) return;

    DocumentReference chatDoc = FirebaseFirestore.instance.collection('chats').doc(_getChatId());

    // Ensure the chat exists
    await chatDoc.set({
      'doctorId': widget.doctorId,
      'patientId': currentUserId,
      'lastMessage': message,
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    // Add message to subcollection
    await chatDoc.collection('messages').add({
      'senderId': currentUserId,
      'receiverId': widget.doctorId,
      'text': message,
      'timestamp': FieldValue.serverTimestamp(),
    });

    messageController.clear();
  }

  String _getChatId() {
    List<String> ids = [currentUserId!, widget.doctorId];
    ids.sort();
    return ids.join('_');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(_getChatId())
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<QueryDocumentSnapshot> docs = snapshot.data!.docs;

                return ListView.builder(
                  reverse: true,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var messageData = docs[index].data() as Map<String, dynamic>;
                    bool isSentByCurrentUser = messageData['senderId'] == currentUserId;

                    return Align(
                      alignment:
                          isSentByCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSentByCurrentUser ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          messageData['text'],
                          style: TextStyle(
                            color: isSentByCurrentUser ? Colors.white : Colors.black,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    sendMessage(messageController.text.trim());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
