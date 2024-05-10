enum Sender { user, bot }

class ChatMessage {
  final String text;
  final Sender sender;
  final date = DateTime.now();

  ChatMessage({required this.text, required this.sender});
}
