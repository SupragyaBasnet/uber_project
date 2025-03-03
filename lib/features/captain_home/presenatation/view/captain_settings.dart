import 'package:flutter/material.dart';

class CaptainSettings extends StatelessWidget {
  final VoidCallback onClose;

  CaptainSettings({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Captain Settings"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: onClose,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(radius: 50, backgroundImage: AssetImage("assets/profile.jpg")),
            SizedBox(height: 10),
            Text("Captain Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.palette),
              title: Text("Theme"),
              trailing: DropdownButton<String>(
                items: ["Light", "Dark"].map((String theme) {
                  return DropdownMenuItem<String>(
                    value: theme,
                    child: Text(theme),
                  );
                }).toList(),
                onChanged: (value) {},
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pushNamed(context, "/login");
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text("Delete Account"),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
