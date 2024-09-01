import 'package:flutter/material.dart';

WidgetProvider widgetProvider = WidgetProvider();

class WidgetProvider {

  SnackBar snackbar(String text) {
    return SnackBar(
      content: Text(text),
      showCloseIcon: true,
    );
  }
  
}
