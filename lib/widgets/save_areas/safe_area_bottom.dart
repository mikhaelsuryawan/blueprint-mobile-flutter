import 'package:flutter/material.dart';

// Space for bottom area page
class SafeAreaBottom extends StatefulWidget {
  @override
  _SafeAreaBottomState createState() => _SafeAreaBottomState();
}

class _SafeAreaBottomState extends State<SafeAreaBottom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).padding.bottom,
    );
  }
}
