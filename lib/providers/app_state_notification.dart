import 'package:flutter/material.dart';

import '../db/data_base_helper.dart';
import '../models/Notification.dart';
import '../services/notification_service.dart';

class AppStateNotification extends ChangeNotifier {

  List<NotificationModel> _notifications = [];

  List<NotificationModel> get notifications => _notifications;

  // Cargar las notificaciones de la base de datos
  Future<void> loadNotifications() async {
    final List<Map<String, dynamic>> maps = await DataBaseHelper.instance.getNotificaction();
    _notifications = List.generate(maps.length, (i) {
      return NotificationModel.fromMap(maps[i]);
    });
    notifyListeners();  // Notificar a los widgets escuchando esta lista
  }

  //Eliminar una notificación
  Future<void> deleteNotification(String id) async {
    await DataBaseHelper.instance.deleteNotificaction(id);
    await cancelNotification(id);
    _notifications.removeWhere((notification) => notification.id == id);
    notifyListeners();
  }
}