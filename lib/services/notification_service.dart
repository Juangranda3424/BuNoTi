import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

import '../db/data_base_helper.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


int generateNotificationId() {
  return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}

DateTime parseDateTime(String value) {
  final parts = value.split(' ');
  final date = parts[0].split('/');
  final time = parts[1].split(':');

  return DateTime(
    int.parse(date[2]),
    int.parse(date[1]),
    int.parse(date[0]),
    int.parse(time[0]),
    int.parse(time[1]),
  );
}

bool isToday(DateTime date, String title, String body){
  if(date.isBefore(DateTime.now()) || title.isEmpty || body.isEmpty ){
    return false;
  }
  return true;
}

NotificationDetails notificationDetails() {
  return const NotificationDetails(
    android: AndroidNotificationDetails(
      'canal_programado',
      'Notificaciones Programadas',
      importance: Importance.max,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );
}


Future<bool> scheduleNotification( String title, String body, DateTime scheduledDate, String type) async {

  if(!isToday(scheduledDate, title, body)){
    return false;
  }

  final int id = generateNotificationId();
  await flutterLocalNotificationsPlugin.zonedSchedule(
    id, // id
    title, // title
    body, // body
    tz.TZDateTime.from(scheduledDate, tz.local),
    notificationDetails(),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  );

  //Guardar en la base de datos local
  await DataBaseHelper
      .instance
      .insertNotificaction({
        'id': id,
        'title': title,
        'body': body,
        'time': tz.TZDateTime.from(scheduledDate, tz.local).toString(),
        'type': type
      });

  return true;
}

Future<void> showSimpleNotification(String title, String body) async {
  final int id = generateNotificationId();

  await flutterLocalNotificationsPlugin.show(
    id,
    title,
    body,
    notificationDetails(),
  );
}


Future<bool> scheduleDailyNotification(
    int id,
    String title,
    String body,
    DateTime dateTime,
    String type
    ) async {

  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime.from(dateTime, tz.local),

    notificationDetails(),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.time,

  );

  //Guardar en la base de datos local
  await DataBaseHelper
      .instance
      .insertNotificaction({
    'id': id,
    'title': title,
    'body': body,
    'time': tz.TZDateTime.from(dateTime, tz.local).toString(),
    'type': type
  });

  return true;
}

Future<bool> scheduleWeeklyNotification(
    int id,
    String title,
    String body,
    DateTime dateTime,
    String type
    ) async {

  await flutterLocalNotificationsPlugin.zonedSchedule(
    id,
    title,
    body,
    tz.TZDateTime.from(dateTime, tz.local), // Zona horaria local
    notificationDetails(),
    androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime, // Repetir el mismo día de la semana y hora
  );

  //Guardar en la base de datos local
  await DataBaseHelper
      .instance
      .insertNotificaction({
    'id': id,
    'title': title,
    'body': body,
    'time': tz.TZDateTime.from(dateTime, tz.local).toString(),
    'type': type
  });

  return true;
}

//Eliminar la notificacion del celular
Future<void> cancelNotification(String id) async {
  await flutterLocalNotificationsPlugin.cancel(int.parse(id));
}


