import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';

class PengaturanPage extends StatelessWidget {
  const PengaturanPage({Key? key}) : super(key: key);

  Future<void> _showDeviceInfo(BuildContext context) async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    String deviceDetails = "";

    try {
      final deviceInfo = await deviceInfoPlugin.deviceInfo; // API generik
      final allInfo = deviceInfo.data; // Map<String, dynamic>
      
      // Buat string dari semua key-value
      deviceDetails = allInfo.entries.map((e) => "${e.key}: ${e.value}").join("\n");
    } catch (e) {
      deviceDetails = "Gagal mengambil info device: $e";
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Info Device"),
        content: SingleChildScrollView(child: Text(deviceDetails)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pengaturan")),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("Info Device"),
            onTap: () => _showDeviceInfo(context),
          ),
        ],
      ),
    );
  }
}
