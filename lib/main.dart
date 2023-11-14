import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';

final List<Widget> children = <Widget>[
  for (int i = 0; i < 10; i++)
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.deepPurple,
        height: 400,
      ),
    )
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // home: AdaptiveScaffoldExample(),
      home: SlotLayoutExample(),
    );
  }
}

class AdaptiveScaffoldExample extends StatefulWidget {
  const AdaptiveScaffoldExample({super.key});

  @override
  State<AdaptiveScaffoldExample> createState() =>
      _AdaptiveScaffoldExampleState();
}

class _AdaptiveScaffoldExampleState extends State<AdaptiveScaffoldExample> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      smallBreakpoint: const WidthPlatformBreakpoint(end: 700),
      mediumBreakpoint: const WidthPlatformBreakpoint(begin: 700, end: 1000),
      largeBreakpoint: const WidthPlatformBreakpoint(begin: 1000),
      useDrawer: false,
      selectedIndex: _selectedTab,
      onSelectedIndexChange: (int index) {
        setState(() {
          _selectedTab = index;
        });
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.inbox_outlined),
          selectedIcon: Icon(Icons.inbox),
          label: 'Inbox',
        ),
        NavigationDestination(
          icon: Icon(Icons.article_outlined),
          selectedIcon: Icon(Icons.article),
          label: 'Articles',
        ),
        NavigationDestination(
          icon: Icon(Icons.chat_outlined),
          selectedIcon: Icon(Icons.chat),
          label: 'Chat',
        ),
        NavigationDestination(
          icon: Icon(Icons.video_call_outlined),
          selectedIcon: Icon(Icons.video_call),
          label: 'Video',
        ),
        NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Home',
        ),
      ],
      body: (_) => GridView.count(
        crossAxisCount: 2,
        children: children,
      ),
      smallBody: (_) => ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) => children[index],
      ),
      secondaryBody: (_) => Container(
        color: Colors.amber,
      ),
      smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
    );
  }
}

class SlotLayoutExample extends StatefulWidget {
  const SlotLayoutExample({super.key});

  @override
  State<SlotLayoutExample> createState() => _SlotLayoutExampleState();
}

class _SlotLayoutExampleState extends State<SlotLayoutExample> {
  List<NavigationDestination> destinations = [
    const NavigationDestination(
      icon: Icon(Icons.inbox_outlined),
      selectedIcon: Icon(Icons.inbox),
      label: 'Inbox',
    ),
    const NavigationDestination(
      icon: Icon(Icons.article_outlined),
      selectedIcon: Icon(Icons.article),
      label: 'Articles',
    ),
    const NavigationDestination(
      icon: Icon(Icons.chat_outlined),
      selectedIcon: Icon(Icons.chat),
      label: 'Chat',
    ),
    const NavigationDestination(
      icon: Icon(Icons.video_call_outlined),
      selectedIcon: Icon(Icons.video_call),
      label: 'Video',
    ),
    const NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home),
      label: 'Inbox',
    ),
  ];
  static int _selectedNavigation = 0;
  @override
  Widget build(BuildContext context) {
    return AdaptiveLayout(
      primaryNavigation: SlotLayout(
        config: <Breakpoint, SlotLayoutConfig>{
          Breakpoints.medium: SlotLayout.from(
            key: const Key('Primary Navigation Menu'),
            inAnimation: AdaptiveScaffold.leftOutIn,
            builder: (context) => AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _selectedNavigation,
              onDestinationSelected: (int newIndex) {
                setState(() {
                  _selectedNavigation = newIndex;
                });
              },
              leading: const Icon(Icons.menu),
              destinations: destinations
                  .map((_) => AdaptiveScaffold.toRailDestination(_))
                  .toList(),
              backgroundColor: Colors.blue,
              selectedIconTheme: const IconThemeData(color: Colors.red),
              unselectedIconTheme: const IconThemeData(color: Colors.yellow),
              selectedLabelTextStyle: const TextStyle(color: Colors.purple),
              unSelectedLabelTextStyle: const TextStyle(color: Colors.green),
            ),
          ),
          Breakpoints.large: SlotLayout.from(
            key: const Key('Primary Navigation Large'),
            inAnimation: AdaptiveScaffold.leftOutIn,
            builder: (_) => AdaptiveScaffold.standardNavigationRail(
              selectedIndex: _selectedNavigation,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedNavigation = index;
                });
              },
              extended: true,
              leading: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    'REPLY',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Icon(Icons.menu_open),
                ],
              ),
              destinations: destinations
                  .map((_) => AdaptiveScaffold.toRailDestination(_))
                  .toList(),
              backgroundColor: Colors.teal,
              selectedIconTheme: const IconThemeData(color: Colors.orange),
              unselectedIconTheme: const IconThemeData(color: Colors.pink),
              selectedLabelTextStyle: const TextStyle(color: Colors.brown),
              unSelectedLabelTextStyle: const TextStyle(color: Colors.black),
            ),
          ),
        },
      ),
      body: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.small: SlotLayout.from(
          key: const Key('Body Small'),
          builder: (context) => ListView.builder(
            itemCount: children.length,
            itemBuilder: (context, index) => children[index],
          ),
        ),
        Breakpoints.mediumAndUp: SlotLayout.from(
          key: const Key('Body Medium'),
          builder: (_) => GridView.count(
            crossAxisCount: 2,
            children: children,
          ),
        ),
      }),
      bottomNavigation: SlotLayout(config: <Breakpoint, SlotLayoutConfig>{
        Breakpoints.small: SlotLayout.from(
          key: const Key('Bottom navigation small'),
          inAnimation: AdaptiveScaffold.bottomToTop,
          outAnimation: AdaptiveScaffold.topToBottom,
          builder: (_) => AdaptiveScaffold.standardBottomNavigationBar(
            destinations: destinations,
            currentIndex: _selectedNavigation,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedNavigation = index;
              });
            },
          ),
        ),
      }),
    );
  }
}
