import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:list_me_miko/ui/pages.dart';
import 'package:list_me_miko/helper/notification_helper.dart';

import 'bloc/page/page_bloc.dart';

final FlutterLocalNotificationsPlugin notifsPlugin= FlutterLocalNotificationsPlugin();

Future<void> main() async {
  // await initNotifications(notifsPlugin);
  // requestIOSPermissions(notifsPlugin);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PageBloc()),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper()
      ),
    );
  }
}