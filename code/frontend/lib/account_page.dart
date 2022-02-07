import 'package:flutter/material.dart';

import 'chatbot.dart';

class Account extends StatelessWidget {
  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return
      const Center(
        child: Text(
          'Willkommen zu deinem Artothek Account!',
          textDirection: TextDirection.ltr,
        ),
      );
  }
}
