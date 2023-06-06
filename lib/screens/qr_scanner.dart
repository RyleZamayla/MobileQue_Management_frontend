import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mobilequemanagement_frontend/screens/materials/qr_scanner_overlay.dart';

// ignore: must_be_immutable
class QrScanner extends StatelessWidget {
  QrScanner({Key? key}) : super(key: key);

  MobileScannerController cameraController = MobileScannerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFfafafa),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF05046a),
        title: const Text('QR SCANNER',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1
          ),
        ),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const[
                    Text("Align the QR Code to your Camera",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Scanning will start automatically",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      ),
                    )
                  ],
                )
            ),
            Expanded(
              flex: 4,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    MobileScanner(
                      controller: cameraController,
                      onDetect: (capture) {
                        final List<Barcode> barcodes = capture.barcodes;
                        final Uint8List? image = capture.image;
                        for (final barcode in barcodes) {
                          debugPrint('Barcode found! ${barcode.rawValue}');
                        }
                      },
                    ),
                    const QRScannerOverlay(overlayColour: Color(0xFFfafafa))
                  ],
                )
            ),
            Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text('If the QR scanner seems to be unresponsive, please restart the app.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.black,
                    fontSize: 14,
                    letterSpacing: 1
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
