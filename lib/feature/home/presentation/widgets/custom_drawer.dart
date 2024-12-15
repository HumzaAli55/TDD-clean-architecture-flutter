import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mock_api_practice/feature/login/presentation/pages/login_screen.dart';
import 'package:mock_api_practice/injection_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
   CustomDrawer({super.key,});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green.shade400,
              borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10))// Matches your theme color
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    color: Colors.green.shade400,
                    size: 40,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "Delivery address",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "92 High Street, London",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Drawer Items
          ListTile(
            leading: Icon(Icons.home, color: Colors.black),
            title: Text("Home"),
            onTap: () {
              // Navigate to Home Screen
            },
          ),
          ListTile(
            leading: Icon(Icons.category, color: Colors.black),
            title: Text("Categories"),
            onTap: () {
              // Navigate to Categories Screen
            },
          ),
          ListTile(
            leading: Icon(Icons.local_offer, color: Colors.black),
            title: Text("Flash Sale"),
            onTap: () {
              // Navigate to Flash Sale Screen
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.black),
            title: Text("Favorites"),
            onTap: () {
              // Navigate to Favorites Screen
            },
          ),
          ListTile(
            leading: Icon(Icons.person, color: Colors.black),
            title: Text("Profile"),
            onTap: () {
              // Navigate to Profile Screen
            },
          ),

          // Divider
          Spacer(),
          Divider(color: Colors.grey.shade300),

          // Logout Button
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () async {
             await sl<SharedPreferences>().clear();
             if(context.mounted) Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LoginScreen()),(route)=>false);
            },
          ),
        ],
      ),
    );
  }
}
