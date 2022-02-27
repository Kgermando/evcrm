import 'package:badges/badges.dart';
import 'package:crm_spx/src/constants/responsive.dart';
import 'package:crm_spx/src/models/menu_item.dart';
import 'package:crm_spx/src/navigation/header/header_item.dart';
import 'package:crm_spx/src/provider/controller.dart';
import 'package:crm_spx/src/services/user_preferences.dart';
import 'package:crm_spx/src/utils/menu_items.dart';
import 'package:crm_spx/src/utils/menu_options.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomAppbar extends StatefulWidget {
  const CustomAppbar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _CustomAppbarState createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  bool isloading = false;
  bool connectionStatus = false;

  @override
  void initState() {
    connection();
    super.initState();
  }

  String? role;
  String? telephone;

  Future connection() async {
    var user = await UserPreferences.read();
    if (!mounted) return;
    setState(() {
      role = user.role;
      telephone = user.telephone;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!Responsive.isDesktop(context))
              IconButton(
                onPressed: context.read<Controller>().controlMenu,
                icon: const Icon(
                  Icons.menu,
                ),
              ),
            HeaderItem(title: widget.title),
            const Spacer(),
           
            InkWell(
              onTap: () {},
              child: Badge(
                badgeColor: Colors.red,
                badgeContent: const Text('38', style: TextStyle(color: Colors.white),),
                child: const Icon(Icons.notifications),
              ),
            ),
            const SizedBox(width: 20.0,),
            InkWell(
              onTap: () {},
              child: Badge(
                badgeColor: Colors.blue,
                badgeContent: const Text('99', style: TextStyle(color: Colors.white),),
                child: const Icon(Icons.call),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            InkWell(
              onTap: () {},
              child: Badge(
                badgeColor: Colors.green,
                badgeContent: const Text('56' , style: TextStyle(color: Colors.white),),
                child: const Icon(Icons.mail),
              ),
            ),
            PopupMenuButton<MenuItem>(
              onSelected: (item) => MenuOptions().onSelected(context, item),
              itemBuilder: (context) => [
                ...MenuItems.itemsFirst.map(MenuOptions().buildItem).toList(),
                const PopupMenuDivider(),
                ...MenuItems.itemsSecond.map(MenuOptions().buildItem).toList(),
              ],
            )
          ],
        )
      ],
    );
  }

}
