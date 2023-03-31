import 'package:flutter/material.dart';

class ExplorerHeader extends StatelessWidget {
  const ExplorerHeader({Key? key, required this.text, this.action})
      : super(key: key);
  final String text;
  final HeaderAction? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

class HeaderAction extends StatelessWidget {
  const HeaderAction({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Text(text, style: const TextStyle(color: Colors.grey)),
          const Icon(Icons.arrow_right, color: Colors.grey),
        ],
      ),
    );
  }
}
