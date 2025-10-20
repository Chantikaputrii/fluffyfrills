import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilPage extends StatefulWidget {
  final String userName;
  final String userEmail;

  const ProfilPage({
    Key? key,
    required this.userName,
    required this.userEmail,
  }) : super(key: key);

  @override
  State<ProfilPage> createState() => _ProfilPageState();
}

class _ProfilPageState extends State<ProfilPage> {
  final _phoneController = TextEditingController();
  DateTime? _selectedDate;
  String _gender = 'Laki-laki';

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _phoneController.text = prefs.getString('phone') ?? '';
      final dobStr = prefs.getString('dob');
      if (dobStr != null && dobStr.isNotEmpty) {
        _selectedDate = DateTime.parse(dobStr);
      }
      _gender = prefs.getString('gender') ?? 'Laki-laki';
    });
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: now,
    );
    if (picked != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('dob', picked.toIso8601String());
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('phone', _phoneController.text);
    await prefs.setString('gender', _gender);

    final dobStr =
        _selectedDate != null ? _selectedDate!.toIso8601String() : '';
    await prefs.setString('dob', dobStr);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Data Profil Tersimpan'),
        content: Text(
          'Nama: ${widget.userName}\n'
          'Email: ${widget.userEmail}\n'
          'Telepon: ${_phoneController.text}\n'
          'Tanggal Lahir: ${_selectedDate != null ? "${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}" : "-"}\n'
          'Gender: $_gender',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Saya"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                widget.userName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                widget.userEmail,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),

            // Nomor Telepon
            const Text('Nomor Telepon'),
            const SizedBox(height: 4),
            GFTextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Masukkan nomor telepon',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 16),

            // Tanggal Lahir
            GFButton(
              onPressed: _pickDate,
              text: _selectedDate == null
                  ? 'Pilih Tanggal Lahir'
                  : 'Tanggal Lahir: ${_selectedDate!.day}-${_selectedDate!.month}-${_selectedDate!.year}',
              color: Colors.pinkAccent,
              fullWidthButton: true,
            ),
            const SizedBox(height: 16),

            // Gender
            const Text('Gender'),
            const SizedBox(height: 4),
            DropdownButton<String>(
              value: _gender,
              items: ['Laki-laki', 'Perempuan']
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _gender = value;
                  });
                }
              },
            ),
            const SizedBox(height: 32),

            // Tombol Simpan
            GFButton(
              onPressed: _saveProfile,
              text: 'Simpan',
              color: Colors.pinkAccent,
              fullWidthButton: true,
            ),
          ],
        ),
      ),
    );
  }
}
