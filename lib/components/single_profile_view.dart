

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/profile.dart';
import '../realm/realm_services.dart';

class ProfileTile extends StatelessWidget {
  final Profile profile;

  const ProfileTile({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final realmServices = Provider.of<RealmServices>(context);

    return ListTile(
      title: Text(profile.name),
      subtitle: Text(profile.email),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: () => _showDeleteConfirmationDialog(context, realmServices),
      ),
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(profile.sex),
          const SizedBox(height: 4),
          Text(profile.isAdmin ? 'Admin' : 'User'),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, RealmServices realmServices) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Profile'),
        content: const Text('Are you sure you want to delete this profile?'),
        actions: [
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              realmServices.deleteProfile(profile);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
