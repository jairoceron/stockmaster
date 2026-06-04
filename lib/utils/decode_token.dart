import 'dart:convert';
void printDecodedIdToken(String idToken) {
  try {
    final parts = idToken.split('.');
    if (parts.length != 3) {
      print("❌ Token inválido, no tiene 3 partes");
      return;
    }

    // El payload está en la segunda parte (index 1)
    final payloadBase64 = parts[1];
    final normalized = base64Url.normalize(payloadBase64);
    final payloadString = utf8.decode(base64Url.decode(normalized));

    print("📜 Payload decodificado del idToken:");
    print(payloadString);
  } catch (e) {
    print("❌ Error decodificando idToken: $e");
  }
}