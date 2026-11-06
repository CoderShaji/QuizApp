import 'package:flutter/material.dart';

void messenger(BuildContext context,String message){
  ScaffoldMessenger.of(context).showSnackBar(
    
    SnackBar(content: Text(message, style: TextStyle(color: Colors.black),), duration: Durations.long4,
    backgroundColor: Colors.white,
    )
  );
}