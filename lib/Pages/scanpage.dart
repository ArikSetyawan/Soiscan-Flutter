import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:soiscan/theme.dart';


class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final _currentIndex = 2;

  final MobileScannerController _mobileScannerController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index != _currentIndex) {
            switch (index) {
              case 0:
                context.goNamed('dashboard');
                break;
              case 1:
                context.goNamed('search');
                break;
              case 2:
                context.goNamed('scan');
                break;
              case 3:
                context.goNamed('history');
                break;
              case 4:
                context.goNamed('account');
                break;
            }
          }
        },
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.window),
            title: const Text("Home"),
            selectedColor: darkgreyColor,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.search),
            title: const Text("Search"),
            selectedColor: darkgreyColor,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon:const Icon(Icons.add_circle_outline),
            title:const  Text("Scan"),
            selectedColor: darkgreyColor,
          ),

          /// Search
          SalomonBottomBarItem(
            icon:const Icon(Icons.query_builder),
            title:const Text("History"),
            selectedColor: darkgreyColor,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: darkgreyColor,
          ),
        ],
      ),
      body: MobileScanner(
        controller: _mobileScannerController,
        onDetect: (barcodes) {
          final value = barcodes.barcodes.first.rawValue;
          if (value != null) {
            context.goNamed('scannedUser', queryParameters: {"UserID":value});
          }
        },
      )
    );
  }
}