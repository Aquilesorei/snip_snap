

import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;


 Function onClick;
 ServiceCard({super.key, required this.title, required this.description, required this.iconData,required this.onClick});

  @override
  Widget build(BuildContext context) {
  return  GestureDetector(
    onTap: () => onClick(),
    child : Card(
      elevation: 2.0,
      child: ListTile(
        leading: Icon(iconData),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          description,
          style: const TextStyle(fontSize: 16),
        ),

        trailing: const Icon(Icons.navigate_next, color: Colors.black,size: 40,),
      ),
    ));
  }
}