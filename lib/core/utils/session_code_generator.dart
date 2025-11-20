import 'dart:math';

// Może być klasą singleton lub prostą funkcją
class SessionCodeGenerator {
  String generate() {
    final random = Random();
    // Generowanie kodu od 100000 do 999999 (6 cyfr)
    final code = random.nextInt(900000) + 100000;
    return code.toString();
  }
}