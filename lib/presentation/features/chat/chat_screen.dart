import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:App/presentation/features/chat/widgets/chat_detail_screen.dart';

class RecentChatScreen extends StatefulWidget {
  const RecentChatScreen({super.key});

  @override
  State<RecentChatScreen> createState() => _RecentChatScreenState();
}

class _RecentChatScreenState extends State<RecentChatScreen> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String myPhone = FirebaseAuth.instance.currentUser!.phoneNumber ?? '';

    return Scaffold(
      appBar: AppBar(title: const Text("Recent Chats")),
      body: Column(
        children: [
          // Input field to start chat by phone
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      hintText: "Enter phone number to start chat",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chat),
                  onPressed: () {
                    String phone = phoneController.text.trim();
                    if (phone.isEmpty) return;
                    if (!phone.startsWith('+')) phone = '+91$phone';

                    String chatId = generateChatId(myPhone, phone);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ChatDetailScreen(
                          chatId: chatId,
                          myPhone: myPhone,
                          otherPhone: phone,
                        ),
                      ),
                    );

                    phoneController.clear();
                  },
                ),
              ],
            ),
          ),

          // Recent chats list
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .where('participants', arrayContains: myPhone)
                  .orderBy('lastMessageTime', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: Text(
                      "Loading chats...",
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final docs = snapshot.data!.docs;

                if (docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No chats yet. Start a chat using the phone number above.",
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                // Separate chats with valid lastMessageTime
                final validChats = docs
                    .where((doc) =>
                    (doc.data() as Map<String, dynamic>)
                        .containsKey('lastMessageTime'))
                    .toList();

                // Use fallback if no chat has lastMessageTime
                final displayChats = validChats.isNotEmpty ? validChats : docs;

                return _buildChatList(displayChats, myPhone);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Build the ListView of chats
  Widget _buildChatList(List<QueryDocumentSnapshot> chats, String myPhone) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index].data() as Map<String, dynamic>;
        final chatId = chats[index].id;

        final participants = chat['participants'] as List<dynamic>? ?? [];
        final otherPhone = participants.firstWhere(
                (p) => p != myPhone,
            orElse: () => 'Unknown');

        final lastMessage = chat['lastMessage'] ?? '';
        final timestamp = chat['lastMessageTime'] as Timestamp?;
        final timeString =
        timestamp != null ? _formatTimestamp(timestamp) : '';

        return ListTile(
          leading: CircleAvatar(
            child: Text(otherPhone.toString().substring(
                otherPhone.length >= 4 ? otherPhone.length - 4 : 0)),
          ),
          title: Text("Chat with $otherPhone"),
          subtitle: Text(lastMessage),
          trailing: Text(timeString),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChatDetailScreen(
                  chatId: chatId,
                  myPhone: myPhone,
                  otherPhone: otherPhone,
                ),
              ),
            );
          },
        );
      },
    );
  }

  String generateChatId(String phone1, String phone2) {
    final phones = [phone1, phone2]..sort();
    return phones.join('_');
  }

  String _formatTimestamp(Timestamp timestamp) {
    final date = timestamp.toDate();
    final now = DateTime.now();

    if (date.day == now.day &&
        date.month == now.month &&
        date.year == now.year) {
      return "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}";
    } else {
      return "${date.day}/${date.month}/${date.year}";
    }
  }
}
