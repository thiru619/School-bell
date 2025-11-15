import 'package:flutter/material.dart';

Widget menuItemWidget({
  String? icon,
  required String title,
  required bool active,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: active ? Colors.purple : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            // child: Image.asset(icon),
          ),
          const SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: active ? Colors.purple : Colors.grey.shade700,
            ),
          ),
          if (active)
            Container(
              height: 3,
              width: 40,
              color: Colors.purple,
              margin: const EdgeInsets.only(top: 4),
            ),
        ],
      ),
    ),
  );
}
