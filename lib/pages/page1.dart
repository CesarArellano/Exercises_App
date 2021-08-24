import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_local_auth_invisible/flutter_local_auth_invisible.dart';

class Page1 extends StatefulWidget {

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  final LocalAuthentication auth = LocalAuthentication();
  bool _canCheckBiometrics = false;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';

  Future<void> _checkBiometrics() async {
    bool canCheckBiometrics = false;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    List<BiometricType> availableBiometrics = <BiometricType>[];
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
        localizedReason: 'Scan your fingerprint to authenticate',
        useErrorDialogs: true,
        stickyAuth: false,
      );
      if (authenticated) scanQR();
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              ListTile(
                onTap: () => Navigator.pushNamed(context, 'page2'),
                title: Text('In App Review'),
                leading: Icon( Icons.rate_review ),
              )
            ],
          ),
        ),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('Can check biometrics: $_canCheckBiometrics\n'),
            // ignore: deprecated_member_use
            RaisedButton(
              child: const Text('Check biometrics'),
              onPressed: _checkBiometrics,
            ),
            Text('Available biometrics: $_availableBiometrics\n'),
            // ignore: deprecated_member_use
            RaisedButton(
              child: const Text('Get available biometrics'),
              onPressed: _getAvailableBiometrics,
            ),
            Text('Current State: $_authorized\n'),
            // ignore: deprecated_member_use
            RaisedButton(
              child: const Text('Authenticate'),
              onPressed: _authenticate,
            )
          ],
        ),
      ),
    );
  }

  void alertDialog(BuildContext context, String title, bool error) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(  
        title: Text(title),
        content: Icon( 
          (error) ? Icons.error : Icons.check,
          size: 35,
          color: (error) ? Colors.red : Colors.green,
        ),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text((error) ? 'Intentar de nuevo' : 'Ok', style: TextStyle( color: Colors.white )),
            color: Colors.blue,
          )
        ],
      )
    );
  }

  void scanQR() async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
      '#fff', 
      'Cancelar', 
      true, 
      ScanMode.QR
    );
    print(barcodeScanRes);
  }

}