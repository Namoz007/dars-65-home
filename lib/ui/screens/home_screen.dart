import 'package:dars_65/ui/screens/qr_code_generate_screen.dart';
import 'package:dars_65/ui/screens/qr_code_history.dart';
import 'package:dars_65/ui/screens/qr_code_scaner.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _index = 0;
  List<Widget> _screens = [
    QrCodeGenerateScreen(),
    QrCodeHistory(),
    QrCodeScaner()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_index],
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _index = 2;
          });
        },
        child: Icon(Icons.qr_code_scanner),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.qr_code),label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.history),label: '')
        ],
        onTap: (value){
          setState(() {
            _index = value;
          });
        },
      ),
    );
  }
}
