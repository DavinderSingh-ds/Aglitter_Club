// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_signin/FrontEnd/MainScreens/KidsEducation/mainPageKids.dart';
import 'package:google_signin/FrontEnd/MainScreens/logOut_Page.dart';
import 'package:google_signin/FrontEnd/MainScreens/youtube_screen.dart';
import 'package:google_signin/FrontEnd/MenuScreens/about_screen.dart';
import 'package:google_signin/FrontEnd/MenuScreens/profile_screen.dart';
import 'package:google_signin/FrontEnd/MenuScreens/settings_screen.dart';
import 'package:google_signin/FrontEnd/MenuScreens/SupportScreens/support_screen.dart';
import 'package:lottie/lottie.dart';

import 'chatAndActivityScreen.dart';
import 'diary/diary.dart';
import 'game_screen.dart';
import 'package:animations/animations.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: WillPopScope(
        onWillPop: () async {
          if (_currIndex > 0) {
            return false;
          } else {
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: _drawer(),
          appBar: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/chatwallpape.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            elevation: 0.0,
            shadowColor: Colors.white,
            title: const Text(
              "ClubHouse",
              style: TextStyle(
                fontSize: 18.0,
                fontFamily: 'Lora',
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.logout_outlined),
                color: Colors.white,
                tooltip: 'LogOut',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LogOutPage()),
                  );
                },
              ),
            ],
            bottom: _bottom(),
          ),
          body: const TabBarView(
            children: [
              ChatAndActivityScreen(),
              ImageScreen(),
              YouTubeScreen(),
              mainPageKids(),
              Diary(),
            ],
          ),
        ),
      ),
    );
  }

  TabBar _bottom() {
    return TabBar(
      indicatorPadding: const EdgeInsets.only(left: 20.0, right: 20.0),
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white60,
      indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: Colors.lightBlue),
          insets: EdgeInsets.symmetric(horizontal: 15.0)),
      automaticIndicatorColorAdjustment: true,
      labelStyle: const TextStyle(
        fontFamily: 'Lora',
        fontWeight: FontWeight.w500,
        letterSpacing: 1.0,
      ),
      onTap: (index) {
        log("\nIndex is: $index");
        if (mounted) {
          setState(() {
            _currIndex = index;
          });
        }
      },
      tabs: const [
        Tab(
          child: Text(
            "💬",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Tab(
          child: Text(
            "🎲",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
              color: Colors.white,
            ),
          ),
        ),
        Tab(
          child: Text(
            "📱",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
              color: Colors.white,
            ),
          ),
        ),
        Tab(
          child: Text(
            "🧒",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
              color: Colors.white,
            ),
          ),
        ),
        Tab(
          child: Text(
            "🏠",
            style: TextStyle(
              fontSize: 20.0,
              fontFamily: 'Lora',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _drawer() {
    return Drawer(
      elevation: 10.0,
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        color: Colors.grey[100],
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage:
                        const ExactAssetImage('assets/images/ds.jpg'),
                    backgroundColor: const Color.fromARGB(255, 200, 220, 238),
                    radius: MediaQuery.of(context).orientation ==
                            Orientation.portrait
                        ? MediaQuery.of(context).size.height * (1.2 / 8) / 3
                        : MediaQuery.of(context).size.height * (2.5 / 8) / 3,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            _menuOptions(Icons.person_outline_rounded, 'Profile'),
            const SizedBox(
              height: 10.0,
            ),
            _menuOptions(Icons.settings, 'Settings'),
            const SizedBox(
              height: 10.0,
            ),
            _menuOptions(Icons.support_outlined, 'Support'),
            const SizedBox(
              height: 10.0,
            ),
            _menuOptions(Icons.description_outlined, 'About'),
            const SizedBox(
              height: 10.0,
            ),
            exitButtonCall(),
            Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_2cghrrpi.json'),
          ],
        ),
      ),
    );
  }

  Widget _menuOptions(IconData icon, String menuOptionIs) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: const Duration(
        milliseconds: 500,
      ),
      closedElevation: 0.0,
      openElevation: 3.0,
      onClosed: (value) {},
      openBuilder: (context, openWidget) {
        if (menuOptionIs == 'Profile') {
          return const ProfileScreen();
        } else if (menuOptionIs == 'Settings') {
          return const SettingsWindow();
        } else if (menuOptionIs == 'Support') {
          return const SupportMenuMaker();
        } else if (menuOptionIs == 'About') {
          return const AboutSection();
        }
        return const Center();
      },
      closedBuilder: (context, closeWidget) {
        return SizedBox(
          height: 60.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.lightBlue,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Text(
                menuOptionIs,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget exitButtonCall() {
    return GestureDetector(
      onTap: () async {
        await SystemNavigator.pop(animated: true);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: const Color.fromARGB(255, 40, 209, 25),
          child: SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.exit_to_app_rounded,
                  color: Colors.yellowAccent,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Exit',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
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
