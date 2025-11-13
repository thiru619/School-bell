import 'package:flutter/material.dart';

Widget CustomTextField({
  required BuildContext context,
  required TextEditingController controller,
  required String hint,
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
