import 'package:flutter/material.dart';

// Keep a reference to the currently shown profile overlay so we can remove it
// when navigating to another page.
OverlayEntry? _activeProfileEntry;

void showProfilePopup(BuildContext context, Widget child) {
  // Remove any existing profile overlay first
  closeProfilePopup();

  final overlay = Overlay.of(context);
  final renderBox = context.findRenderObject() as RenderBox;
  final position = renderBox.localToGlobal(Offset.zero);

  _activeProfileEntry = OverlayEntry(
    builder: (_) {
      return Stack(
        children: [
          // Background dismiss
          Positioned.fill(
            child: GestureDetector(
              onTap: () => closeProfilePopup(),
              child: Container(color: Colors.transparent),
            ),
          ),

          // Popup Positioned
          Positioned(
            top: position.dy + 80, // below icon
            left: position.dx + 20, // popup shifted left like perplexity
            child: LayoutBuilder(
              builder: (context, constraints) {
                double width = MediaQuery.of(context).size.width > 300
                    ? 260
                    : 260;

                return Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: width,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: child,
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
  );

  overlay.insert(_activeProfileEntry!);
}

/// Remove the currently shown profile popup, if any.
void closeProfilePopup() {
  if (_activeProfileEntry != null) {
    try {
      _activeProfileEntry!.remove();
    } catch (_) {}
    _activeProfileEntry = null;
  }
}

Widget teacherProfileUI() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage("assets/teacher.png"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Teacher Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),

      _profileItem("Staff ID", "TCH12345"),
      _profileItem("Mobile Number", "9876543210"),
      _profileItem("Role", "Senior Teacher"),
      _profileItem("Department", "Mathematics"),
      _profileItem("Gender", "Male"),

      const SizedBox(height: 8),
    ],
  );
}

Widget _profileItem(String title, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

Widget studentProfileUI() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Row(
        children: [
          CircleAvatar(
            radius: 26,
            backgroundImage: AssetImage("assets/student.png"),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "Student Name",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),

      _profileItem("Admission ID", "ADM5620"),
      _profileItem("Father Name", "Kumaravel"),
      _profileItem("Mobile Number", "9845673210"),
      _profileItem("DOB", "01-04-2010"),
      _profileItem("Grade & Section", "8 - A"),
      _profileItem("Gender", "Female"),

      const SizedBox(height: 8),
    ],
  );
}
