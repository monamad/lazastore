import 'package:flutter/material.dart';
import 'package:lazastore/core/ui_helper/custom_app_bar.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  leadingIcon: const Icon(
                    Icons.menu,
                    size: 20,
                    color: Colors.black,
                  ),
                  onLeadingTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  action: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
                SizedBox(height: 8),
                const Text(
                  'Hello',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  'Welcome To Laza.',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
