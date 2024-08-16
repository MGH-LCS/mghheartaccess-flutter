import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mghheartaccess/ui/shared/colors.dart';
import 'package:mghheartaccess/ui/viewmodel/home_model.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer(
    this.model, {
    super.key,
  });

  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: mgbBlue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  "assets/images/mgb-icon.svg",
                  height: 48,
                  alignment: Alignment.topLeft,
                  colorFilter: ColorFilter.mode(mgbTeal, BlendMode.srcIn),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'MGH Heart Center',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'LucidaSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              model.navigateToAboutScreen(context);
            },
            leading: FaIcon(
              FontAwesomeIcons.solidHeartPulse,
              size: 20,
              color: mgbGray,
            ),
            title: const Text('About Us'),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              model.navigateToTermsOfUse(context);
            },
            leading: FaIcon(
              FontAwesomeIcons.solidHandshake,
              size: 20,
              color: mgbGray,
            ),
            title: const Text('Terms of Use'),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              model.navigateToPrivacyPolicy(context);
            },
            leading: FaIcon(
              FontAwesomeIcons.solidShield,
              size: 20,
              color: mgbGray,
            ),
            title: const Text('Privacy Policy'),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              model.navigateToFeedback(context);
            },
            leading: FaIcon(
              FontAwesomeIcons.solidAt,
              size: 20,
              color: mgbGray,
            ),
            title: const Text('Feedback'),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              model.navigateToRateAppPage(context);
            },
            leading: FaIcon(
              FontAwesomeIcons.solidStar,
              size: 20,
              color: mgbGray,
            ),
            title: const Text('Rate the app'),
          ),
          const Divider(),

          ListTile(
            title: Transform.translate(
              offset: const Offset(5, 0),
              child: const Text('MGH Heart'),
            ),
            subtitle: Transform.translate(
              offset: const Offset(5, 0),
              child: Text(model.version == null
                  ? '?'
                  : 'v${model.version} (${model.buildNumber})'),
            ),
            leading: SizedBox(
              width: 24,
              height: 24,
              child: FaIcon(
                FontAwesomeIcons.solidCircleInfo,
                size: 20,
                color: mgbGray,
              ),
            ),
          ),

          // MGHLCS logo
          /*
          ListTile(
            title: Transform.translate(
                offset: const Offset(5, 0),
                child: SvgPicture.asset(
                  "assets/images/mgh-lcs.svg",
                  height: 24,
                  alignment: Alignment.topLeft,
                  colorFilter: ColorFilter.mode(mgbGray, BlendMode.srcIn),
                )),
            leading: SizedBox(
              width: 20,
              child: FaIcon(
                FontAwesomeIcons.solidCode,
                size: 20,
                color: mgbGray,
              ),
            ),
          ),
          */
          const Divider(),
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Center(
              child: Text(
                  'Created in partnership with MGH Healthcare Transformation Lab and MGH Lab of Computer Science'),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => model.handleLCSTap(context),
                child: Transform.translate(
                    offset: const Offset(5, 0),
                    child: SvgPicture.asset(
                      "assets/images/mgh-lcs.svg",
                      height: 24,
                      alignment: Alignment.topLeft,
                      colorFilter: ColorFilter.mode(mgbGray, BlendMode.srcIn),
                    )),
              ),
              InkWell(
                onTap: () => model.handleHTLTap(context),
                child: Text('HTL',
                    style: TextStyle(
                        color: Colors.grey[500],
                        //fontFamily: 'MargriteSlimSerif',
                        fontFamily: 'arial',
                        fontSize: 25,
                        fontWeight: FontWeight.w400)),
              ),
              Container(
                width: 10,
              )
            ],
          ),
        ],
      ),
    );
  }
}
