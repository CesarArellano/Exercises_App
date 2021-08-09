import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';

class Page1 extends StatefulWidget {

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {

  LocalAuthentication _localAuth = new LocalAuthentication();
  bool canCheckBiometrics = false;

  @override
  void initState() {
    _localAuth.canCheckBiometrics.then((value) { 
      canCheckBiometrics = value;
      setState(() {});
    });
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing Fingerprint'),
      ),
      body: Center(
        child: Text('Page 1'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.fingerprint),
        onPressed: () async {

          if(canCheckBiometrics) {
            print('Biometrics Available');
            bool didAuthenticate = await _localAuth.authenticate(
              androidAuthStrings: AndroidAuthMessages(
                signInTitle: 'Autenticación requerida',
                biometricHint: 'Verificando su identidad',
                deviceCredentialsRequiredTitle: 'Toque el sensor de huella',
                cancelButton: 'Cancelar',
                deviceCredentialsSetupDescription: 'Toque el sensor de huella',
                biometricRequiredTitle: 'Ingrese su huella',
                biometricNotRecognized: 'Huella no reconocida',
                biometricSuccess: 'Huella reconocida'
              ),
              localizedReason: 'Por favor autenticate para mostrar su saldo',
              iOSAuthStrings: IOSAuthMessages(cancelButton: 'Cancelar')
            );

            ( didAuthenticate )
              ? alertDialog(context, 'Validación correcta', false)
              : alertDialog(context, 'Validación incorrecta', true);

          } else {
            print('Biometrics Unavailable');
          }
        },
      )
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
}