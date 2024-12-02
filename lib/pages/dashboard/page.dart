import 'package:final_dacta/constants/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chatify App'),
        centerTitle: true,
      ),
      drawer: Drawer(),
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () {},
        child: Icon(
          Icons.chat,
          color: Colors.white,
        ),
      ),
    );
  }
}
