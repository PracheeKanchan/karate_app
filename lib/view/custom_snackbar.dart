import 'package:flutter/material.dart';

class CustomSnackbar{

  static showCustomSnackbar(
    {required String message,required BuildContext context}) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.green,
          ),
        );

  }
}