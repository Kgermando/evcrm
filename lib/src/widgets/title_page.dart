import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

Widget titleField(BuildContext context, String title) {
  final headline4 = Theme.of(context).textTheme.headline4;
  return Container(
    margin: const EdgeInsets.only(bottom: 20.0, left: 20.0),
    child: AutoSizeText(
      title,
      maxLines: 3,
      textAlign: TextAlign.center,
      style: headline4!.copyWith(fontWeight: FontWeight.bold),
    ),
  );
}
