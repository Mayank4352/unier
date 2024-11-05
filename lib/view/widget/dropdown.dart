import 'package:flutter/material.dart';

class LanguageDropdown extends StatelessWidget {
  final Function(String) onLanguageSelected;

  const LanguageDropdown({super.key, required this.onLanguageSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'english',
          child: Text('English'),
        ),
        const PopupMenuItem<String>(
          value: 'hindi',
          child: Text('Hindi'),
        ),
        const PopupMenuItem<String>(
          value: 'gujarati',
          child: Text('Gujarati'),
        ),
      ],
      onSelected: (String? newValue) {
        onLanguageSelected(newValue!);
      },
      icon: const Icon(Icons.language),
    );
  }
}
