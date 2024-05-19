import 'package:flutter/material.dart';
import 'package:intelligentassistant/message.dart';

class BotMessage extends StatelessWidget {
  final String text;
  final Sender sender;

  const BotMessage({
    super.key,
    required this.text,
    required this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, right: 120),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: CircleAvatar(
                child: Image.asset('images/11.jpg'),
                radius: 24,
              ),
            ),
            SizedBox(
              width: 0,
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      const Color(0xff2A75BC),
                      const Color(0xff007EF4),
                    ]),
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(16),
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    )),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
