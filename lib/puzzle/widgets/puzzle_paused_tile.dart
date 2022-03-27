import 'package:flutter/material.dart';

class PuzzlePausedTile extends StatelessWidget {
  const PuzzlePausedTile({
    Key? key,
    required this.icon,
    required this.title,
    this.onPressed,
  }) : super(key: key);

  final Widget icon;
  final Widget title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Colors.white70;

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: InkWell(
          onTap: onPressed,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                SizedBox(height: 48, width: 48, child: icon),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultTextStyle(
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        child: title,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 26,
                  width: 26,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
