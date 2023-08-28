import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:reddit_clone/core/constants/constants.dart';
import 'package:reddit_clone/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone/features/home/delegates/search_community_delegate.dart';
import 'package:reddit_clone/features/home/drawers/community_list_drawer.dart';
import 'package:reddit_clone/features/home/drawers/profile_drawer.dart';
import 'package:reddit_clone/theme/pallete.dart';
import 'package:routemaster/routemaster.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  // int _page = 0;

  void displayDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void displayEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  // void onPageChanged(int page) {
  //   setState(() {
  //     _page = page;
  //   });
  // }

  void navigateToType(BuildContext context, String type) {
    Routemaster.of(context).push('/add-post/$type');
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider)!;
    final isGuest = !user.isAuthenticated;
    final currentTheme = ref.watch(themeNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: false,
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => displayDrawer(context),
          );
        }),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                  context: context, delegate: SearchCommunityDelegate(ref));
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Routemaster.of(context).push('/add-post');
            },
            icon: const Icon(Icons.add),
          ),
          Builder(builder: (context) {
            return IconButton(
              icon: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePic),
              ),
              onPressed: () => displayEndDrawer(context),
            );
          }),
        ],
      ),
      body: Constants.tabWidgets[0],
      drawer: const CommunityListDrawer(),
      endDrawer: isGuest ? null : const ProfileDrawer(),
      floatingActionButton: isGuest
          ? null
          : SpeedDial(
              icon: Icons.add,
              backgroundColor: currentTheme.indicatorColor,
              overlayColor: Colors.black,
              overlayOpacity: 0.4,
              spaceBetweenChildren: 12,
              spacing: 12,
              children: [
                SpeedDialChild(
                  child: Icon(Icons.text_fields),
                  backgroundColor: Colors.red,
                  label: "Text Post",
                  onTap: () => navigateToType(context, 'text'),
                ),
                SpeedDialChild(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.image),
                  label: "Image Post",
                  onTap: () => navigateToType(context, 'image'),
                ),
                SpeedDialChild(
                  backgroundColor: Colors.yellow,
                  child: Icon(Icons.link),
                  label: "Link Post",
                  onTap: () => navigateToType(context, 'link'),
                ),
              ],
            ),
      // bottomNavigationBar: isGuest || kIsWeb
      //     ? null
      //     : CupertinoTabBar(
      //         activeColor: currentTheme.iconTheme.color,
      //         backgroundColor: currentTheme.backgroundColor,
      //         items: const [
      //           BottomNavigationBarItem(
      //             icon: Icon(Icons.home),
      //             label: '',
      //           ),
      //           BottomNavigationBarItem(
      //             icon: Icon(Icons.add),
      //             label: '',
      //           ),
      //         ],
      //         onTap: onPageChanged,
      //         currentIndex: _page,
      //       ),
    );
  }
}
