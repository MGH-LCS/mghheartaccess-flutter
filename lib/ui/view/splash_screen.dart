//  Copyright © 2021 MGH Lab of Computer Science. All rights reserved.

import 'package:flutter/material.dart';
import 'package:mghheartaccess/ui/shared/device.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Initialization',
      home: SplashScreenPage(),
    );
  }
}

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    DeviceConfig().init(context);

    return const Scaffold(
      body: Text('This is the splash screen'),

      /*
      body: Container(
        height: DeviceConfig.screenHeight,
        width: DeviceConfig.screenWidth,
        decoration: splashBackgroundBoxDecoration(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: DeviceConfig.screenWidth! - loginPadding,
                    child: SvgPicture.asset(
                      "assets/images/moxi-mgh-lcs.svg",
                      colorFilter: ColorFilter.mode(DeviceConfig().getColor(context, moxiHeaderImageColors)!, BlendMode.srcIn),
                      matchTextDirection: false,
                    ),
                  ),
                  SizedBox(
                    width: 300.0,
                    height: 280,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      */
    );
  }
}
