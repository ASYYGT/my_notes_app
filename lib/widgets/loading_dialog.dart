import 'package:flutter/material.dart';

Future<dynamic> loadingAlert(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text("Loading..", style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    },
  );
}
