/// One message in the explain-only AI chat (PRD Feature 7).
class ChatMessage {
  const ChatMessage({required this.fromUser, required this.text});

  final bool fromUser;
  final String text;
}
