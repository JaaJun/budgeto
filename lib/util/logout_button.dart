import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../services/auth_service.dart';

class LogoutButton extends StatelessWidget {
  final VoidCallback? onLogout;
  const LogoutButton({super.key, this.onLogout});

  void logUserOut(BuildContext context) async {
    await AuthService().signOut();
    if (onLogout != null) onLogout!();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8.0, bottom: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          GestureDetector(
            onTap: () => logUserOut(context),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey[400],
              ),
              child: Center(child: Text("Logout")),
            ),
          ),
        ],
      ),
    );
  }
}
