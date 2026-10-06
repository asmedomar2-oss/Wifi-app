import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wifi_scan/wifi_scan.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const WifiScannerScreen(),
    );
  }
}

class WifiScannerScreen extends StatefulWidget {
  const WifiScannerScreen({super.key});

  @override
  State<WifiScannerScreen> createState() => _WifiScannerScreenState();
}

class _WifiScannerScreenState extends State<WifiScannerScreen> {
  List<WiFiAccessPoint> accessPoints = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _startScan();
  }

  Future<void> _startScan() async {
    setState(() => isLoading = true);
    if (await Permission.location.request().isGranted) {
      final canScan = await WiFiScan.instance.canStartScan();
      if (canScan == CanStartScan.yes) {
        await WiFiScan.instance.startScan();
        accessPoints = await WiFiScan.instance.getScannedResults();
      }
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réseaux Wi-Fi'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: isLoading ? null : _startScan,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: accessPoints.length,
              itemBuilder: (context, index) {
                final ap = accessPoints[index];
                return ListTile(
                  leading: const Icon(Icons.wifi),
                  title: Text(ap.ssid.isEmpty ? 'Réseau masqué' : ap.ssid),
                  subtitle: Text('${ap.level} dBm'),
                );
              },
            ),
    );
  }
}
