import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dashboard_screen/dashboard_screen.dart';
import '../profile_screen/profile_screen.dart';

import '../Feed_Screen/feed_screen.dart';

import '../../common/ui_widgets/common_appbar.dart';

class BottomNavBarNotifier extends StateNotifier<int> {
  BottomNavBarNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

final bottomNavBarProvider = StateNotifierProvider<BottomNavBarNotifier, int>((ref) {
  return BottomNavBarNotifier();
});

class AdaptiveNavBar extends ConsumerWidget {
  const AdaptiveNavBar({super.key});

  static final List<Widget> _widgetOptions = <Widget>[
    const FeedScreen(),
    PopulartyScreen(),
    ProfileScreen(),
  ];


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(bottomNavBarProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return Scaffold(
            appBar: buildAppBar(context),
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (int index) {
                    ref.read(bottomNavBarProvider.notifier).setIndex(index);
                  },
                  selectedIconTheme: const IconThemeData(color: Colors.white),
                  unselectedIconTheme: const IconThemeData(color: Colors.white70),
                  selectedLabelTextStyle: const TextStyle(color: Colors.white),
                  unselectedLabelTextStyle: const TextStyle(color: Colors.white70),
                  backgroundColor: const Color(0xFFF40062),
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Icon(Icons.feed_outlined),
                      label: Text('Feed'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.pages_outlined),
                      label: Text('Page'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text('Profile'),
                    ),
                  ],
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: _widgetOptions.elementAt(selectedIndex),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: _widgetOptions.elementAt(selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: const Color(0xFFF40062),
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.feed_outlined),
                  label: 'Feed',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.pages_outlined),
                  label: 'Page',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white70,
              onTap: (index) {
                ref.read(bottomNavBarProvider.notifier).setIndex(index);
              },
            ),
          );
        }
      },
    );
  }
}
