import 'package:flutter/material.dart';

Widget CustomTextField({
  required BuildContext context,
  required TextEditingController controller,
  String? hint,
  bool isPassword = false,
  IconData? prefixIcon,
}) {
  bool obscurePassword = isPassword;

  return StatefulBuilder(
    builder: (context, setState) {
      return TextFormField(
        controller: controller,
        obscureText: isPassword ? obscurePassword : false,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      obscurePassword = !obscurePassword;
                    });
                  },
                )
              : null,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 14,
          ),
        ),
      );
    },
  );
}

Widget chatInputField({
  required TextEditingController controller,
  required VoidCallback onSend,
  VoidCallback? onAttachment,
  VoidCallback? onMic,
}) {
  return Stack(
    children: [
      Container(
        padding: const EdgeInsets.only(
          left: 12,
          right: 60,
          top: 14,
          bottom: 40,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          controller: controller,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          decoration: const InputDecoration(
            hintText: "Message",
            border: InputBorder.none,
          ),
        ),
      ),

      // ICONS BOTTOM RIGHT
      Positioned(
        right: 10,
        bottom: 10,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: onAttachment,
            ),
            IconButton(icon: const Icon(Icons.camera_alt), onPressed: onMic),
            GestureDetector(
              onTap: onSend,
              child: Container(
                padding: const EdgeInsets.all(12),

                child: const Icon(Icons.send, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
