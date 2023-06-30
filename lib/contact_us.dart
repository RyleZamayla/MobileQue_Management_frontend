import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF05046a),
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'If you have any questions or feedback, please feel free to reach out to us:',
            ),
            const SizedBox(height: 16),
            ContactItem(
              icon: Icons.mail,
              title: 'Email',
              subtitle: 'contact@example.com',
              onTap: () {
                // Handle email contact
              },
            ),
            ContactItem(
              icon: Icons.phone,
              title: 'Phone',
              subtitle: '+(639) 4561-78901',
              onTap: () {
                // Handle phone contact
              },
            ),
            ContactItem(
              icon: Icons.location_on,
              title: 'Address',
              subtitle: 'Claro M. Recto Avenue, Lapasan 9000 Cagayan de Oro City, Philippines',
              onTap: () {
                // Handle address contact
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ContactItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ContactItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }
}
