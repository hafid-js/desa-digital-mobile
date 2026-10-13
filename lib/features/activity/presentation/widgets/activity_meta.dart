import 'package:flutter/material.dart';

class BulletMeta extends StatelessWidget {
  const BulletMeta({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: "• ",
            style: Theme.of(
              context,
            ).textTheme.labelLarge!.copyWith(fontSize: 12),
          ),
          TextSpan(
            text: text,
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(fontSize: 11),
          ),
        ],
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class DateMeta extends StatelessWidget {
  const DateMeta({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 11),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class DateText extends StatelessWidget {
  const DateText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 11),
    );
  }
}
