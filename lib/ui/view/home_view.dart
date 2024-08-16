//  Copyright © 2020 MGH Lab of Computer Science. All rights reserved.

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mghheartaccess/enums/viewstate.dart';
import 'package:mghheartaccess/model/heart_center.dart';
import 'package:mghheartaccess/model/user.dart';
import 'package:mghheartaccess/ui/shared/colors.dart';
import 'package:mghheartaccess/ui/view/base_view.dart';
import 'package:mghheartaccess/ui/view/exception_view.dart';
import 'package:mghheartaccess/ui/view/home_drawer.dart';
import 'package:mghheartaccess/ui/viewmodel/home_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);

    return BaseView<HomeModel>(
      onModelReady: (model) async => await model.init(user),
      builder: (context, model, child) => Scaffold(
        key: model.homeScaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading:
              false, // hides the menu button in the appbar because we only want it to open from the bottom navigation bar icon
          title: SvgPicture.asset(
            "assets/images/mgh.svg",
          ),
        ),
        bottomNavigationBar: HomeBottomNavBar(model),
        drawer: HomeDrawer(model),

        body: model.state == ViewState.busy
            ? const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 30.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height: 35.0),
                      Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ]))
            : model.exception != null
                ? MGHHeartExceptionView(
                    exception: model.exception,
                    onRetry: model.handleExceptionRetry)
                : HomeBody(model),

        //body: HomeBody(model),
      ),
    );
  }
}

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar(
    this.model, {
    super.key,
  });

  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            tooltip: 'Search',
            icon: const FaIcon(
              FontAwesomeIcons.solidHouse,
              size: 20,
            ),
            onPressed: () {},
          ),
          // IconButton(
          //   tooltip: 'Favorite',
          //   icon: const Icon(Icons.favorite),
          //   onPressed: () {},
          // ),
          IconButton(
            tooltip: 'Open navigation menu',
            icon: const FaIcon(
              FontAwesomeIcons.solidBars,
              size: 20,
            ),
            onPressed: () {
              model.openDrawer();
            },
          ),
        ],
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  const HomeBody(
    this.model, {
    super.key,
  });

  final HomeModel model;

  @override
  Widget build(BuildContext context) {
    List<HeartService> serviceList = model.heartCenter.serviceList;

    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SUB BRAND BANNER
            Ink(
              decoration: BoxDecoration(color: mgbBlue),
              child: InkWell(
                onTap: () {
                  model.navigateToAboutScreen(context);
                },
                child: SizedBox(
                  width: double.infinity,
                  //height: 175,
                  //decoration: BoxDecoration(color: mgbBlue),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(
                          child: Text(
                            model.heartCenter.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'LucidaSans',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                          //textAlign: TextAlign.right,
                          //model.heartCenter.description,
                          'Learn More > ',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // END SUB BRAND BANNER
            const SizedBox(
              height: 8,
            ),

            ...serviceList.map((svc) => ServiceCard(svc, model)),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  const ServiceCard(
    this.svc,
    this.model, {
    super.key,
  });

  final HomeModel model;
  final HeartService svc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
      child: GestureDetector(
        onTap: () => model.showServiceDetail(svc),
        child: Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            svc.title.toUpperCase(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 20),
                          ),
                          Text(svc.description),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset(svc.imageAssetPath),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 16, 0, 0),
                  child: Row(
                    //mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            model.showServiceDetail(svc);
                          },
                          child: const Text(' Tap for details'),
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      FilledButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll<Color>(mgbRed),
                            shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                            )),

                        /*
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll<Color>(mgbRed),
                        ),
                        */

                        onPressed: () => model.handleServiceCall(context, svc),
                        label: const Text(
                          'Hotline',
                          style: TextStyle(color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.phone,
                          color: Colors.white,
                          size: 24.0,
                          semanticLabel: 'Call the ${svc.title} hotline',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


/*

// ECMO CARD
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'ECMO',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Text('Extracorporeal Life Support (ECLS/ECMO)'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.asset('assets/images/ecmo.jpg'),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 16, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            // const TextButton(
                            //   onPressed: null,
                            //   child: Text('Guidelines'),
                            // ),
                            TextButton(
                              onPressed: () {
                                model.showServiceDetail('ECMO');
                                //_navigateToECMOScreen(context);
                              },
                              child: const Text(' Guidelines'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            FilledButton.icon(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll<Color>(mgbRed),
                              ),
                              onPressed: null,
                              label: const Text(
                                'Hotline',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 24.0,
                                semanticLabel: 'Call the ECMO hotline',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // END ECMO CARD

            // AORTIC DISSECTION CARD
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 8),
              child: Card(
                elevation: 1,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'AORTIC DISSECTION',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                                Text(
                                    'Call early in the clinical course. Calls for any patient with a potential aortic dissection are welcome.'),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child:
                                  Image.asset('assets/images/dissection.jpg'),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 16, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                model.showServiceDetail('ECMO');
                                //_navigateToADScreen(context);
                              },
                              child: const Text('Guidelines'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            FilledButton.icon(
                              style: ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll<Color>(mgbRed),
                              ),
                              onPressed: null,
                              label: const Text(
                                'Hotline',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: const Icon(
                                Icons.phone,
                                color: Colors.white,
                                size: 24.0,
                                semanticLabel:
                                    'Call the Aortic Dissecion hotline',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

*/
