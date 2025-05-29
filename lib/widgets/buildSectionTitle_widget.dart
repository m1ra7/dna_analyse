import 'package:flutter/material.dart';

Widget buildSectionTitle(BuildContext context, String title, {IconData? icon}) {
  //Baslik logolo
  return Row(
    children: [
      if (icon != null)
        CircleAvatar(
          backgroundColor: Colors.blue.withValues(alpha: 0.1),
          radius: 14,
          child: Icon(icon, size: 18, color: Colors.white),
        ),
      if (icon != null) const SizedBox(width: 4),
      Expanded(
        child: Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    ],
  );
}
