import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityStatusWidget extends StatefulWidget {
  final Widget child;

  const ConnectivityStatusWidget({required this.child});

  @override
  _ConnectivityStatusWidgetState createState() =>
      _ConnectivityStatusWidgetState();
}

class _ConnectivityStatusWidgetState extends State<ConnectivityStatusWidget> {
  final Connectivity _connectivity = Connectivity();
  late bool _isConnected;

  @override
  void initState() {
    super.initState();
    _isConnected = true;
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isConnected ? widget.child : _buildNoInternetWidget();
  }

  Widget _buildNoInternetWidget() {
    return Scaffold(
      body:Center(
        child: Text(
          'No Internet Connection',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),
        ),
      ),
    );
  }
}
