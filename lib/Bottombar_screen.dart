// ignore_for_file: unused_field, library_private_types_in_public_api, camel_case_types, unused_import, prefer_const_constructors, file_names, duplicate_ignore, unused_local_variable

import 'dart:developer';
import 'dart:io';

// import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:magicmate_organizer/Dashboard/Dashboard_screen.dart';
import 'package:magicmate_organizer/Dashboard/Qr%20View/qrview_screen.dart';
import 'package:magicmate_organizer/Dashboard/Today_event/Todayevent_screen.dart';
import 'package:magicmate_organizer/Dashboard/notificatin_screen.dart';
import 'package:magicmate_organizer/Dashboard/payout/payout_screen.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Dashboard_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/Todayevent_controller.dart';
import 'package:magicmate_organizer/Getx_controller.dart/eventdetails_controller.dart';
import 'package:magicmate_organizer/Profile_Screen/Profilescreen.dart';
import 'package:magicmate_organizer/api_screens/Api_werper.dart';
import 'package:magicmate_organizer/api_screens/data_store.dart';
import 'package:magicmate_organizer/utils/Colors.dart';
import 'package:magicmate_organizer/utils/Custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

int selectedIndex = 0;

class BottoBarScreen extends StatefulWidget {
  const BottoBarScreen({Key? key}) : super(key: key);

  @override
  _BottoBarScreenState createState() => _BottoBarScreenState();
}

class _BottoBarScreenState extends State<BottoBarScreen>
    with TickerProviderStateMixin {
  StatuswiseeventController statuswiseeventController = Get.find();
  DashboardController dashboardController = Get.find();

  late int _lastTimeBackButtonWasTapped;
  static const exitTimeInMillis = 2000;

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  List<Widget> myChilders = [
    DashboardScreen(),
    Todayeventscreen(status: "Today event", hideStatus: "2"),
    MyPayoutScreen(status: "2"),
    ProfileScreen(),
  ];
  var qrText = "";
  Map qrCodeResult = {};
  String qCodeResult = "";
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        exit(0);
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 4),
          child: FloatingActionButton(
            backgroundColor: appcolor,
            onPressed: () async {
              save("openCamera", true);
              Get.to(QrViewScreen(), duration: Duration(seconds: 1));
              // ScanResult codeScanner = await BarcodeScanner.scan();

              // setState(
              //   () {
              //     qCodeResult = codeScanner.rawContent;
              //   },
              // );
              // if (qCodeResult.isNotEmpty) {
              //   // print("Yagnik QRCode--->" + qCodeResult.toString());

              //   // Get.to(
              //   //   () => TicketDetailPage(tikitdata: qCodeResult),
              //   // );
              // } else {
              //   ApiWrapper.showToastMessage("Plese Scan Qr Code");
              // }
              // qCodeResult = "";
            },
            child: Container(
              margin: EdgeInsets.all(15.0),
              child: Image.asset(
                "assets/qrcode,scan.png",
              ),
            ),
            elevation: 4.0,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: greycolor,
          backgroundColor: WhiteColor,
          elevation: 0,
          selectedLabelStyle:
              const TextStyle(fontFamily: 'Gilroy Bold', fontSize: 12),
          fixedColor: appcolor,
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Gilroy Medium',
          ),
          currentIndex: selectedIndex,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                // activeIcon: Image.asset(
                //   "assets/myorder.png",
                //   height: 20,
                // ),
                icon: Image.asset("assets/dashboard.png",
                    color: selectedIndex == 0 ? appcolor : greycolor,
                    height: MediaQuery.of(context).size.height / 40),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Padding(
                  padding: const EdgeInsets.only(right: 35),
                  child: Image.asset("assets/Bookmark1.png",
                      color: selectedIndex == 1 ? appcolor : greycolor,
                      height: MediaQuery.of(context).size.height / 37),
                ),
                label: 'Booking            '),
            BottomNavigationBarItem(
              backgroundColor: transparent,
              icon: Padding(
                padding: const EdgeInsets.only(left: 35),
                child: Image.asset("assets/Wallet.png",
                    color: selectedIndex == 2 ? appcolor : greycolor,
                    height: MediaQuery.of(context).size.height / 35),
              ),
              label: '           Payout',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/user.png",
                  color: selectedIndex == 3 ? appcolor : greycolor,
                  height: MediaQuery.of(context).size.height / 35),
              label: 'Profile',
            ),
          ],
          onTap: (index) {
            if (index == 1) {
              statuswiseeventController.statuswiseevent(status: "Today");
            } else if (index == 2) {
              dashboardController.dashboard();
            }
            setState(() {});
            selectedIndex = index;
          },
        ),
        body: myChilders[selectedIndex],
      ),
    );
  }
}
// ignore_for_file: unused_field, library_private_types_in_public_api, camel_case_types, unused_import, prefer_const_constructors, file_names, sort_child_properties_last

// import 'dart:developer';

// import 'package:magicmate_organizer/Booking_Screen/Bookingscreen.dart';
// import 'package:magicmate_organizer/Dashboard/Dashboard_screen.dart';
// import 'package:magicmate_organizer/Login_flow/Login_screen.dart';
// import 'package:magicmate_organizer/Message_Screen/Massagescreen.dart';
// import 'package:magicmate_organizer/Profile_Screen/Profilescreen.dart';
// import 'package:magicmate_organizer/api_screens/data_store.dart';
// import 'package:magicmate_organizer/utils/Colors.dart';
// import 'package:magicmate_organizer/utils/Fontfamily.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// int selectedIndex = 0;

