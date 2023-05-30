// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class InputTextWidget extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final keyboardType;
  final controller;

  const InputTextWidget(
      {Key? key,
      required this.labelText,
      required this.icon,
      required this.obscureText,
      required this.keyboardType,
      this.controller})
      : super(key: key);

  @override
  State<InputTextWidget> createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        color: Colors.white,
        child: Material(
          elevation: 1.0,
          shadowColor: Colors.black,
          borderRadius: BorderRadius.circular(15.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 15.0),
            child: TextFormField(
              controller: widget.controller,
              textInputAction: TextInputAction.next,
              obscureText: widget.obscureText,
              autofocus: false,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                icon: Icon(
                  widget.icon,
                  color: Colors.black,
                  size: 24.0,
                ),
                labelText: widget.labelText,
                labelStyle:
                    const TextStyle(color: Colors.black54, fontSize: 14.0),
                hintText: '',
                enabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
              validator: (val) {
                if (val!.isEmpty) {
                  return 'the Textfield is empty!';
                }
                return null;
              },
            ),
          ),
        ),
      ),
    );
  }
}
