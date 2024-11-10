import 'package:flutter/material.dart';

class AboutAppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  // App Icon
                  Icon(
                    Icons.info,
                    size: 80,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 16),

                  // App Name
                  Text(
                    'My App',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),

                  // App Version
                  Text(
                    'Version 1.0.0',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),

            // Description
            Text(
              'My App is a simple app designed to help you manage your tasks, '
              'track progress, and stay organized. We aim to make your daily tasks easier!',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 24),

            // Contact Section
            Text(
              'Contact Us',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('support@myapp.com'),
              onTap: () {
                // Add email functionality or link here
              },
            ),
            ListTile(
              leading: Icon(Icons.web),
              title: Text('Visit our website'),
              onTap: () {
                // Add website link functionality here
              },
            ),
          ],
        ),
      ),
    );
  }
}
