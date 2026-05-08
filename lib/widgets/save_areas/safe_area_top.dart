import 'package:flutter/material.dart';

// Space for top area page
class SafeAreaTop extends StatefulWidget {
  @override
  _SafeAreaTopState createState() => _SafeAreaTopState();
}

class _SafeAreaTopState extends State<SafeAreaTop> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).padding.top,
    );
  }
}
