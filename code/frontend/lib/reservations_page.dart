import 'package:flutter/material.dart';

import 'chatbot.dart';

class Reservations extends StatelessWidget {
  const Reservations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return
        const Center(
          child: Text(
            'Übersicht deiner Reservierungen',
            textDirection: TextDirection.ltr,
          ),
        );
    }  }


