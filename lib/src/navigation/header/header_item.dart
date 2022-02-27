import 'package:crm_spx/src/constants/responsive.dart';
import 'package:flutter/material.dart';

class HeaderItem extends StatelessWidget {
  const HeaderItem({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final headline3 = Theme.of(context).textTheme.headline3;
    final headline6 = Theme.of(context).textTheme.headline6;
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        children: [
          if (Responsive.isDesktop(context))
          Text(
            title.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: headline3
          ),
          
          if (!Responsive.isDesktop(context))
          Text(title.toUpperCase(),
            overflow: TextOverflow.ellipsis,
            style: headline6
          ),
        ],
      )
    );
  }
}
