import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/asset_paths.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mitt konto'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              tileColor: Colors.black,
              leading: CircleAvatar(
                radius: 31,
                backgroundColor: Color(0xFFF2F2F2),
              ),
              title: Text(
                'My Name',
                style: TextStyle(
                    color: Color(0xFFf2f2f2), fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'myname@gmail.com',
                    style: TextStyle(color: Color(0xFFf2f2f2), fontSize: 12),
                  ),
                  Text(
                    '07XXXXXXXX',
                    style: TextStyle(color: Color(0xFFf2f2f2), fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40,),
            ProfileTileWidget(title: 'Settings',icon:AssetPaths.icSettings ,),
            ProfileTileWidget(title: 'Payments',icon:AssetPaths.icPayments ,),
            ProfileTileWidget(title: 'Support',icon:AssetPaths.icSupport ,),
          ],
        ),
      ),
    );
  }
}

class ProfileTileWidget extends StatelessWidget {
  final String title;
  final String icon;
  const ProfileTileWidget({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(icon),
      title: Text(title),
    );
  }
}
