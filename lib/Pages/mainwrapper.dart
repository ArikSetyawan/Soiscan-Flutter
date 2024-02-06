import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:soiscan/theme.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _currentIndex = 0;

  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkgreyColor,
        shape: const CircleBorder(),
        onPressed: () {
          context.pushNamed('scan');
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 60,
        color: Colors.white,
        surfaceTintColor: Colors.white,
        shadowColor: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.window,
                color: _currentIndex == 0 ? darkgreyColor : Colors.grey,
              ),
              onPressed: () {
                int index = 0;
                setState(() {
                  _currentIndex = index;
                });
                _goBranch(index);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.search,
                color: _currentIndex == 1 ? darkgreyColor : Colors.grey,
              ),
              onPressed: () {
                int index = 1;
                setState(() {
                  _currentIndex = index;
                });
                _goBranch(index);
              },
            ),
            Opacity(
              opacity: 0,
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: _currentIndex == 0 ? darkgreyColor : Colors.grey,
                ),
                onPressed: () {},
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.query_builder,
                color: _currentIndex == 2 ? darkgreyColor : Colors.grey,
              ),
              onPressed: () {
                int index = 2;
                setState(() {
                  _currentIndex = index;
                });
                _goBranch(index);
              },
            ),
            IconButton(
              icon: Icon(
                Icons.person,
                color: _currentIndex == 3 ? darkgreyColor : Colors.grey,
              ),
              onPressed: () {
                int index = 3;
                setState(() {
                  _currentIndex = index;
                });
                _goBranch(index);
              },
            ),
          ],
        ),
      ),
    );
  }
}