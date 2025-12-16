class NotificationModel {
  String id;
  String title;
  String body;
  DateTime time;
  String type;

  NotificationModel({required this.title, required this.body, required this.time, required this.type, required this.id});

  // Convertir a Map para guardar en SQLite
  Map<String, dynamic> toMap(String id) {
    return {
      'id': id,          // Necesitas generar un ID único
      'title': title,
      'body': body,
      'time': time.toIso8601String(), // Guardamos como texto
      'type': type,
    };
  }

  // Crear objeto desde Map (cuando lees de la base)
  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'],
      title: map['title'],
      body: map['body'],
      time: DateTime.parse(map['time']),
      type: map['type'],
    );
  }

}
