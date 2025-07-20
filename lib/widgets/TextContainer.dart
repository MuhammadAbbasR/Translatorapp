import 'package:flutter/material.dart';

Widget TextContainer(String title, String? content, BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: SingleChildScrollView(
          child: Text(
            content ?? 'No data available...',
            style: const TextStyle(
                fontSize: 15, height: 1.5, color: Colors.black87),
          ),
        ),
      ),
    ],
  );
}
