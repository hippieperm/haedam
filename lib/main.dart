import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'core/routing/app_router.dart';
import 'core/theme/app_theme.dart';
import 'shared/services/firebase_service.dart';
import 'features/auth/data/models/user_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase 초기화
  await FirebaseService.instance.initialize();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return Container(
      color: Colors.black, // 좌우 여백 색상 지정
      child: Center(
        child: SizedBox(
          width: 1800,
          child: MaterialApp.router(
            title: '해담',
            theme: AppTheme.darkTheme,
            routerConfig: router,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}
