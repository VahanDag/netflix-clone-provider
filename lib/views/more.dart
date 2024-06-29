import 'package:flutter/material.dart';
import 'package:movie_app/core/enums.dart';
import 'package:movie_app/core/extensions.dart';
import 'package:movie_app/core/paddings_borders.dart';

class MoreAndProfile extends StatefulWidget {
  const MoreAndProfile({super.key});

  @override
  State<MoreAndProfile> createState() => _MoreAndProfileState();
}

class _MoreAndProfileState extends State<MoreAndProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: ListView.builder(
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        margin: PaddingBorderConstant.paddingAll,
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: PaddingBorderConstant.borderRadius,
                          color: Colors.red,
                        ),
                      ),
                      const Text("Emiliano")
                    ],
                  );
                },
              ),
            ),
            TextButton.icon(
              onPressed: () {},
              label: const Text("Manage Profiles"),
              icon: const Icon(Icons.edit),
            ),
            Container(
              height: 300,
              padding: PaddingBorderConstant.paddingAll,
              color: Colors.grey.shade900,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.message_outlined, size: 40),
                      Text(
                        "Tell friends about Netflix",
                        style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  const Text(
                      "Quis nulla labore ea nulla aliqua aliqua adipisicing. Deserunt duis quis proident nisi adipisicing fugiat. Occaecat esse ex "),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Terms & Conditions",
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 30,
                        alignment: Alignment.center,
                        color: Colors.grey.shade800,
                        width: context.deviceWidth * 0.65,
                        child: const Text("https://www.netflix.com/"),
                      ),
                      ElevatedButton(onPressed: () {}, child: const Text("Copy Link"))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _socialMediaShare(icon: SocialMediaEnum.facebook),
                      _socialMediaShare(icon: SocialMediaEnum.whatsapp),
                      _socialMediaShare(icon: SocialMediaEnum.twitter),
                      _socialMediaShare(icon: SocialMediaEnum.instagram),
                    ],
                  )
                ],
              ),
            ),
            ListTile(
              onTap: () {},
              title: Text(
                "My List",
                style: context.textTheme.titleMedium,
              ),
              leading: const Icon(
                Icons.check,
                size: 30,
              ),
              trailing: const Icon(
                Icons.chevron_right_outlined,
                size: 30,
              ),
            ),
            const Divider(),
            _otherSettings("App Settings"),
            _otherSettings("Account"),
            _otherSettings("Help"),
            _otherSettings("Sign Out"),
          ],
        ),
      )),
    );
  }

  ListTile _otherSettings(String title) {
    return ListTile(
      onTap: () {},
      title: Text(title),
      trailing: const Icon(
        Icons.chevron_right_outlined,
        size: 30,
      ),
    );
  }

  GestureDetector _socialMediaShare({required SocialMediaEnum icon}) {
    return GestureDetector(
      onTap: () {},
      child: Image.asset(height: 50, icon.socialIcon),
    );
  }
}
