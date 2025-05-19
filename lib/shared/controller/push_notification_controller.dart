import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Initialisiert Push Notifications (inkl. iOS APNs und FCM Token)
  Future<void> init(String userId) async {
    print('init');
    try {
      // 1. Berechtigungen anfordern
      final settings = await _messaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        print('Push permission denied.');
        return;
      }

      // 2. Warten auf APNs Token auf iOS
      if (Platform.isIOS) {
        String? apnsToken;
        int retry = 0;
        while ((apnsToken = await _messaging.getAPNSToken()) == null &&
            retry < 10) {
          await Future.delayed(const Duration(milliseconds: 300));
          retry++;
        }
        if (apnsToken == null) {
          print("APNs Token konnte nicht abgerufen werden.");
          return;
        }
        print("APNs Token: $apnsToken");
      }

      // 3. FCM Token abrufen
      final fcmToken = await _messaging.getToken();
      if (fcmToken == null) {
        print("FCM Token konnte nicht abgerufen werden.");
        return;
      }

      print("FCM Token: $fcmToken");

      // 4. Token im Firestore speichern
      await _firestore.collection('profiles').doc(userId).update({
        'fcmToken': fcmToken,
      });

      // 5. Token Refresh Listener
      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
        await _firestore.collection('profiles').doc(userId).update({
          'fcmToken': newToken,
        });
        print("FCM Token wurde aktualisiert: $newToken");
      });
    } catch (e) {
      print("PushNotificationService init error: $e");
    }
  }
}
