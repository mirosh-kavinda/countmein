import 'package:flutter/material.dart';

class TemplateSelect extends StatelessWidget {
  const TemplateSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Template'),
      ),
      body: const Center(
        child: Text('Select a Template'),
      ),
    );
  }
}
