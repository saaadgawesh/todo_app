// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:todo_app/view/onbourding/load_image_name/Loadimage-name.dart';
import 'package:todo_app/view/widget/appthem.dart';
import 'package:todo_app/view/widget/listviewWidget.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle color = TextStyle(color: Appthem.primary);
    final iconcolor = Appthem.primary;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Appthem.primary,
          title: const Text('الضبط', style: TextStyle(color: Appthem.white)),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const ListTilewidget(
              leadingicon: Icons.person,
              trailingicon: Icons.arrow_forward_ios,
              text: "الملف الشخصي",
            ),
            const ListTilewidget(
              leadingicon: Icons.notifications,
              trailingicon: Icons.arrow_forward_ios,
              text: "إعدادات الإشعارات",
            ),

            SwitchListTile(
              trackColor: const WidgetStatePropertyAll(Appthem.primary),
              thumbColor: const WidgetStatePropertyAll(Appthem.backgroundlight),
              secondary: Icon(Icons.dark_mode, color: iconcolor),
              title: Text("الوضع الليلي", style: color),
              value: false,
              onChanged: (val) {},
            ),

            const Divider(),

            ListTile(
              leading: Icon(Icons.info, color: iconcolor),
              title: Text("عن التطبيق", style: color),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text("تسجيل الخروج", style: color),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const Loadimagename(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
