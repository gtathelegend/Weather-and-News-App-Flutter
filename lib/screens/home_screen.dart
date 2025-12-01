import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Welcome to the Weather and News App!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'This app is made by Vedaang Sharma. You can view weather for your city by searching it in the search bar and also view news headlines. Thanks for using it.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.linkedin),
                  onPressed: () => _launchURL('https://linkedin.com/in/vedaangsharma2006'),
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.github),
                  onPressed: () => _launchURL('https://github.com/gtathelegend'),
                ),
                IconButton(
                  icon: const Icon(Icons.mail),
                  onPressed: () => _launchURL('mailto:vedaangsharma2006@gmail.com'),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildDashboardCard(
              context,
              title: 'Weather',
              icon: Icons.wb_sunny,
              color: Colors.yellow,
              onTap: () => Navigator.pushNamed(context, '/weather'),
            ),
            const SizedBox(height: 16),
            _buildDashboardCard(
              context,
              title: 'News',
              icon: Icons.article,
              color: Colors.cyan,
              onTap: () => Navigator.pushNamed(context, '/news'),
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 70, color: color),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
