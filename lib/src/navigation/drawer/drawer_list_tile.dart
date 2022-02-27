import 'package:crm_spx/src/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:tree_view/tree_view.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile(
      {Key? key, required this.title, 
      required this.active, required this.tap, required this.icon})
      : super(key: key);

  final String title;
  final VoidCallback tap;
  final bool active;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return 
    
    
    
    ListTile(
      tileColor: active ? Colors.teal : Colors.white,
      onTap: tap,
      horizontalTitleGap: 0.0,
      leading: Icon(
        icon,
        color: active ? Colors.white : Colors.black87,
      ),
      title: CustomText(
        text: title,
        color: active ? Colors.white : Colors.black87,
        size: active ? 16 : 16,
        weight: active ? FontWeight.w600 : FontWeight.w600,
      ),
    );
  }
}
