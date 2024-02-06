import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';


class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {

  final MobileScannerController _mobileScannerController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MobileScanner(
        controller: _mobileScannerController,
        onDetect: (barcodes) {
          final value = barcodes.barcodes.first.rawValue;
          if (value != null) {
            _mobileScannerController.stop();
            context.pushNamed('scannedUser', queryParameters: {"UserID":value}).then((value) {
              _mobileScannerController.start();
            });
          }
        },
      )
    );
  }
}