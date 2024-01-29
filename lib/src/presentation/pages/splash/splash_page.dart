import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer/res/app_images.dart';
import 'package:flutter_timer/res/app_strings.dart';
import 'package:flutter_timer/src/presentation/pages/home/home_page.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_background.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_card_image.dart';
import 'package:flutter_timer/src/presentation/widgets/odoo_text.dart';
import 'package:flutter_timer/src/presentation/widgets/space.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1), (){
        HomePage.push(context: context);
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return OdooBackground(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const OdooCardImage(
              image: AppImages.hourglass,
            ),
            const VSpace(32),
            OdooText(
              AppStrings.of(context).appName,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const VSpace(8),
            OdooText(
              AppStrings.of(context).appSlogan,
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