// class BottoBarScreen extends StatefulWidget {
//   const BottoBarScreen({super.key});

//   @override
//   State<BottoBarScreen> createState() => _BottoBarScreenState();
// }

// late TabController tabController;

// class _BottoBarScreenState extends State<BottoBarScreen>
//     with TickerProviderStateMixin {
//   // WalletController walletController = Get.find();
//   // DashBoardController dashBoardController = Get.find();
//   // ListOfPropertiController listOfPropertiController = Get.find();
//   // SelectCountryController selectCountryController = Get.find();

//   int _currentIndex = 0;
//   int _selectIndex = 0;

//   var isLogin;

//   List<Widget> myChilders = [
//     DashboardScreen(),
//     Bookingscreen(),
//     Massagescreen(),
//     Profilescreen(),
//   ];

//   // late ColorNotifire notifire;
//   // getdarkmodepreviousstate() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   bool? previusstate = prefs.getBool("setIsDark");
//   //   if (previusstate == null) {
//   //     notifire.setIsDark = false;
//   //   } else {
//   //     notifire.setIsDark = previusstate;
//   //   }
//   // }

//   @override
//   void initState() {
//     super.initState();
//     // dashBoardController.getDashBoardData();
//     // isLogin = getData.read("UserLogin");
//     tabController = TabController(length: 4, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     // notifire = Provider.of<ColorNotifire>(context, listen: true);
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: TabBarView(
//         physics: const NeverScrollableScrollPhysics(),
//         controller: tabController,
//         children: myChilders,
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: FloatingActionButton(
//           backgroundColor: appcolor,
//           onPressed: () {
//             // if (isLogin != null) {
//             //   if (dashBoardController.dashBoardInfo?.isSubscribe == 1) {
//             //     dashBoardController.getDashBoardData();
//             //     listOfPropertiController.getPropertiList();
//             //     selectCountryController.getCountryApi();
//             //     Get.to(MembershipScreen());
//             //   } else {
//             //     selectCountryController.getCountryApi();
//             //     Get.to(BoardingPage());
//             //   }
//             // } else {
//             //   Get.to(() => LoginScreen());
//             // }
//           },
//           child: Container(
//             margin: EdgeInsets.all(15.0),
//             child: Image.asset(
//               "assets/bolt.png",
//             ),
//           ),
//           elevation: 4.0,
//         ),
//       ),
//       bottomNavigationBar: BottomAppBar(
//         color: bgcolor,
//         child: TabBar(
//           onTap: (index) {
//             // setState(() {});
//             // if (isLogin != null) {
//             //   _currentIndex = index;
//             // } else {
//             //   index != 0 ? Get.to(() => LoginScreen()) : const SizedBox();
//             // }
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//           indicator: UnderlineTabIndicator(
//             insets: EdgeInsets.only(bottom: 52),
//             borderSide: BorderSide(color: bgcolor, width: 2),
//           ),
//           labelColor: Colors.blueAccent,
//           indicatorSize: TabBarIndicatorSize.label,
//           unselectedLabelColor: Colors.grey,
//           controller: tabController,
//           padding: const EdgeInsets.symmetric(vertical: 6),
//           tabs: [
//             Tab(
//               child: Column(
//                 children: [
//                   _currentIndex == 0
//                       ? Image.asset(
//                           "assets/dashboard.png",
//                           scale: 4.5,
//                           color: appcolor,
//                         )
//                       : Image.asset(
//                           "assets/dashboard.png",
//                           scale: 4.5,
//                           color: BlackColor,
//                         ),
//                   SizedBox(height: 3),
//                   Text(
//                     "Home",
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontFamily: FontFamily.gilroyMedium,
//                       color: _currentIndex == 0 ? appcolor : Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               height: 50,
//               width: 80,
//               alignment: Alignment.topLeft,
//               child: Tab(
//                 child: Column(
//                   children: [
//                     _currentIndex == 1
//                         ? Image.asset(
//                             "assets/Bookmark.png",
//                             scale: 3.5,
//                             color: appcolor,
//                           )
//                         : Image.asset(
//                             "assets/Bookmark.png",
//                             scale: 3.5,
//                             color: BlackColor,
//                           ),
//                     SizedBox(height: 3),
//                     Text(
//                       "Search",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontFamily: FontFamily.gilroyMedium,
//                         color: _currentIndex == 1 ? appcolor : Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Container(
//               height: 50,
//               width: 80,
//               alignment: Alignment.topRight,
//               child: Tab(
//                 child: Column(
//                   children: [
//                     _currentIndex == 2
//                         ? Image.asset(
//                             "assets/message.png",
//                             scale: 3.8,
//                             color: appcolor,
//                           )
//                         : Image.asset(
//                             "assets/message.png",
//                             scale: 3.8,
//                             color: BlackColor,
//                           ),
//                     SizedBox(height: 3),
//                     Text(
//                       "Favorite",
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontFamily: FontFamily.gilroyMedium,
//                         color: _currentIndex == 2 ? appcolor : Colors.grey,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Tab(
//               child: Column(
//                 children: [
//                   _currentIndex == 3
//                       ? Image.asset(
//                           "assets/user.png",
//                           scale: 4.5,
//                           color: appcolor,
//                         )
//                       : Image.asset(
//                           "assets/user.png",
//                           scale: 4.5,
//                           color: BlackColor,
//                         ),
//                   SizedBox(height: 3),
//                   Text(
//                     "Account",
//                     style: TextStyle(
//                       fontSize: 14,
//                       fontFamily: FontFamily.gilroyMedium,
//                       color: _currentIndex == 3 ? appcolor : Colors.grey,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
