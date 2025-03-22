// lib/mission_details_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class MissionDetailsScreen extends StatefulWidget {
  final String category;

  const MissionDetailsScreen({super.key, required this.category});

  @override
  State<MissionDetailsScreen> createState() => _MissionDetailsScreenState();
}

class _MissionDetailsScreenState extends State<MissionDetailsScreen> {
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _criteriaController = TextEditingController();

  Future<void> _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'gaidajis@gmail.com',
      queryParameters: {
        'subject': 'New Mission: ${widget.category}',
        'body': 'Category: ${widget.category}\n'
            'Price: ${_priceController.text}\n'
            'Description: ${_descriptionController.text}\n'
            'Location: ${_locationController.text}\n'
            'Due Date: ${_dueDateController.text}\n'
            'Criteria: ${_criteriaController.text}',
      },
    );

    final canLaunch = await canLaunchUrlString(emailLaunchUri.toString());
    if (!mounted) return;
    if (canLaunch) {
      await launchUrlString(emailLaunchUri.toString());
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mission details sent via email!')),
      );
      Navigator.pop(context);
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not launch email app.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = const Color(0xFF2962FF);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(
          'New ${widget.category} Mission',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Create a new ${widget.category} mission',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor)),
            const SizedBox(height: 16),
            TextField(controller: _priceController, decoration: const InputDecoration(labelText: 'Price')),
            const SizedBox(height: 8),
            TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(labelText: 'Description')),
            const SizedBox(height: 8),
            TextField(
                controller: _locationController, decoration: const InputDecoration(labelText: 'Location')),
            const SizedBox(height: 8),
            TextField(
                controller: _dueDateController, decoration: const InputDecoration(labelText: 'Due Date')),
            const SizedBox(height: 8),
            TextField(
                controller: _criteriaController,
                maxLines: 2,
                decoration: const InputDecoration(labelText: 'Criteria')),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: _sendEmail,
              child: const Text('Send Mission', style: TextStyle(fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}
