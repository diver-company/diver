import 'package:auto_route/auto_route.dart';
import 'package:diver/core/supabase/supabase.dart';
import 'package:flutter/material.dart';
import 'package:diver/generated/l10n.dart';

@RoutePage()
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> _signOut(BuildContext context) async {
    try {
      await supabase.auth.signOut();

      if (context.mounted) {
        AutoRouter.of(context).replaceNamed('/sign-in');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(S.of(context).errorGeneralApiError),
            )
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Column(
        children: [
          ElevatedButton(
            onPressed: () => _signOut(context),
            child: const Text("Sign out"),
          ),
        ],
      )
    );
  }
}
