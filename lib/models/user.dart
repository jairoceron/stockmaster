import 'package:uuid/uuid.dart';

class AppUser {
  final String username;
  final String phone;

  final int idrol;
  final bool isGuest;
  final String deviceId;
  final String platform;

  final int id; // PK
  final String tenantid; // 🔹 ahora String

  final String name;
  final String email;
  final String direccion;
  final String pais;
  final String ciudad;
  final String celular;
  final DateTime? createdAt;

  AppUser({
    required this.username,
    required this.phone,

    required this.idrol,
    this.isGuest = false,
    required this.deviceId,
    required this.platform,
    required this.id,
    required this.tenantid,
    required this.name,
    required this.email,
    required this.direccion,
    required this.pais,
    required this.ciudad,
    required this.celular,
    this.createdAt,
  });

  //final uuid = const Uuid().v4();

  /// Constructor para invitados
  AppUser.guest(String username, {String deviceId = '', String platform = ''})
    : username = username,
      phone = '',

      idrol = 0,
      isGuest = true,
      deviceId = deviceId,
      platform = platform,
      id = 0,
      tenantid = const Uuid().v4(),
      name = '',
      email = '',
      direccion = '',
      pais = '',
      ciudad = '',
      celular = '',
      createdAt = null;

  /// Factory para construir desde JSON
  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      username: json['username'] ?? '',
      phone: json['phone'] ?? '',

      idrol: json['idrol'] ?? 0,
      isGuest: json['isGuest'] ?? false,
      deviceId: json['deviceId'] ?? '',
      platform: json['platform'] ?? '',
      id: json['id'] ?? 0,
      tenantid: json['tenantid']?.toString() ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      direccion: json['direccion'] ?? '',
      pais: json['pais'] ?? '',
      ciudad: json['ciudad'] ?? '',
      celular: json['celular'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
    );
  }

  /// Conversión a JSON
  Map<String, dynamic> toJson() => {
    "username": username,
    "phone": phone,

    "idrol": idrol,
    "isGuest": isGuest,
    "deviceId": deviceId,
    "platform": platform,
    "id": id,
    "tenantid": tenantid,
    "name": name,
    "email": email,
    "direccion": direccion,
    "pais": pais,
    "ciudad": ciudad,
    "celular": celular,
    "createdAt": createdAt?.toIso8601String(),
  };

  /// Getter calculado
  bool get isGuestUser => isGuest;

  /// Método copyWith para actualizaciones parciales
  AppUser copyWith({
    String? username,
    String? phone,
    String? idbusiness,
    int? idrol,
    bool? isGuest,
    String? deviceId,
    String? platform,
    int? id,
    String? tenantid,
    String? name,
    String? email,
    String? direccion,
    String? pais,
    String? ciudad,
    String? celular,
    DateTime? createdAt,
  }) {
    return AppUser(
      username: username ?? this.username,
      phone: phone ?? this.phone,

      idrol: idrol ?? this.idrol,
      isGuest: isGuest ?? this.isGuest,
      deviceId: deviceId ?? this.deviceId,
      platform: platform ?? this.platform,
      id: id ?? this.id,
      tenantid: tenantid ?? this.tenantid,
      name: name ?? this.name,
      email: email ?? this.email,
      direccion: direccion ?? this.direccion,
      pais: pais ?? this.pais,
      ciudad: ciudad ?? this.ciudad,
      celular: celular ?? this.celular,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return '''
AppUser(
  username: $username,
  phone: $phone,
  idrol: $idrol,
  isGuest: $isGuest,
  deviceId: $deviceId,
  platform: $platform,
  id: $id,
  tenantid: $tenantid,
  name: $name,
  email: $email,
  direccion: $direccion,
  pais: $pais,
  ciudad: $ciudad,
  celular: $celular,
  createdAt: ${createdAt?.toIso8601String()}
)
''';
  }
}
