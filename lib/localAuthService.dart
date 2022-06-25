import 'package:local_auth/local_auth.dart';

class LocalAuthService {
  final LocalAuthentication auth;

  LocalAuthService({required this.auth});

  Future<bool> isBiometricAvailable() async {
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    return canAuthenticateWithBiometrics || await auth.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    return await auth.authenticate(
      localizedReason: 'Confirme sua senha ou biometria para acessar o APP Password Manager',
    );
  }
}